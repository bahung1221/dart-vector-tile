import 'package:meta/meta.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as Raw;
import 'package:vector_tile/vector_tile_layer.dart';

class VectorTile {
  Raw.VectorTile rawTile;
  List<VectorTileLayer> layers;

  VectorTile({
    @required this.rawTile,
    @required this.layers,
  });

  static Future<VectorTile> fromPath({@required String path}) async {
    Raw.VectorTile rawTile = await Raw.decodeVectorTile(path: path);
    List<VectorTileLayer> layers = rawTile.layers.map((rawLayer) {
      return VectorTileLayer.fromRaw(rawLayer: rawLayer);
    }).toList();

    return VectorTile(rawTile: rawTile, layers: layers);
  }
}
