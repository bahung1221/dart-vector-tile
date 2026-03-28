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

import 'package:protobuf/protobuf.dart' as $pb;

/// GeomType is described in section 4.3.4 of the specification
class VectorTile_GeomType extends $pb.ProtobufEnum {
  static const VectorTile_GeomType UNKNOWN =
      VectorTile_GeomType._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const VectorTile_GeomType POINT =
      VectorTile_GeomType._(1, _omitEnumNames ? '' : 'POINT');
  static const VectorTile_GeomType LINESTRING =
      VectorTile_GeomType._(2, _omitEnumNames ? '' : 'LINESTRING');
  static const VectorTile_GeomType POLYGON =
      VectorTile_GeomType._(3, _omitEnumNames ? '' : 'POLYGON');

  static const $core.List<VectorTile_GeomType> values = <VectorTile_GeomType>[
    UNKNOWN,
    POINT,
    LINESTRING,
    POLYGON,
  ];

  static final $core.List<VectorTile_GeomType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static VectorTile_GeomType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VectorTile_GeomType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
