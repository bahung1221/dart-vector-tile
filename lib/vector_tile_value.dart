import 'package:fixnum/fixnum.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;

class VectorTileValue {
  String stringValue;
  double floatValue;
  double doubleValue;
  Int64 intValue;
  Int64 uintValue;
  Int64 sintValue;
  bool boolValue;
  
  VectorTileValue({
    this.stringValue,
    this.floatValue,
    this.doubleValue,
    this.intValue,
    this.uintValue,
    this.sintValue,
    this.boolValue,
  });

  raw.VectorTile_Value toRaw() {
    return raw.VectorTile_Value(
      stringValue: this.stringValue,
      floatValue: this.floatValue,
      doubleValue: this.doubleValue,
      intValue: this.intValue,
      uintValue: this.uintValue,
      sintValue: this.sintValue,
      boolValue: this.boolValue,
    );
  }

  String get dartStringValue {
    return this.stringValue;
  }

  Int64 get dartIntValue {
    return this.intValue ?? this.uintValue ?? this.sintValue;
  }

  double get dartDoubleValue {
    if (this.floatValue != null) {
      return this.floatValue.toDouble();
    }
    
    return this.doubleValue;
  }

  bool get dartBoolValue {
    return this.boolValue;
  }
}
