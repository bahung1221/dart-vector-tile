// This is a generated file - do not edit.
//
// Generated from vector_tile.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile$json = {
  '1': 'VectorTile',
  '2': [
    {
      '1': 'layers',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.vector_tile.VectorTile.Layer',
      '10': 'layers'
    },
  ],
  '3': [VectorTile_Value$json, VectorTile_Feature$json, VectorTile_Layer$json],
  '4': [VectorTile_GeomType$json],
  '5': [
    {'1': 16, '2': 8192},
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_Value$json = {
  '1': 'Value',
  '2': [
    {'1': 'string_value', '3': 1, '4': 1, '5': 9, '10': 'stringValue'},
    {'1': 'float_value', '3': 2, '4': 1, '5': 2, '10': 'floatValue'},
    {'1': 'double_value', '3': 3, '4': 1, '5': 1, '10': 'doubleValue'},
    {'1': 'int_value', '3': 4, '4': 1, '5': 3, '10': 'intValue'},
    {'1': 'uint_value', '3': 5, '4': 1, '5': 4, '10': 'uintValue'},
    {'1': 'sint_value', '3': 6, '4': 1, '5': 18, '10': 'sintValue'},
    {'1': 'bool_value', '3': 7, '4': 1, '5': 8, '10': 'boolValue'},
  ],
  '5': [
    {'1': 8, '2': 536870912},
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_Feature$json = {
  '1': 'Feature',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '7': '0', '10': 'id'},
    {
      '1': 'tags',
      '3': 2,
      '4': 3,
      '5': 13,
      '8': {'2': true},
      '10': 'tags',
    },
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.vector_tile.VectorTile.GeomType',
      '7': 'UNKNOWN',
      '10': 'type'
    },
    {
      '1': 'geometry',
      '3': 4,
      '4': 3,
      '5': 13,
      '8': {'2': true},
      '10': 'geometry',
    },
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_Layer$json = {
  '1': 'Layer',
  '2': [
    {'1': 'version', '3': 15, '4': 2, '5': 13, '7': '1', '10': 'version'},
    {'1': 'name', '3': 1, '4': 2, '5': 9, '10': 'name'},
    {
      '1': 'features',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.vector_tile.VectorTile.Feature',
      '10': 'features'
    },
    {'1': 'keys', '3': 3, '4': 3, '5': 9, '10': 'keys'},
    {
      '1': 'values',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.vector_tile.VectorTile.Value',
      '10': 'values'
    },
    {'1': 'extent', '3': 5, '4': 1, '5': 13, '7': '4096', '10': 'extent'},
  ],
  '5': [
    {'1': 16, '2': 536870912},
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_GeomType$json = {
  '1': 'GeomType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'POINT', '2': 1},
    {'1': 'LINESTRING', '2': 2},
    {'1': 'POLYGON', '2': 3},
  ],
};

/// Descriptor for `VectorTile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vectorTileDescriptor = $convert.base64Decode(
    'CgpWZWN0b3JUaWxlEjUKBmxheWVycxgDIAMoCzIdLnZlY3Rvcl90aWxlLlZlY3RvclRpbGUuTG'
    'F5ZXJSBmxheWVycxryAQoFVmFsdWUSIQoMc3RyaW5nX3ZhbHVlGAEgASgJUgtzdHJpbmdWYWx1'
    'ZRIfCgtmbG9hdF92YWx1ZRgCIAEoAlIKZmxvYXRWYWx1ZRIhCgxkb3VibGVfdmFsdWUYAyABKA'
    'FSC2RvdWJsZVZhbHVlEhsKCWludF92YWx1ZRgEIAEoA1IIaW50VmFsdWUSHQoKdWludF92YWx1'
    'ZRgFIAEoBFIJdWludFZhbHVlEh0KCnNpbnRfdmFsdWUYBiABKBJSCXNpbnRWYWx1ZRIdCgpib2'
    '9sX3ZhbHVlGAcgASgIUglib29sVmFsdWUqCAgIEICAgIACGpMBCgdGZWF0dXJlEhEKAmlkGAEg'
    'ASgEOgEwUgJpZBIWCgR0YWdzGAIgAygNQgIQAVIEdGFncxI9CgR0eXBlGAMgASgOMiAudmVjdG'
    '9yX3RpbGUuVmVjdG9yVGlsZS5HZW9tVHlwZToHVU5LTk9XTlIEdHlwZRIeCghnZW9tZXRyeRgE'
    'IAMoDUICEAFSCGdlb21ldHJ5GugBCgVMYXllchIbCgd2ZXJzaW9uGA8gAigNOgExUgd2ZXJzaW'
    '9uEhIKBG5hbWUYASACKAlSBG5hbWUSOwoIZmVhdHVyZXMYAiADKAsyHy52ZWN0b3JfdGlsZS5W'
    'ZWN0b3JUaWxlLkZlYXR1cmVSCGZlYXR1cmVzEhIKBGtleXMYAyADKAlSBGtleXMSNQoGdmFsdW'
    'VzGAQgAygLMh0udmVjdG9yX3RpbGUuVmVjdG9yVGlsZS5WYWx1ZVIGdmFsdWVzEhwKBmV4dGVu'
    'dBgFIAEoDToENDA5NlIGZXh0ZW50KggIEBCAgICAAiI/CghHZW9tVHlwZRILCgdVTktOT1dOEA'
    'ASCQoFUE9JTlQQARIOCgpMSU5FU1RSSU5HEAISCwoHUE9MWUdPThADKgUIEBCAQA==');
