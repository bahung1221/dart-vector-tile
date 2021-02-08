import 'package:fixnum/fixnum.dart';

import '../lib/vector_tile.dart';

main() async {
  var values = [
    createVectorTileValue(intValue: Int64(65)),
    createVectorTileValue(stringValue: 'basketball'),
  ];
  
  var features = [
    createVectorTileFeature(
      id: Int64(31162829580),
      tags: [0, 96, 1, 348],
      type: VectorTile_GeomType.POINT,
      geometry: [9, 8058, 1562],
    ),
  ];
  
  var layers = [
    createVectorTileLayer(
      name: 'building',
      extent: 4096,
      version: 2,
      keys: ['render_height', 'render_min_height'],
      values: values,
      features: features,
    ),
  ];

  var tile = createVectorTile(layers: layers);

  // Save to disk
  await encodeVectorTile(path: './gen/tile.pbf', tile: tile);
}