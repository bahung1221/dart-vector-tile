import 'package:fixnum/fixnum.dart';
import 'package:vector_tile/vector_tile_layer.dart';

import '../../lib/vector_tile.dart';
import '../../lib/raw/raw_vector_tile.dart' as raw;


void decodeGeoJsonFeatureCollection() async {
  VectorTile tile = await VectorTile.fromPath(path: '../data/sample-12-3262-1923.pbf');

  GeoJsonFeatureCollection featureCollection = tile.toGeoJson(x: 3262, y: 1923, z: 12);

  print(featureCollection.type); // GeoJsonType.FeatureCollection
  print(featureCollection.features.length); // 12049
}

/// Read & Decode given vector tile file
/// Decode raw features to GeoJson format
/// Each GeoJsonType was decode separate
void decodeForEachGeoJsonType() async {
  VectorTile tile = await VectorTile.fromPath(path: '../data/sample-12-3262-1923.pbf');
  VectorTileLayer layer = tile.layers.firstWhere((layer) => layer.name == 'poi');

  layer.features.forEach((feature) {
    feature.decodeGeometry();

    if (feature.geometryType == GeometryType.Point) {
      var geojson = feature.toGeoJson<GeoJsonPoint>(x: 3262, y: 1923, z: 12);

      print(geojson.type);
      print(geojson.properties);
      print(geojson.geometry.type);
      print(geojson.geometry.coordinates);
    }

    if (feature.geometryType == GeometryType.MultiPoint) {
      var geojson = feature.toGeoJson<GeoJsonMultiPoint>(x: 3262, y: 1923, z: 12);

      //...
    }

    if (feature.geometryType == GeometryType.LineString) {
      var geojson = feature.toGeoJson<GeoJsonLineString>(x: 3262, y: 1923, z: 12);

      //...
    }

    if (feature.geometryType == GeometryType.MultiLineString) {
      var geojson = feature.toGeoJson<GeoJsonMultiLineString>(x: 3262, y: 1923, z: 12);

      //...
    }

    if (feature.geometryType == GeometryType.Polygon) {
      var geojson = feature.toGeoJson<GeoJsonPolygon>(x: 3262, y: 1923, z: 12);

      //...
    }

    if (feature.geometryType == GeometryType.MultiPolygon) {
      var geojson = feature.toGeoJson<GeoJsonMultiPolygon>(x: 3262, y: 1923, z: 12);

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
    var geojson = feature.toGeoJson(x: 3262, y: 1923, z: 12);

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
    raw.createVectorTileValue(intValue: Int64(65)),
    raw.createVectorTileValue(stringValue: 'basketball'),
  ];
  
  var features = [
    raw.createVectorTileFeature(
      id: Int64(31162829580),
      tags: [0, 0, 1, 1],
      type: raw.VectorTile_GeomType.POINT,
      geometry: [9, 8058, 1562],
    ),
  ];
  
  var layers = [
    raw.createVectorTileLayer(
      name: 'poi',
      extent: 4096,
      version: 2,
      keys: ['render_height', 'name'],
      values: values,
      features: features,
    ),
  ];

  var tile = raw.createVectorTile(layers: layers);

  // Save to disk
  await raw.encodeVectorTile(path: '../gen/tile.pbf', tile: tile);
}


main() {
  // encode();
  decodeForEachGeoJsonType();
  // decodeForAllGeoJsonType();
  // decodeGeoJsonFeatureCollection();
}