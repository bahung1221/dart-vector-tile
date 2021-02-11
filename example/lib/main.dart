import 'package:fixnum/fixnum.dart';
import 'package:vector_tile/util/geo_json.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_layer.dart';

import '../../lib/vector_tile.dart';
import '../../lib/raw/raw_vector_tile.dart' as Raw;

/// Read & Decode given vector tile file
/// Decode raw features to GeoJson format
/// Each GeoJsonType was decode separate
void decodeForEachGeoJsonType() async {
  VectorTile tile = await VectorTile.fromPath(path: '../data/sample-12-3262-1923.pbf');
  VectorTileLayer layer = tile.layers.firstWhere((layer) => layer.name == 'poi');

  layer.features.forEach((feature) {
    feature.decodeGeometry();

    if (feature.geometryType == GeometryType.Point) {
      var geojson = feature.toGeoJson<GeoJsonPoint>(3262, 1923, 12);

      print(geojson.type);
      print(geojson.properties);
      print(geojson.geometry.type);
      print(geojson.geometry.coordinates);
    }

    if (feature.geometryType == GeometryType.MultiPoint) {
      var geojson = feature.toGeoJson<GeoJsonMultiPoint>(3262, 1923, 12);

      //...
    }

    if (feature.geometryType == GeometryType.LineString) {
      var geojson = feature.toGeoJson<GeoJsonLineString>(3262, 1923, 12);

      //...
    }

    if (feature.geometryType == GeometryType.MultiLineString) {
      var geojson = feature.toGeoJson<GeoJsonMultiLineString>(3262, 1923, 12);

      //...
    }

    if (feature.geometryType == GeometryType.Polygon) {
      var geojson = feature.toGeoJson<GeoJsonPolygon>(3262, 1923, 12);

      //...
    }

    if (feature.geometryType == GeometryType.MultiPolygon) {
      var geojson = feature.toGeoJson<GeoJsonMultiPolygon>(3262, 1923, 12);

      //...
    }
  });
}

/// Read & Decode given vector tile file
/// Decode raw features to GeoJson format
/// All GeoJsonType was decode one and 
/// Then we must use type cast to read each type specific data 
void decodeForAllGeoJsonType() async {
  VectorTile tile = await VectorTile.fromPath(path: '../data/sample-12-3262-1923.pbf');
  VectorTileLayer layer = tile.layers.firstWhere((layer) => layer.name == 'poi');

  layer.features.forEach((feature) {
    var geojson = feature.toGeoJson(3262, 1923, 12);

    if (feature.geometryType == GeometryType.Point) {
      print((geojson as GeoJsonPoint).type);
      print((geojson as GeoJsonPoint).properties);
      print((geojson as GeoJsonPoint).geometry.type);
      print((geojson as GeoJsonPoint).geometry.coordinates);
    }

    if (feature.geometryType == GeometryType.MultiPoint) {
      print((geojson as GeoJsonMultiPoint).type);
      print((geojson as GeoJsonMultiPoint).properties);
      print((geojson as GeoJsonMultiPoint).geometry.type);
      print((geojson as GeoJsonMultiPoint).geometry.coordinates);
    }

    // Other types ...
  });
}

/// Create & Encode a set of vector tile data from raw format
void encode() async {
  var values = [
    Raw.createVectorTileValue(intValue: Int64(65)),
    Raw.createVectorTileValue(stringValue: 'basketball'),
  ];
  
  var features = [
    Raw.createVectorTileFeature(
      id: Int64(31162829580),
      tags: [0, 0, 1, 1],
      type: Raw.VectorTile_GeomType.POINT,
      geometry: [9, 8058, 1562],
    ),
  ];
  
  var layers = [
    Raw.createVectorTileLayer(
      name: 'poi',
      extent: 4096,
      version: 2,
      keys: ['render_height', 'name'],
      values: values,
      features: features,
    ),
  ];

  var tile = Raw.createVectorTile(layers: layers);

  // Save to disk
  await Raw.encodeVectorTile(path: '../gen/tile.pbf', tile: tile);
}


main() {
  // encode();
  // decodeForEachGeoJsonType();
  decodeForAllGeoJsonType();
}