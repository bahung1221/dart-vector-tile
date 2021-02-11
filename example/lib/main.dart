import 'package:fixnum/fixnum.dart';
import 'package:vector_tile/util/geo_json.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_layer.dart';

import '../../lib/vector_tile.dart';

/// Read & Decode given vector tile file
void decode() async {
  VectorTile tile = await VectorTile.fromPath(path: '../data/12-3262-1923.pbf');

  VectorTileLayer layer = tile.layers.firstWhere((layer) => layer.name == 'transportation');


  var feature = layer.features[0];
  feature.decode();

  layer.features.forEach((feature) { 
    feature.decode();

    var geojson = feature.toGeoJson(3262, 1923, 12);
    if (geojson.type is GeoJsonPoint) {
      print(geojson.runtimeType);
      print((geojson as GeoJsonPoint).type);
      print((geojson as GeoJsonPoint).properties);
      print((geojson as GeoJsonPoint).geometry.type);
      print((geojson as GeoJsonPoint).geometry.coordinates);
    }

    if (feature.geometryType == GeometryType.LineString) {
      print(geojson.runtimeType);
      print((geojson as GeoJsonLineString).type);
      print((geojson as GeoJsonLineString).properties);
      print((geojson as GeoJsonLineString).geometry.type);
      print((geojson as GeoJsonLineString).geometry.coordinates);
    }

    if (feature.geometryType == GeometryType.MultiLineString) {
      print((geojson as GeoJsonMultiLineString).type);
      print((geojson as GeoJsonMultiLineString).properties);
      print((geojson as GeoJsonMultiLineString).geometry.type);
      print((geojson as GeoJsonMultiLineString).geometry.coordinates);
    }

  });

}

// /// Create & Encode a set of vector tile data
// void encode() async {
//   var values = [
//     createVectorTileValue(intValue: Int64(65)),
//     createVectorTileValue(stringValue: 'basketball'),
//   ];
  
//   var features = [
//     createVectorTileFeature(
//       id: Int64(31162829580),
//       tags: [0, 0, 1, 1],
//       type: VectorTile_GeomType.POINT,
//       geometry: [9, 8058, 1562],
//     ),
//   ];
  
//   var layers = [
//     createVectorTileLayer(
//       name: 'poi',
//       extent: 4096,
//       version: 2,
//       keys: ['render_height', 'name'],
//       values: values,
//       features: features,
//     ),
//   ];

//   var tile = createVectorTile(layers: layers);

//   // Save to disk
//   await encodeVectorTile(path: '../gen/tile.pbf', tile: tile);
// }


main() {
  // encode();
  decode();
}