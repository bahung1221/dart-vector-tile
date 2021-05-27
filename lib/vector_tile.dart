import 'dart:math';

import 'package:vector_tile/vector_tile_layer.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;
import 'package:vector_tile/util/geojson.dart';

export 'package:vector_tile/vector_tile_geom_type.dart';
export 'package:vector_tile/vector_tile_value.dart';
export 'package:vector_tile/vector_tile_feature.dart';
export 'package:vector_tile/vector_tile_layer.dart';
export 'package:vector_tile/util/geojson.dart';
export 'package:vector_tile/util/geometry.dart';

class VectorTile {
  List<VectorTileLayer> layers;

  VectorTile({
    required this.layers,
  });

  static Future<VectorTile> fromPath({required String path}) async {
    raw.VectorTile rawTile = await raw.decodeVectorTile(path: path);
    List<VectorTileLayer> layers = rawTile.layers.map((rawLayer) {
      return VectorTileLayer.fromRaw(rawLayer: rawLayer);
    }).toList();

    return VectorTile(layers: layers);
  }

  Future<void> toPath({required String path}) async {}

  GeoJsonFeatureCollection toGeoJson(
      {required int x, required int y, required int z}) {
    List<GeoJson?> featuresGeoJson = [];
    this.layers.forEach((layer) {
      int size = layer.extent * (pow(2, z) as int);
      int x0 = layer.extent * x;
      int y0 = layer.extent * y;

      layer.features.forEach((feature) {
        featuresGeoJson.add(
            feature.toGeoJsonWithExtentCalculated(x0: x0, y0: y0, size: size));
      });
    });

    return GeoJsonFeatureCollection(features: featuresGeoJson);
  }
}
