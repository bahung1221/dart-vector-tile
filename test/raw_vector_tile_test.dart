import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart';

void main() {
  group('createVectorTileGeomType', () {
    test('returns correct types for valid values', () {
      expect(createVectorTileGeomType(type: 0), VectorTile_GeomType.UNKNOWN);
      expect(createVectorTileGeomType(type: 1), VectorTile_GeomType.POINT);
      expect(
          createVectorTileGeomType(type: 2), VectorTile_GeomType.LINESTRING);
      expect(createVectorTileGeomType(type: 3), VectorTile_GeomType.POLYGON);
    });

    test('returns null for invalid value', () {
      expect(createVectorTileGeomType(type: 99), isNull);
    });
  });

  group('createVectorTileValue', () {
    test('creates string value', () {
      final v = createVectorTileValue(stringValue: 'test');
      expect(v.hasStringValue(), isTrue);
      expect(v.stringValue, 'test');
    });

    test('creates bool value', () {
      final v = createVectorTileValue(boolValue: true);
      expect(v.hasBoolValue(), isTrue);
      expect(v.boolValue, isTrue);
    });

    test('creates int value', () {
      final v = createVectorTileValue(intValue: Int64(42));
      expect(v.hasIntValue(), isTrue);
      expect(v.intValue, Int64(42));
    });
  });

  group('createVectorTileFeature', () {
    test('creates feature with required fields', () {
      final f = createVectorTileFeature(
        type: VectorTile_GeomType.POINT,
        geometry: [9, 10, 20],
      );
      expect(f.type, VectorTile_GeomType.POINT);
      expect(f.geometry, [9, 10, 20]);
    });

    test('creates feature with id and tags', () {
      final f = createVectorTileFeature(
        id: Int64(42),
        tags: [0, 1, 2, 3],
        type: VectorTile_GeomType.LINESTRING,
        geometry: [9, 4, 4, 18, 0, 16],
      );
      expect(f.id, Int64(42));
      expect(f.tags, [0, 1, 2, 3]);
    });
  });

  group('createVectorTileLayer', () {
    test('creates layer with all fields', () {
      final layer = createVectorTileLayer(
        name: 'buildings',
        extent: 4096,
        version: 2,
        keys: ['name', 'height'],
        values: [
          createVectorTileValue(stringValue: 'Tower'),
          createVectorTileValue(floatValue: 100.0),
        ],
      );
      expect(layer.name, 'buildings');
      expect(layer.extent, 4096);
      expect(layer.version, 2);
      expect(layer.keys, ['name', 'height']);
      expect(layer.values.length, 2);
    });
  });

  group('createVectorTile', () {
    test('creates tile with layers', () {
      final layer = createVectorTileLayer(
        name: 'test',
        extent: 4096,
        version: 2,
      );
      final tile = createVectorTile(layers: [layer]);
      expect(tile.layers.length, 1);
      expect(tile.layers[0].name, 'test');
    });
  });

  group('protobuf round-trip', () {
    test('encode then decode preserves data', () {
      final value = createVectorTileValue(stringValue: 'park');
      final feature = createVectorTileFeature(
        id: Int64(1),
        tags: [0, 0],
        type: VectorTile_GeomType.POINT,
        geometry: [9, 100, 200],
      );
      final layer = createVectorTileLayer(
        name: 'poi',
        extent: 4096,
        version: 2,
        keys: ['type'],
        values: [value],
        features: [feature],
      );
      final tile = createVectorTile(layers: [layer]);

      // Serialize
      final bytes = tile.writeToBuffer();
      expect(bytes.isNotEmpty, isTrue);

      // Deserialize
      final restored = VectorTile.fromBuffer(bytes);
      expect(restored.layers.length, 1);

      final restoredLayer = restored.layers[0];
      expect(restoredLayer.name, 'poi');
      expect(restoredLayer.extent, 4096);
      expect(restoredLayer.version, 2);
      expect(restoredLayer.keys, ['type']);
      expect(restoredLayer.values[0].stringValue, 'park');

      final restoredFeature = restoredLayer.features[0];
      expect(restoredFeature.id, Int64(1));
      expect(restoredFeature.tags, [0, 0]);
      expect(restoredFeature.type, VectorTile_GeomType.POINT);
      expect(restoredFeature.geometry, [9, 100, 200]);
    });
  });
}
