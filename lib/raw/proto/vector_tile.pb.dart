///
//  Generated code. Do not modify.
//  source: proto/vector_tile.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'vector_tile.pbenum.dart';

export 'vector_tile.pbenum.dart';

class VectorTile_Value extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VectorTile.Value', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'vector_tile'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stringValue')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'floatValue', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'doubleValue', $pb.PbFieldType.OD)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'intValue')
    ..a<$fixnum.Int64>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uintValue', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sintValue', $pb.PbFieldType.OS6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'boolValue')
    ..hasExtensions = true
  ;

  VectorTile_Value._() : super();
  factory VectorTile_Value({
    $core.String? stringValue,
    $core.double? floatValue,
    $core.double? doubleValue,
    $fixnum.Int64? intValue,
    $fixnum.Int64? uintValue,
    $fixnum.Int64? sintValue,
    $core.bool? boolValue,
  }) {
    final _result = create();
    if (stringValue != null) {
      _result.stringValue = stringValue;
    }
    if (floatValue != null) {
      _result.floatValue = floatValue;
    }
    if (doubleValue != null) {
      _result.doubleValue = doubleValue;
    }
    if (intValue != null) {
      _result.intValue = intValue;
    }
    if (uintValue != null) {
      _result.uintValue = uintValue;
    }
    if (sintValue != null) {
      _result.sintValue = sintValue;
    }
    if (boolValue != null) {
      _result.boolValue = boolValue;
    }
    return _result;
  }
  factory VectorTile_Value.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VectorTile_Value.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VectorTile_Value clone() => VectorTile_Value()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VectorTile_Value copyWith(void Function(VectorTile_Value) updates) => super.copyWith((message) => updates(message as VectorTile_Value)) as VectorTile_Value; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VectorTile_Value create() => VectorTile_Value._();
  VectorTile_Value createEmptyInstance() => create();
  static $pb.PbList<VectorTile_Value> createRepeated() => $pb.PbList<VectorTile_Value>();
  @$core.pragma('dart2js:noInline')
  static VectorTile_Value getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VectorTile_Value>(create);
  static VectorTile_Value? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stringValue => $_getSZ(0);
  @$pb.TagNumber(1)
  set stringValue($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStringValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearStringValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get floatValue => $_getN(1);
  @$pb.TagNumber(2)
  set floatValue($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFloatValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearFloatValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get doubleValue => $_getN(2);
  @$pb.TagNumber(3)
  set doubleValue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDoubleValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleValue() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get intValue => $_getI64(3);
  @$pb.TagNumber(4)
  set intValue($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIntValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearIntValue() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get uintValue => $_getI64(4);
  @$pb.TagNumber(5)
  set uintValue($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUintValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearUintValue() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sintValue => $_getI64(5);
  @$pb.TagNumber(6)
  set sintValue($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSintValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearSintValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get boolValue => $_getBF(6);
  @$pb.TagNumber(7)
  set boolValue($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBoolValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearBoolValue() => clearField(7);
}

class VectorTile_Feature extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VectorTile.Feature', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'vector_tile'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags', $pb.PbFieldType.KU3)
    ..e<VectorTile_GeomType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: VectorTile_GeomType.UNKNOWN, valueOf: VectorTile_GeomType.valueOf, enumValues: VectorTile_GeomType.values)
    ..p<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'geometry', $pb.PbFieldType.KU3)
    ..hasRequiredFields = false
  ;

  VectorTile_Feature._() : super();
  factory VectorTile_Feature({
    $fixnum.Int64? id,
    $core.Iterable<$core.int>? tags,
    VectorTile_GeomType? type,
    $core.Iterable<$core.int>? geometry,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    if (type != null) {
      _result.type = type;
    }
    if (geometry != null) {
      _result.geometry.addAll(geometry);
    }
    return _result;
  }
  factory VectorTile_Feature.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VectorTile_Feature.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VectorTile_Feature clone() => VectorTile_Feature()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VectorTile_Feature copyWith(void Function(VectorTile_Feature) updates) => super.copyWith((message) => updates(message as VectorTile_Feature)) as VectorTile_Feature; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VectorTile_Feature create() => VectorTile_Feature._();
  VectorTile_Feature createEmptyInstance() => create();
  static $pb.PbList<VectorTile_Feature> createRepeated() => $pb.PbList<VectorTile_Feature>();
  @$core.pragma('dart2js:noInline')
  static VectorTile_Feature getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VectorTile_Feature>(create);
  static VectorTile_Feature? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get tags => $_getList(1);

  @$pb.TagNumber(3)
  VectorTile_GeomType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(VectorTile_GeomType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get geometry => $_getList(3);
}

class VectorTile_Layer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VectorTile.Layer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'vector_tile'), createEmptyInstance: create)
    ..aQS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<VectorTile_Feature>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'features', $pb.PbFieldType.PM, subBuilder: VectorTile_Feature.create)
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'keys')
    ..pc<VectorTile_Value>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'values', $pb.PbFieldType.PM, subBuilder: VectorTile_Value.create)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'extent', $pb.PbFieldType.OU3, defaultOrMaker: 4096)
    ..a<$core.int>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'version', $pb.PbFieldType.QU3, defaultOrMaker: 1)
    ..hasExtensions = true
  ;

  VectorTile_Layer._() : super();
  factory VectorTile_Layer({
    $core.String? name,
    $core.Iterable<VectorTile_Feature>? features,
    $core.Iterable<$core.String>? keys,
    $core.Iterable<VectorTile_Value>? values,
    $core.int? extent,
    $core.int? version,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (features != null) {
      _result.features.addAll(features);
    }
    if (keys != null) {
      _result.keys.addAll(keys);
    }
    if (values != null) {
      _result.values.addAll(values);
    }
    if (extent != null) {
      _result.extent = extent;
    }
    if (version != null) {
      _result.version = version;
    }
    return _result;
  }
  factory VectorTile_Layer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VectorTile_Layer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VectorTile_Layer clone() => VectorTile_Layer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VectorTile_Layer copyWith(void Function(VectorTile_Layer) updates) => super.copyWith((message) => updates(message as VectorTile_Layer)) as VectorTile_Layer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VectorTile_Layer create() => VectorTile_Layer._();
  VectorTile_Layer createEmptyInstance() => create();
  static $pb.PbList<VectorTile_Layer> createRepeated() => $pb.PbList<VectorTile_Layer>();
  @$core.pragma('dart2js:noInline')
  static VectorTile_Layer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VectorTile_Layer>(create);
  static VectorTile_Layer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<VectorTile_Feature> get features => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<$core.String> get keys => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<VectorTile_Value> get values => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get extent => $_getI(4, 4096);
  @$pb.TagNumber(5)
  set extent($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExtent() => $_has(4);
  @$pb.TagNumber(5)
  void clearExtent() => clearField(5);

  @$pb.TagNumber(15)
  $core.int get version => $_getI(5, 1);
  @$pb.TagNumber(15)
  set version($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(15)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(15)
  void clearVersion() => clearField(15);
}

class VectorTile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VectorTile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'vector_tile'), createEmptyInstance: create)
    ..pc<VectorTile_Layer>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'layers', $pb.PbFieldType.PM, subBuilder: VectorTile_Layer.create)
    ..hasExtensions = true
  ;

  VectorTile._() : super();
  factory VectorTile({
    $core.Iterable<VectorTile_Layer>? layers,
  }) {
    final _result = create();
    if (layers != null) {
      _result.layers.addAll(layers);
    }
    return _result;
  }
  factory VectorTile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VectorTile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VectorTile clone() => VectorTile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VectorTile copyWith(void Function(VectorTile) updates) => super.copyWith((message) => updates(message as VectorTile)) as VectorTile; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VectorTile create() => VectorTile._();
  VectorTile createEmptyInstance() => create();
  static $pb.PbList<VectorTile> createRepeated() => $pb.PbList<VectorTile>();
  @$core.pragma('dart2js:noInline')
  static VectorTile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VectorTile>(create);
  static VectorTile? _defaultInstance;

  @$pb.TagNumber(3)
  $core.List<VectorTile_Layer> get layers => $_getList(0);
}

