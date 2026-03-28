import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';
import 'package:vector_tile/vector_tile.dart';
import 'package:vector_tile/util/command.dart';

/// Helper to build a geometry command list for a single point at (x, y).
List<int> _pointGeometry(int x, int y) {
  // MoveTo(1) command = (1 << 3) | 1 = 9
  return [9, Command.zigZagEncode(x), Command.zigZagEncode(y)];
}

/// Helper to build a geometry command list for two points (multi-point).
List<int> _multiPointGeometry(int x1, int y1, int x2, int y2) {
  // MoveTo(2) = (2 << 3) | 1 = 17
  return [
    17,
    Command.zigZagEncode(x1),
    Command.zigZagEncode(y1),
    Command.zigZagEncode(x2 - x1),
    Command.zigZagEncode(y2 - y1),
  ];
}

/// Helper to build a linestring geometry.
/// MoveTo(1) first point, then LineTo(n-1) remaining points.
List<int> _lineStringGeometry(List<List<int>> points) {
  final result = <int>[];
  // MoveTo(1) = 9
  result.add(9);
  result.add(Command.zigZagEncode(points[0][0]));
  result.add(Command.zigZagEncode(points[0][1]));
  // LineTo(n-1)
  final lineToCmd = ((points.length - 1) << 3) | CommandID.LineTo;
  result.add(lineToCmd);
  for (int i = 1; i < points.length; i++) {
    result.add(Command.zigZagEncode(points[i][0] - points[i - 1][0]));
    result.add(Command.zigZagEncode(points[i][1] - points[i - 1][1]));
  }
  return result;
}

/// Helper to build a polygon geometry (single ring, closed).
List<int> _polygonGeometry(List<List<int>> ringPoints) {
  // Use linestring encoding for the ring, then add ClosePath
  final result = _lineStringGeometry(ringPoints);
  // ClosePath(1) = (1 << 3) | 7 = 15
  result.add(15);
  return result;
}

VectorTileFeature _makeFeature({
  required VectorTileGeomType type,
  required List<int> geometryList,
  List<String> keys = const [],
  List<VectorTileValue> values = const [],
  List<int> tags = const [],
  int extent = 4096,
}) {
  return VectorTileFeature(
    id: Int64(1),
    tags: tags,
    type: type,
    geometryList: geometryList,
    extent: extent,
    keys: keys,
    values: values,
  );
}

void main() {
  group('VectorTileFeature.decodePoint', () {
    test('decodes single point', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(25, 17),
      );
      final coords = feature.decodePoint();
      expect(coords, [
        [25, 17]
      ]);
    });

    test('decodes multi-point as separate coordinate pairs', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _multiPointGeometry(5, 7, 3, 2),
      );
      final coords = feature.decodePoint();
      expect(coords, [
        [5, 7],
        [3, 2],
      ]);
    });
  });

  group('VectorTileFeature.decodeLineString', () {
    test('decodes single linestring', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.LINESTRING,
        geometryList: _lineStringGeometry([
          [2, 3],
          [4, 5],
          [6, 7],
        ]),
      );
      final coords = feature.decodeLineString();
      expect(coords.length, 1);
      expect(coords[0], [
        [2, 3],
        [4, 5],
        [6, 7],
      ]);
    });
  });

  group('VectorTileFeature.decodePolygon', () {
    test('decodes single polygon ring', () {
      // CW ring: (0,0) -> (10,0) -> (10,10) -> (0,0)
      final feature = _makeFeature(
        type: VectorTileGeomType.POLYGON,
        geometryList: _polygonGeometry([
          [0, 0],
          [10, 0],
          [10, 10],
        ]),
      );
      final polygons = feature.decodePolygon();
      expect(polygons.length, 1); // one polygon
      expect(polygons[0].length, 1); // one ring
      // Ring points are reversed by the decoder (reversed.toList)
      final ring = polygons[0][0];
      expect(ring.length, 3);
      // Original order: [0,0], [10,0], [10,10] — reversed: [10,10], [10,0], [0,0]
      expect(ring[0], [10, 10]);
      expect(ring[1], [10, 0]);
      expect(ring[2], [0, 0]);
    });
  });

  group('VectorTileFeature.decodeGeometry', () {
    test('decodes Point geometry', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(100, 200),
      );
      final geom = feature.decodeGeometry<GeometryPoint>();
      expect(geom, isNotNull);
      expect(feature.geometryType, GeometryType.Point);
      expect(geom!.coordinates, [100.0, 200.0]);
    });

    test('decodes MultiPoint geometry', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _multiPointGeometry(5, 7, 3, 2),
      );
      final geom = feature.decodeGeometry<GeometryMultiPoint>();
      expect(geom, isNotNull);
      expect(feature.geometryType, GeometryType.MultiPoint);
      expect(geom!.coordinates, [
        [5.0, 7.0],
        [3.0, 2.0],
      ]);
    });

    test('decodes LineString geometry', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.LINESTRING,
        geometryList: _lineStringGeometry([
          [0, 0],
          [10, 10],
        ]),
      );
      final geom = feature.decodeGeometry<GeometryLineString>();
      expect(geom, isNotNull);
      expect(feature.geometryType, GeometryType.LineString);
      expect(geom!.coordinates, [
        [0.0, 0.0],
        [10.0, 10.0],
      ]);
    });

    test('caches geometry on second call', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(5, 10),
      );
      final first = feature.decodeGeometry();
      final second = feature.decodeGeometry();
      expect(identical(first, second), isTrue);
    });
  });

  group('VectorTileFeature.decodeProperties', () {
    test('decodes tag pairs to property map', () {
      final keys = ['name', 'population'];
      final values = [
        VectorTileValue(stringValue: 'TestCity'),
        VectorTileValue(intValue: Int64(50000)),
      ];
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(0, 0),
        keys: keys,
        values: values,
        tags: [0, 0, 1, 1], // name->TestCity, population->50000
      );
      final props = feature.decodeProperties();
      expect(props['name']!.stringValue, 'TestCity');
      expect(props['population']!.intValue, Int64(50000));
    });

    test('returns empty map for no tags', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(0, 0),
      );
      final props = feature.decodeProperties();
      expect(props, isEmpty);
    });

    test('caches properties on second call', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(0, 0),
      );
      final first = feature.decodeProperties();
      final second = feature.decodeProperties();
      expect(identical(first, second), isTrue);
    });
  });

  group('VectorTileFeature.toRaw', () {
    test('converts to raw protobuf feature', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(5, 10),
        tags: [0, 1],
      );
      final rawFeature = feature.toRaw();
      expect(rawFeature.id, Int64(1));
      expect(rawFeature.tags, [0, 1]);
      expect(rawFeature.geometry, _pointGeometry(5, 10));
    });
  });

  group('VectorTileFeature.toGeoJson', () {
    test('converts point to GeoJson with tile coordinates', () {
      final feature = _makeFeature(
        type: VectorTileGeomType.POINT,
        geometryList: _pointGeometry(2048, 2048),
        extent: 4096,
      );
      final geojson = feature.toGeoJson<GeoJsonPoint>(x: 0, y: 0, z: 0);
      expect(geojson, isNotNull);
      expect(geojson!.geometry, isNotNull);
      // At z=0, x=0, y=0, extent=4096:
      // lon = (2048 + 0) * 360 / 4096 - 180 = 0
      // So lon should be 0
      expect(geojson.geometry!.coordinates[0], closeTo(0.0, 0.01));
    });
  });
}
