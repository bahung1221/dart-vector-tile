// This is a generated file - do not edit.
//
// Generated from vector_tile.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'vector_tile.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'vector_tile.pbenum.dart';

/// Variant type encoding
/// The use of values is described in section 4.1 of the specification
class VectorTile_Value extends $pb.GeneratedMessage {
  factory VectorTile_Value({
    $core.String? stringValue,
    $core.double? floatValue,
    $core.double? doubleValue,
    $fixnum.Int64? intValue,
    $fixnum.Int64? uintValue,
    $fixnum.Int64? sintValue,
    $core.bool? boolValue,
  }) {
    final result = create();
    if (stringValue != null) result.stringValue = stringValue;
    if (floatValue != null) result.floatValue = floatValue;
    if (doubleValue != null) result.doubleValue = doubleValue;
    if (intValue != null) result.intValue = intValue;
    if (uintValue != null) result.uintValue = uintValue;
    if (sintValue != null) result.sintValue = sintValue;
    if (boolValue != null) result.boolValue = boolValue;
    return result;
  }

  VectorTile_Value._();

  factory VectorTile_Value.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VectorTile_Value.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VectorTile.Value',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'vector_tile'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'stringValue')
    ..aD(2, _omitFieldNames ? '' : 'floatValue', fieldType: $pb.PbFieldType.OF)
    ..aD(3, _omitFieldNames ? '' : 'doubleValue')
    ..aInt64(4, _omitFieldNames ? '' : 'intValue')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'uintValue', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'sintValue', $pb.PbFieldType.OS6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(7, _omitFieldNames ? '' : 'boolValue')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile_Value clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile_Value copyWith(void Function(VectorTile_Value) updates) =>
      super.copyWith((message) => updates(message as VectorTile_Value))
          as VectorTile_Value;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VectorTile_Value create() => VectorTile_Value._();
  @$core.override
  VectorTile_Value createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VectorTile_Value getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VectorTile_Value>(create);
  static VectorTile_Value? _defaultInstance;

