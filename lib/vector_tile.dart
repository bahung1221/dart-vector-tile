import 'dart:math';
import 'dart:typed_data';

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

  /// decodes the given bytes (`.mvt`/`.pbf`) to a [VectorTile]
  static VectorTile fromBytes({required Uint8List bytes}) {
    final tile = raw.VectorTile.fromBuffer(bytes);
    List<VectorTileLayer> layers = tile.layers.map((rawLayer) {
      return VectorTileLayer.fromRaw(rawLayer: rawLayer);
    }).toList(growable: false);
    return VectorTile(layers: layers);
  }

  Future<void> toPath({required String path}) async {}

  GeoJsonFeatureCollection toGeoJson(
      {required int x, required int y, required int z}) {
    List<GeoJson?> featuresGeoJson = [];
    for (final layer in this.layers) {
      int size = layer.extent * (pow(2, z) as int);
      int x0 = layer.extent * x;
      int y0 = layer.extent * y;

      for (final feature in layer.features) {
        featuresGeoJson.add(
            feature.toGeoJsonWithExtentCalculated(x0: x0, y0: y0, size: size));
      }
    }

    return GeoJsonFeatureCollection(features: featuresGeoJson);
  }
}
