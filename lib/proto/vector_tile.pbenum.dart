///
//  Generated code. Do not modify.
//  source: proto/vector_tile.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class VectorTile_GeomType extends $pb.ProtobufEnum {
  static const VectorTile_GeomType UNKNOWN = VectorTile_GeomType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const VectorTile_GeomType POINT = VectorTile_GeomType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POINT');
  static const VectorTile_GeomType LINESTRING = VectorTile_GeomType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LINESTRING');
  static const VectorTile_GeomType POLYGON = VectorTile_GeomType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POLYGON');

  static const $core.List<VectorTile_GeomType> values = <VectorTile_GeomType> [
    UNKNOWN,
    POINT,
    LINESTRING,
    POLYGON,
  ];

  static final $core.Map<$core.int, VectorTile_GeomType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VectorTile_GeomType valueOf($core.int value) => _byValue[value];

  const VectorTile_GeomType._($core.int v, $core.String n) : super(v, n);
}

