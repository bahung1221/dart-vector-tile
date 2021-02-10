import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as Raw;
import 'package:vector_tile/vector_tile_geom_type.dart';

class VectorTileFeature {
  Int64 id;
  List<int> tags;
  VectorTileGeomType type;
  List<int> geometry;

  VectorTileFeature({
    @required this.id,
    @required this.tags,
    this.type,
    this.geometry
  });

  Raw.VectorTile_Feature toRaw() {
    return Raw.VectorTile_Feature(
      id: this.id,
      tags: this.tags,
      type: this.type.toRaw(),
      geometry: this.geometry
    );
  }
}

