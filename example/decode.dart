import '../lib/vector_tile.dart';

main() async {
  VectorTile vectorTile = await decodeVectorTile(path: './data/14-13050-7695.pbf');

  print(vectorTile.toString());
}