import 'package:vector_tile/raw/raw_vector_tile.dart' as Raw;

enum VectorTileGeomType {
  UNKNOWN, POINT, LINESTRING, POLYGON
}

extension VectorTileGeomTypeExtension on VectorTileGeomType {
  Raw.VectorTile_GeomType toRaw() {
    switch (this) {
      case VectorTileGeomType.POINT:
        return Raw.VectorTile_GeomType.POINT;
      case VectorTileGeomType.LINESTRING:
        return Raw.VectorTile_GeomType.LINESTRING;
      case VectorTileGeomType.POLYGON:
        return Raw.VectorTile_GeomType.POLYGON;
      default:
        return Raw.VectorTile_GeomType.UNKNOWN;
    }
  }

  static VectorTileGeomType fromRaw(Raw.VectorTile_GeomType raw) {
    switch (raw) {
      case Raw.VectorTile_GeomType.POINT:
        return VectorTileGeomType.POINT;
      case Raw.VectorTile_GeomType.LINESTRING:
        return VectorTileGeomType.LINESTRING;
      case Raw.VectorTile_GeomType.POLYGON:
        return VectorTileGeomType.POLYGON;
      default:
        return VectorTileGeomType.UNKNOWN;
    }
  }
}
