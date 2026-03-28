import 'package:test/test.dart';
import 'package:vector_tile/vector_tile_geom_type.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;

void main() {
  group('VectorTileGeomType toRaw', () {
    test('converts POINT', () {
      expect(VectorTileGeomType.POINT.toRaw(), raw.VectorTile_GeomType.POINT);
    });

    test('converts LINESTRING', () {
      expect(VectorTileGeomType.LINESTRING.toRaw(),
          raw.VectorTile_GeomType.LINESTRING);
    });

    test('converts POLYGON', () {
      expect(
          VectorTileGeomType.POLYGON.toRaw(), raw.VectorTile_GeomType.POLYGON);
    });

    test('converts UNKNOWN', () {
      expect(
          VectorTileGeomType.UNKNOWN.toRaw(), raw.VectorTile_GeomType.UNKNOWN);
    });

    test('converts null to UNKNOWN', () {
      VectorTileGeomType? nullType;
      expect(nullType.toRaw(), raw.VectorTile_GeomType.UNKNOWN);
    });
  });

  group('VectorTileGeomType fromRaw', () {
    test('converts from raw POINT', () {
      expect(VectorTileGeomTypeExtension.fromRaw(raw.VectorTile_GeomType.POINT),
          VectorTileGeomType.POINT);
    });

    test('converts from raw LINESTRING', () {
      expect(
          VectorTileGeomTypeExtension.fromRaw(
              raw.VectorTile_GeomType.LINESTRING),
          VectorTileGeomType.LINESTRING);
    });

    test('converts from raw POLYGON', () {
      expect(
          VectorTileGeomTypeExtension.fromRaw(
              raw.VectorTile_GeomType.POLYGON),
          VectorTileGeomType.POLYGON);
    });

    test('converts from raw UNKNOWN', () {
      expect(
          VectorTileGeomTypeExtension.fromRaw(
              raw.VectorTile_GeomType.UNKNOWN),
          VectorTileGeomType.UNKNOWN);
    });
  });

  group('round-trip', () {
    test('all types survive toRaw then fromRaw', () {
      for (final type in VectorTileGeomType.values) {
        final restored = VectorTileGeomTypeExtension.fromRaw(type.toRaw());
        expect(restored, type);
      }
    });
  });
}
