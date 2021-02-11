import 'package:meta/meta.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;
import 'package:vector_tile/vector_tile_layer.dart';

class VectorTile {
  raw.VectorTile rawTile;
  List<VectorTileLayer> layers;

  VectorTile({
    @required this.rawTile,
    @required this.layers,
  });

  static Future<VectorTile> fromPath({@required String path}) async {
    raw.VectorTile rawTile = await raw.decodeVectorTile(path: path);
    List<VectorTileLayer> layers = rawTile.layers.map((rawLayer) {
      return VectorTileLayer.fromRaw(rawLayer: rawLayer);
    }).toList();

    return VectorTile(rawTile: rawTile, layers: layers);
  }
}
