import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';
import 'package:vector_tile/vector_tile.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;
import 'package:vector_tile/util/command.dart';

/// Build a minimal valid vector tile as bytes.
Uint8List _buildTileBytes({
  String layerName = 'test',
  int extent = 4096,
  int version = 2,
  List<String> keys = const [],
  List<raw.VectorTile_Value> values = const [],
  List<raw.VectorTile_Feature> features = const [],
}) {
  final layer = raw.createVectorTileLayer(
    name: layerName,
    extent: extent,
    version: version,
    keys: keys,
    values: values,
    features: features,
  );
  final tile = raw.createVectorTile(layers: [layer]);
  return Uint8List.fromList(tile.writeToBuffer());
}

void main() {
  group('VectorTile.fromBytes', () {
    test('decodes empty layer', () {
      final bytes = _buildTileBytes();
      final tile = VectorTile.fromBytes(bytes: bytes);
      expect(tile.layers.length, 1);
      expect(tile.layers[0].name, 'test');
      expect(tile.layers[0].extent, 4096);
      expect(tile.layers[0].version, 2);
      expect(tile.layers[0].features, isEmpty);
    });

    test('decodes layer with point feature', () {
      final feature = raw.createVectorTileFeature(
        id: Int64(1),
        tags: [0, 0],
        type: raw.VectorTile_GeomType.POINT,
        geometry: [9, Command.zigZagEncode(25), Command.zigZagEncode(17)],
      );
      final bytes = _buildTileBytes(
        keys: ['name'],
        values: [raw.createVectorTileValue(stringValue: 'poi')],
        features: [feature],
      );

      final tile = VectorTile.fromBytes(bytes: bytes);
      final layer = tile.layers[0];
      expect(layer.features.length, 1);

      final f = layer.features[0];
      expect(f.id, Int64(1));
      expect(f.type, VectorTileGeomType.POINT);
      expect(f.keys, ['name']);
      expect(f.values!.length, 1);
      expect(f.values![0].stringValue, 'poi');
    });

    test('decodes multiple layers', () {
      final layer1 = raw.createVectorTileLayer(
        name: 'roads',
        extent: 4096,
        version: 2,
      );
      final layer2 = raw.createVectorTileLayer(
        name: 'buildings',
        extent: 4096,
        version: 2,
      );
      final tile = raw.createVectorTile(layers: [layer1, layer2]);
      final bytes = Uint8List.fromList(tile.writeToBuffer());

      final decoded = VectorTile.fromBytes(bytes: bytes);
      expect(decoded.layers.length, 2);
      expect(decoded.layers[0].name, 'roads');
      expect(decoded.layers[1].name, 'buildings');
    });
  });

  group('VectorTile.toGeoJson', () {
    test('converts tile with point feature to GeoJSON', () {
      final feature = raw.createVectorTileFeature(
        id: Int64(1),
        type: raw.VectorTile_GeomType.POINT,
        geometry: [9, Command.zigZagEncode(2048), Command.zigZagEncode(2048)],
      );
      final bytes = _buildTileBytes(features: [feature]);
      final tile = VectorTile.fromBytes(bytes: bytes);

      final geojson = tile.toGeoJson(x: 0, y: 0, z: 0);
      expect(geojson.type, GeoJsonType.FeatureCollection);
      expect(geojson.features.length, 1);
      expect(geojson.features[0], isA<GeoJsonPoint>());

      final point = geojson.features[0] as GeoJsonPoint;
      // At z=0, tile (0,0): midpoint (2048/4096) should give lon=0
      expect(point.geometry!.coordinates[0], closeTo(0.0, 0.01));
    });

    test('returns empty collection for empty tile', () {
      final bytes = _buildTileBytes();
      final tile = VectorTile.fromBytes(bytes: bytes);
      final geojson = tile.toGeoJson(x: 0, y: 0, z: 0);
      expect(geojson.features, isEmpty);
    });
  });

  group('VectorTileLayer.fromRaw', () {
    test('preserves all layer metadata', () {
      final rawLayer = raw.createVectorTileLayer(
        name: 'water',
        extent: 8192,
        version: 2,
        keys: ['class', 'depth'],
        values: [
          raw.createVectorTileValue(stringValue: 'lake'),
          raw.createVectorTileValue(doubleValue: 15.5),
        ],
      );
      final layer = VectorTileLayer.fromRaw(rawLayer: rawLayer);
      expect(layer.name, 'water');
      expect(layer.extent, 8192);
      expect(layer.version, 2);
      expect(layer.keys, ['class', 'depth']);
      expect(layer.values.length, 2);
      expect(layer.values[0].stringValue, 'lake');
      expect(layer.values[1].doubleValue, 15.5);
    });

    test('passes extent and keys/values to features', () {
      final feature = raw.createVectorTileFeature(
        type: raw.VectorTile_GeomType.POINT,
        geometry: [9, 10, 20],
        tags: [0, 0],
      );
      final rawLayer = raw.createVectorTileLayer(
        name: 'poi',
        extent: 4096,
        version: 2,
        keys: ['name'],
        values: [raw.createVectorTileValue(stringValue: 'park')],
        features: [feature],
      );
      final layer = VectorTileLayer.fromRaw(rawLayer: rawLayer);
      final f = layer.features[0];
      expect(f.extent, 4096);
      expect(f.keys, ['name']);
      expect(f.values!.length, 1);
    });
  });

  group('Full encode/decode round-trip', () {
    test('point feature survives encode then decode', () {
      // Build a tile from scratch
      final feature = raw.createVectorTileFeature(
        id: Int64(42),
        tags: [0, 0, 1, 1],
        type: raw.VectorTile_GeomType.POINT,
        geometry: [9, Command.zigZagEncode(100), Command.zigZagEncode(200)],
      );
      final bytes = _buildTileBytes(
        layerName: 'cities',
        keys: ['name', 'pop'],
        values: [
          raw.createVectorTileValue(stringValue: 'TestCity'),
          raw.createVectorTileValue(intValue: Int64(1000000)),
        ],
        features: [feature],
      );

      // Decode
      final tile = VectorTile.fromBytes(bytes: bytes);
      final f = tile.layers[0].features[0];

      // Verify feature metadata
      expect(f.id, Int64(42));
      expect(f.type, VectorTileGeomType.POINT);

      // Decode and verify properties
      final props = f.decodeProperties();
      expect(props['name']!.stringValue, 'TestCity');
      expect(props['pop']!.intValue, Int64(1000000));

      // Decode and verify geometry
      final geom = f.decodeGeometry<GeometryPoint>();
      expect(geom!.coordinates, [100.0, 200.0]);
    });

    test('linestring feature survives encode then decode', () {
      // MoveTo(1) + point(0,0), LineTo(2) + delta(10,0) + delta(0,10)
      final geometry = <int>[
        9, // MoveTo(1)
        Command.zigZagEncode(0), Command.zigZagEncode(0),
        18, // LineTo(2)
        Command.zigZagEncode(10), Command.zigZagEncode(0),
        Command.zigZagEncode(0), Command.zigZagEncode(10),
      ];
      final feature = raw.createVectorTileFeature(
        type: raw.VectorTile_GeomType.LINESTRING,
        geometry: geometry,
      );
      final bytes = _buildTileBytes(features: [feature]);

      final tile = VectorTile.fromBytes(bytes: bytes);
      final f = tile.layers[0].features[0];
      final geom = f.decodeGeometry<GeometryLineString>();
      expect(geom!.coordinates, [
        [0.0, 0.0],
        [10.0, 0.0],
        [10.0, 10.0],
      ]);
    });
  });
}
