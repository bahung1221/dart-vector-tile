// import 'package:fixnum/fixnum.dart';
import 'package:vector_tile/util/geo_json.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_layer.dart';

import '../../lib/vector_tile.dart';

/// Read & Decode given vector tile file
void decode() async {
  VectorTile tile = await VectorTile.fromPath(path: '../data/12-3262-1923.pbf');
  VectorTileLayer layer = tile.layers.firstWhere((layer) => layer.name == 'transportation');

  layer.features.forEach((feature) {
    var geometry = feature.decodeGeometry();
    if (feature.geometryType == GeometryType.Point) {

      print((geometry as GeometryPoint).coordinates);

      var geojson = feature.toGeoJson<GeoJsonPoint>(3262, 1923, 12);

      print(geojson.type);
      print(geojson.properties);
      print(geojson.geometry.type);
      print(geojson.geometry.coordinates);
      print(geojson.runtimeType);
    }

    if (feature.geometryType == GeometryType.LineString) {
      var geometry = feature.decodeGeometry<GeometryLineString>();

      print('====');
      print(geometry.coordinates);
      print('====');

      var geojson = feature.toGeoJson<GeoJsonLineString>(3262, 1923, 12);

      print(geojson.type);
      print(geojson.properties);
      print(geojson.geometry.type);
      print(geojson.geometry.coordinates);
    }

    if (feature.geometryType == GeometryType.MultiLineString) {
      var geojson = feature.toGeoJson<GeoJsonMultiLineString>(3262, 1923, 12);

      print(geojson.type);
      print(geojson.properties);
      print(geojson.geometry.type);
      print(geojson.geometry.coordinates);
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