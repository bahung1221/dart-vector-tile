///
//  Generated code. Do not modify.
//  source: proto/vector_tile.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile$json = const {
  '1': 'VectorTile',
  '2': const [
    const {'1': 'layers', '3': 3, '4': 3, '5': 11, '6': '.vector_tile.VectorTile.Layer', '10': 'layers'},
  ],
  '3': const [VectorTile_Value$json, VectorTile_Feature$json, VectorTile_Layer$json],
  '4': const [VectorTile_GeomType$json],
  '5': const [
    const {'1': 16, '2': 8192},
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_Value$json = const {
  '1': 'Value',
  '2': const [
    const {'1': 'string_value', '3': 1, '4': 1, '5': 9, '10': 'stringValue'},
    const {'1': 'float_value', '3': 2, '4': 1, '5': 2, '10': 'floatValue'},
    const {'1': 'double_value', '3': 3, '4': 1, '5': 1, '10': 'doubleValue'},
    const {'1': 'int_value', '3': 4, '4': 1, '5': 3, '10': 'intValue'},
    const {'1': 'uint_value', '3': 5, '4': 1, '5': 4, '10': 'uintValue'},
    const {'1': 'sint_value', '3': 6, '4': 1, '5': 18, '10': 'sintValue'},
    const {'1': 'bool_value', '3': 7, '4': 1, '5': 8, '10': 'boolValue'},
  ],
  '5': const [
    const {'1': 8, '2': 536870912},
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_Feature$json = const {
  '1': 'Feature',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '7': '0', '10': 'id'},
    const {
      '1': 'tags',
      '3': 2,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'tags',
    },
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.vector_tile.VectorTile.GeomType', '7': 'UNKNOWN', '10': 'type'},
    const {
      '1': 'geometry',
      '3': 4,
      '4': 3,
      '5': 13,
      '8': const {'2': true},
      '10': 'geometry',
    },
    const {'1': 'raster', '3': 5, '4': 1, '5': 12, '10': 'raster'},
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_Layer$json = const {
  '1': 'Layer',
  '2': const [
    const {'1': 'version', '3': 15, '4': 2, '5': 13, '7': '1', '10': 'version'},
    const {'1': 'name', '3': 1, '4': 2, '5': 9, '10': 'name'},
    const {'1': 'features', '3': 2, '4': 3, '5': 11, '6': '.vector_tile.VectorTile.Feature', '10': 'features'},
    const {'1': 'keys', '3': 3, '4': 3, '5': 9, '10': 'keys'},
    const {'1': 'values', '3': 4, '4': 3, '5': 11, '6': '.vector_tile.VectorTile.Value', '10': 'values'},
    const {'1': 'extent', '3': 5, '4': 1, '5': 13, '7': '4096', '10': 'extent'},
  ],
  '5': const [
    const {'1': 16, '2': 536870912},
  ],
};

@$core.Deprecated('Use vectorTileDescriptor instead')
const VectorTile_GeomType$json = const {
  '1': 'GeomType',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'POINT', '2': 1},
    const {'1': 'LINESTRING', '2': 2},
    const {'1': 'POLYGON', '2': 3},
  ],
};

/// Descriptor for `VectorTile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vectorTileDescriptor = $convert.base64Decode('CgpWZWN0b3JUaWxlEjUKBmxheWVycxgDIAMoCzIdLnZlY3Rvcl90aWxlLlZlY3RvclRpbGUuTGF5ZXJSBmxheWVycxryAQoFVmFsdWUSIQoMc3RyaW5nX3ZhbHVlGAEgASgJUgtzdHJpbmdWYWx1ZRIfCgtmbG9hdF92YWx1ZRgCIAEoAlIKZmxvYXRWYWx1ZRIhCgxkb3VibGVfdmFsdWUYAyABKAFSC2RvdWJsZVZhbHVlEhsKCWludF92YWx1ZRgEIAEoA1IIaW50VmFsdWUSHQoKdWludF92YWx1ZRgFIAEoBFIJdWludFZhbHVlEh0KCnNpbnRfdmFsdWUYBiABKBJSCXNpbnRWYWx1ZRIdCgpib29sX3ZhbHVlGAcgASgIUglib29sVmFsdWUqCAgIEICAgIACGqsBCgdGZWF0dXJlEhEKAmlkGAEgASgEOgEwUgJpZBIWCgR0YWdzGAIgAygNQgIQAVIEdGFncxI9CgR0eXBlGAMgASgOMiAudmVjdG9yX3RpbGUuVmVjdG9yVGlsZS5HZW9tVHlwZToHVU5LTk9XTlIEdHlwZRIeCghnZW9tZXRyeRgEIAMoDUICEAFSCGdlb21ldHJ5EhYKBnJhc3RlchgFIAEoDFIGcmFzdGVyGugBCgVMYXllchIbCgd2ZXJzaW9uGA8gAigNOgExUgd2ZXJzaW9uEhIKBG5hbWUYASACKAlSBG5hbWUSOwoIZmVhdHVyZXMYAiADKAsyHy52ZWN0b3JfdGlsZS5WZWN0b3JUaWxlLkZlYXR1cmVSCGZlYXR1cmVzEhIKBGtleXMYAyADKAlSBGtleXMSNQoGdmFsdWVzGAQgAygLMh0udmVjdG9yX3RpbGUuVmVjdG9yVGlsZS5WYWx1ZVIGdmFsdWVzEhwKBmV4dGVudBgFIAEoDToENDA5NlIGZXh0ZW50KggIEBCAgICAAiI/CghHZW9tVHlwZRILCgdVTktOT1dOEAASCQoFUE9JTlQQARIOCgpMSU5FU1RSSU5HEAISCwoHUE9MWUdPThADKgUIEBCAQA==');
