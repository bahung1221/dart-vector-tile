import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'proto/vector_tile.pb.dart';

export 'proto/vector_tile.pb.dart';

VectorTile_GeomType createVectorTileGeomType({
  int type,
}) {
  return VectorTile_GeomType.valueOf(type);
}

VectorTile_Value createVectorTileValue({
  String stringValue,
  double floatValue,
  double doubleValue,
  Int64 intValue,
  Int64 uintValue,
  Int64 sintValue,
  bool boolValue,
}) {
  return VectorTile_Value(
    stringValue: stringValue,
    floatValue: floatValue,
    doubleValue: doubleValue,
    intValue: intValue,
    uintValue: uintValue,
    sintValue: sintValue,
    boolValue: boolValue,
  );
}

VectorTile_Feature createVectorTileFeature({
  Int64 id,
  List<int> tags,
  VectorTile_GeomType type,
  List<int> geometry,
  List<int> raster,
}) {
  return VectorTile_Feature(
    id: id,
    tags: tags,
    type: type,
    geometry: geometry,
    raster: raster,
  );
}

VectorTile_Layer createVectorTileLayer({
  @required String name,
  int extent,
  int version,
  List<String> keys,
  List<VectorTile_Value> values,
  List<VectorTile_Feature> features,
}) {
  return VectorTile_Layer(
    name: name,
    extent: extent,
    version: version,
    keys: keys,
    values: values,
    features: features,
  );
}

VectorTile createVectorTile({
  @required List<VectorTile_Layer> layers,
}) {
  return VectorTile(layers: layers);
}

Future<void> encodeVectorTile({
  @required String path,
  @required VectorTile tile,
}) async {
  File file = File(path);

  await file.writeAsBytes(tile.writeToBuffer());
}

Future<VectorTile> decodeVectorTile({@required String path}) async {
  File file = File(path);

  return VectorTile.fromBuffer(
    await file.readAsBytes(),
  );
}