  /// Exactly one of these values must be present in a valid message
  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get floatValue => $_getN(1);
  @$pb.TagNumber(2)
  set floatValue($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFloatValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearFloatValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get doubleValue => $_getN(2);
  @$pb.TagNumber(3)
  set doubleValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDoubleValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get intValue => $_getI64(3);
  @$pb.TagNumber(4)
  set intValue($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIntValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearIntValue() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get uintValue => $_getI64(4);
  @$pb.TagNumber(5)
  set uintValue($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUintValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearUintValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sintValue => $_getI64(5);
  @$pb.TagNumber(6)
  set sintValue($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSintValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearSintValue() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get boolValue => $_getBF(6);
  @$pb.TagNumber(7)
  set boolValue($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBoolValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearBoolValue() => $_clearField(7);
}

/// Features are described in section 4.2 of the specification
class VectorTile_Feature extends $pb.GeneratedMessage {
  factory VectorTile_Feature({
    $fixnum.Int64? id,
    $core.Iterable<$core.int>? tags,
    VectorTile_GeomType? type,
    $core.Iterable<$core.int>? geometry,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (tags != null) result.tags.addAll(tags);
    if (type != null) result.type = type;
    if (geometry != null) result.geometry.addAll(geometry);
    return result;
  }

  VectorTile_Feature._();

  factory VectorTile_Feature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VectorTile_Feature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VectorTile.Feature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'vector_tile'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$core.int>(2, _omitFieldNames ? '' : 'tags', $pb.PbFieldType.KU3)
    ..aE<VectorTile_GeomType>(3, _omitFieldNames ? '' : 'type',
        defaultOrMaker: VectorTile_GeomType.UNKNOWN,
        enumValues: VectorTile_GeomType.values)
    ..p<$core.int>(4, _omitFieldNames ? '' : 'geometry', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile_Feature clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile_Feature copyWith(void Function(VectorTile_Feature) updates) =>
      super.copyWith((message) => updates(message as VectorTile_Feature))
          as VectorTile_Feature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VectorTile_Feature create() => VectorTile_Feature._();
  @$core.override
  VectorTile_Feature createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VectorTile_Feature getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VectorTile_Feature>(create);
  static VectorTile_Feature? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Tags of this feature are encoded as repeated pairs of
  /// integers.
  /// A detailed description of tags is located in sections
  /// 4.2 and 4.4 of the specification
  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get tags => $_getList(1);

  /// The type of geometry stored in this feature.
  @$pb.TagNumber(3)
  VectorTile_GeomType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(VectorTile_GeomType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  /// Contains a stream of commands and parameters (vertices).
  /// A detailed description on geometry encoding is located in
  /// section 4.3 of the specification.
  @$pb.TagNumber(4)
  $pb.PbList<$core.int> get geometry => $_getList(3);
}

/// Layers are described in section 4.1 of the specification
class VectorTile_Layer extends $pb.GeneratedMessage {
  factory VectorTile_Layer({
    $core.String? name,
    $core.Iterable<VectorTile_Feature>? features,
    $core.Iterable<$core.String>? keys,
    $core.Iterable<VectorTile_Value>? values,
    $core.int? extent,
    $core.int? version,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (features != null) result.features.addAll(features);
    if (keys != null) result.keys.addAll(keys);
    if (values != null) result.values.addAll(values);
    if (extent != null) result.extent = extent;
    if (version != null) result.version = version;
    return result;
  }

  VectorTile_Layer._();

  factory VectorTile_Layer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VectorTile_Layer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VectorTile.Layer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'vector_tile'),
      createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'name')
    ..pPM<VectorTile_Feature>(2, _omitFieldNames ? '' : 'features',
        subBuilder: VectorTile_Feature.create)
    ..pPS(3, _omitFieldNames ? '' : 'keys')
    ..pPM<VectorTile_Value>(4, _omitFieldNames ? '' : 'values',
        subBuilder: VectorTile_Value.create)
    ..aI(5, _omitFieldNames ? '' : 'extent',
        fieldType: $pb.PbFieldType.OU3, defaultOrMaker: 4096)
    ..aI(15, _omitFieldNames ? '' : 'version',
        fieldType: $pb.PbFieldType.QU3, defaultOrMaker: 1)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile_Layer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile_Layer copyWith(void Function(VectorTile_Layer) updates) =>
      super.copyWith((message) => updates(message as VectorTile_Layer))
          as VectorTile_Layer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VectorTile_Layer create() => VectorTile_Layer._();
  @$core.override
  VectorTile_Layer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VectorTile_Layer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VectorTile_Layer>(create);
  static VectorTile_Layer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// The actual features in this tile.
  @$pb.TagNumber(2)
  $pb.PbList<VectorTile_Feature> get features => $_getList(1);

  /// Dictionary encoding for keys
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get keys => $_getList(2);

  /// Dictionary encoding for values
  @$pb.TagNumber(4)
  $pb.PbList<VectorTile_Value> get values => $_getList(3);

  /// Although this is an "optional" field it is required by the specification.
  /// See https://github.com/mapbox/vector-tile-spec/issues/47
  @$pb.TagNumber(5)
  $core.int get extent => $_getI(4, 4096);
  @$pb.TagNumber(5)
  set extent($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExtent() => $_has(4);
  @$pb.TagNumber(5)
  void clearExtent() => $_clearField(5);

  /// Any compliant implementation must first read the version
  /// number encoded in this message and choose the correct
  /// implementation for this version number before proceeding to
  /// decode other parts of this message.
  @$pb.TagNumber(15)
  $core.int get version => $_getI(5, 1);
  @$pb.TagNumber(15)
  set version($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(15)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(15)
  void clearVersion() => $_clearField(15);
}

class VectorTile extends $pb.GeneratedMessage {
  factory VectorTile({
    $core.Iterable<VectorTile_Layer>? layers,
  }) {
    final result = create();
    if (layers != null) result.layers.addAll(layers);
    return result;
  }

  VectorTile._();

  factory VectorTile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VectorTile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VectorTile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'vector_tile'),
      createEmptyInstance: create)
    ..pPM<VectorTile_Layer>(3, _omitFieldNames ? '' : 'layers',
        subBuilder: VectorTile_Layer.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VectorTile copyWith(void Function(VectorTile) updates) =>
      super.copyWith((message) => updates(message as VectorTile)) as VectorTile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VectorTile create() => VectorTile._();
  @$core.override
  VectorTile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VectorTile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VectorTile>(create);
  static VectorTile? _defaultInstance;

  @$pb.TagNumber(3)
  $pb.PbList<VectorTile_Layer> get layers => $_getList(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
