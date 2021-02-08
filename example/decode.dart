import '../lib/vector_tile.dart';

main() async {
  VectorTile tile = await decodeVectorTile(path: './data/14-13050-7695.pbf');

  print(tile.toString());
}