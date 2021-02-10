import 'package:fixnum/fixnum.dart';

import '../../lib/vector_tile.dart';

/// Read & Decode given vector tile file
void decode() async {
  VectorTile tile = await decodeVectorTile(path: '../data/sample.pbf');

  print(tile.toString());
}

/// Create & Encode a set of vector tile data
void encode() async {
  var values = [
    createVectorTileValue(intValue: Int64(65)),
    createVectorTileValue(stringValue: 'basketball'),
  ];
  
  var features = [
    createVectorTileFeature(
      id: Int64(31162829580),
      tags: [0, 0, 1, 1],
      type: VectorTile_GeomType.POINT,
      geometry: [9, 8058, 1562],
    ),
  ];
  
  var layers = [
    createVectorTileLayer(
      name: 'poi',
      extent: 4096,
      version: 2,
      keys: ['render_height', 'name'],
      values: values,
      features: features,
    ),
  ];

  var tile = createVectorTile(layers: layers);

  // Save to disk
  await encodeVectorTile(path: '../gen/tile.pbf', tile: tile);
}


main() {
  // encode();
  decode();
}