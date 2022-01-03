import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;
import 'package:vector_tile/vector_tile_feature.dart';
import 'package:vector_tile/vector_tile_geom_type.dart';
import 'package:vector_tile/vector_tile_value.dart';

class VectorTileLayer {
  String name;
  int extent;
  int version;
  List<String> keys;
  List<VectorTileValue> values;
  List<VectorTileFeature> features;

  VectorTileLayer({
    required this.name,
    required this.extent,
    required this.version,
    required this.keys,
    required this.values,
    required this.features,
  });

  static VectorTileLayer fromRaw({required raw.VectorTile_Layer rawLayer}) {
    List<VectorTileValue> values =
        rawLayer.values.map((value) => VectorTileValue.fromRaw(value)).toList();
    List<VectorTileFeature> features = rawLayer.features.map((feature) {
      return VectorTileFeature(
        id: feature.id,
        tags: feature.tags,
        type: VectorTileGeomTypeExtension.fromRaw(feature.type),
        geometryList: feature.geometry,
        extent: rawLayer.extent,
        keys: rawLayer.keys,
        values: values,
      );
    }).toList();

    return VectorTileLayer(
      name: rawLayer.name,
      extent: rawLayer.extent,
      version: rawLayer.version,
      keys: rawLayer.keys,
      values: values,
      features: features,
    );
  }
}
