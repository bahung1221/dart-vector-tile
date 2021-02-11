import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;

enum VectorTileGeomType {
  UNKNOWN, POINT, LINESTRING, POLYGON
}

extension VectorTileGeomTypeExtension on VectorTileGeomType {
  raw.VectorTile_GeomType toRaw() {
    switch (this) {
      case VectorTileGeomType.POINT:
        return raw.VectorTile_GeomType.POINT;
      case VectorTileGeomType.LINESTRING:
        return raw.VectorTile_GeomType.LINESTRING;
      case VectorTileGeomType.POLYGON:
        return raw.VectorTile_GeomType.POLYGON;
      default:
        return raw.VectorTile_GeomType.UNKNOWN;
    }
  }

  static VectorTileGeomType fromRaw(raw.VectorTile_GeomType rawGeomType) {
    switch (rawGeomType) {
      case raw.VectorTile_GeomType.POINT:
        return VectorTileGeomType.POINT;
      case raw.VectorTile_GeomType.LINESTRING:
        return VectorTileGeomType.LINESTRING;
      case raw.VectorTile_GeomType.POLYGON:
        return VectorTileGeomType.POLYGON;
      default:
        return VectorTileGeomType.UNKNOWN;
    }
  }
}
