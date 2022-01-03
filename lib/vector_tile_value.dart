import 'package:fixnum/fixnum.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;

enum ValueType {
  string,
  float,
  double,
  int,
  uint,
  sint,
  bool,
}

class VectorTileValue {
  final ValueType type;
  final Object value;

  VectorTileValue.from(this.type, this.value);

  factory VectorTileValue({
    String? stringValue,
    double? floatValue,
    double? doubleValue,
    Int64? intValue,
    Int64? uintValue,
    Int64? sintValue,
    bool? boolValue,
  }) {
    if (stringValue != null) {
      return VectorTileValue.from(ValueType.string, stringValue);
    }
    if (floatValue != null) {
      return VectorTileValue.from(ValueType.float, floatValue);
    }
    if (doubleValue != null) {
      return VectorTileValue.from(ValueType.double, doubleValue);
    }
    if (intValue != null) {
      return VectorTileValue.from(ValueType.int, intValue);
    }
    if (uintValue != null) {
      return VectorTileValue.from(ValueType.uint, uintValue);
    }
    if (sintValue != null) {
      return VectorTileValue.from(ValueType.sint, sintValue);
    }
    if (boolValue != null) {
      return VectorTileValue.from(ValueType.bool, boolValue);
    }
    throw ArgumentError('No value provided');
  }

  factory VectorTileValue.fromRaw(raw.VectorTile_Value value) {
    if (value.hasStringValue()) {
      return VectorTileValue.from(ValueType.string, value.stringValue);
    }
    if (value.hasFloatValue()) {
      return VectorTileValue.from(ValueType.float, value.floatValue);
    }
    if (value.hasDoubleValue()) {
      return VectorTileValue.from(ValueType.double, value.doubleValue);
    }
    if (value.hasIntValue()) {
      return VectorTileValue.from(ValueType.int, value.intValue);
    }
    if (value.hasUintValue()) {
      return VectorTileValue.from(ValueType.uint, value.uintValue);
    }
    if (value.hasSintValue()) {
      return VectorTileValue.from(ValueType.sint, value.sintValue);
    }
    if (value.hasBoolValue()) {
      return VectorTileValue.from(ValueType.bool, value.boolValue);
    }
    throw StateError('unreachable');
  }

  raw.VectorTile_Value toRaw() {
    switch (type) {
      case ValueType.string:
        return raw.VectorTile_Value(stringValue: value as String);
      case ValueType.float:
        return raw.VectorTile_Value(floatValue: value as double);
      case ValueType.double:
        return raw.VectorTile_Value(doubleValue: value as double);
      case ValueType.int:
        return raw.VectorTile_Value(intValue: value as Int64);
      case ValueType.uint:
        return raw.VectorTile_Value(uintValue: value as Int64);
      case ValueType.sint:
        return raw.VectorTile_Value(sintValue: value as Int64);
      case ValueType.bool:
        return raw.VectorTile_Value(boolValue: value as bool);
    }
  }

  String? get stringValue {
    final value = this.value;
    return value is String ? value : null;
  }

  double? get floatValue {
    final value = this.value;
    return type == ValueType.float ? value as double : null;
  }

  double? get doubleValue {
    final value = this.value;
    return type == ValueType.double ? value as double : null;
  }

  Int64? get intValue {
    final value = this.value;
    return type == ValueType.int ? value as Int64 : null;
  }

  Int64? get uintValue {
    final value = this.value;
    return type == ValueType.uint ? value as Int64 : null;
  }

  Int64? get sintValue {
    final value = this.value;
    return type == ValueType.sint ? value as Int64 : null;
  }

  bool? get boolValue {
    final value = this.value;
    return value is bool ? value : null;
  }

  String? get dartStringValue {
    return this.stringValue;
  }

  Int64? get dartIntValue {
    return this.intValue ?? this.uintValue ?? this.sintValue;
  }

  double? get dartDoubleValue {
    return this.floatValue ?? this.doubleValue;
  }

  bool? get dartBoolValue {
    return this.boolValue;
  }
}
