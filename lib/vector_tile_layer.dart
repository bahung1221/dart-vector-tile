import 'package:meta/meta.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as Raw;
import 'package:vector_tile/vector_tile_geom_type.dart';
import 'package:vector_tile/vector_tile_feature.dart';
import 'package:vector_tile/vector_tile_value.dart';

class VectorTileLayer {
  Raw.VectorTile_Layer rawLayer;
  String name;
  int extent;
  int version;
  List<String> keys;
  List<VectorTileValue> values;
  List<VectorTileFeature> features;

  VectorTileLayer({
    @required this.rawLayer,
    @required this.name,
    @required this.extent,
    @required this.version,
    this.keys,
    this.values,
    this.features,
  });

  static VectorTileLayer fromRaw({@required Raw.VectorTile_Layer rawLayer}) {
    List<VectorTileValue> values = rawLayer.values.map((value) {
      return VectorTileValue(
        stringValue: value.stringValue,
        floatValue: value.floatValue,
        doubleValue: value.doubleValue,
        intValue: value.intValue,
        uintValue: value.uintValue,
        sintValue: value.sintValue,
        boolValue: value.boolValue,
      );
    }).toList();
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
      rawLayer: rawLayer,
      name: rawLayer.name,
      extent: rawLayer.extent,
      version: rawLayer.version,
      keys: rawLayer.keys,
      values: values,
      features: features,
    );
  }
}