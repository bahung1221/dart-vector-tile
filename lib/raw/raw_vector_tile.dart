import 'dart:io';
import 'package:fixnum/fixnum.dart';
import './proto/vector_tile.pb.dart';

export './proto/vector_tile.pb.dart';

/// Get GeomType for given int value
/// - 0: UNKNOWN
/// - 1: POINT
/// - 2: LINESTRING
/// - 3: POLYGON
///
/// You also can use VectorTile_GeomType enum directly instead of this function
/// e.g. VectorTile_GeomType.POINT
///
/// @spec: https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#434-geometry-types
VectorTile_GeomType? createVectorTileGeomType({
  required int type,
}) {
  return VectorTile_GeomType.valueOf(type);
}

/// Create a value that will be attach into layers
///
/// In order to support values of varying string, boolean, integer, and floating point types,
/// the protobuf encoding of the value field consists of a set of optional fields.
/// BUT A value MUST contain exactly one of these optional fields.
///
/// @spec: https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#41-layers
VectorTile_Value createVectorTileValue({
  String? stringValue,
  double? floatValue,
  double? doubleValue,
  Int64? intValue,
  Int64? uintValue,
  Int64? sintValue,
  bool? boolValue,
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

/// Create a feature that will be attach into layers
///
/// @spec: https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#42-features
VectorTile_Feature createVectorTileFeature({
  Int64? id,
  List<int>? tags,
  required VectorTile_GeomType type,
  required List<int> geometry,
}) {
  return VectorTile_Feature(
    id: id,
    tags: tags,
    type: type,
    geometry: geometry,
  );
}

/// Create a layer that will be attach into vector tiles
///
/// @spec: https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#41-layers
VectorTile_Layer createVectorTileLayer({
  required String name,
  required int extent,
  required int version,
  List<String>? keys,
  List<VectorTile_Value>? values,
  List<VectorTile_Feature>? features,
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

/// Create a `VectorTile` instance from a list of layers
///
/// @spec: https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#41-layers
VectorTile createVectorTile({
  required List<VectorTile_Layer> layers,
}) {
  return VectorTile(layers: layers);
}

/// Encode `VectorTile` to buffer and then save it to disk
Future<void> encodeVectorTile({
  required String path,
  required VectorTile tile,
}) async {
  File file = File(path);

  await file.writeAsBytes(tile.writeToBuffer());
}

/// Read an vector tile (`.mvt`/`.pbf`) file from disk,
/// Then decode it into `VectorTile` instance
Future<VectorTile> decodeVectorTile({required String path}) async {
  File file = File(path);

  return VectorTile.fromBuffer(
    await file.readAsBytes(),
  );
}
