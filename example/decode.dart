import '../lib/vector_tile.dart';

main() async {
  VectorTile tile = await decodeVectorTile(path: './gen/tile.pbf');

  print(tile.toString());
}