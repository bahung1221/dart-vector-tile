import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';
import 'package:vector_tile/vector_tile_value.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;

void main() {
  group('VectorTileValue factory', () {
    test('creates string value', () {
      final v = VectorTileValue(stringValue: 'hello');
      expect(v.type, ValueType.string);
      expect(v.value, 'hello');
    });

    test('creates float value', () {
      final v = VectorTileValue(floatValue: 1.5);
      expect(v.type, ValueType.float);
      expect(v.value, 1.5);
    });

    test('creates double value', () {
      final v = VectorTileValue(doubleValue: 2.5);
      expect(v.type, ValueType.double);
      expect(v.value, 2.5);
    });

    test('creates int value', () {
      final v = VectorTileValue(intValue: Int64(42));
      expect(v.type, ValueType.int);
      expect(v.value, Int64(42));
    });

    test('creates uint value', () {
      final v = VectorTileValue(uintValue: Int64(99));
      expect(v.type, ValueType.uint);
    });

    test('creates sint value', () {
      final v = VectorTileValue(sintValue: Int64(-10));
      expect(v.type, ValueType.sint);
    });

    test('creates bool value', () {
      final v = VectorTileValue(boolValue: true);
      expect(v.type, ValueType.bool);
      expect(v.value, true);
    });

    test('throws when no value provided', () {
      expect(() => VectorTileValue(), throwsArgumentError);
    });

    test('first non-null value wins', () {
      final v = VectorTileValue(stringValue: 'win', floatValue: 1.0);
      expect(v.type, ValueType.string);
      expect(v.value, 'win');
    });
  });

  group('VectorTileValue type-safe getters', () {
    test('stringValue returns value for string type', () {
      final v = VectorTileValue(stringValue: 'test');
      expect(v.stringValue, 'test');
      expect(v.floatValue, isNull);
      expect(v.boolValue, isNull);
      expect(v.intValue, isNull);
    });

    test('floatValue returns value for float type', () {
      final v = VectorTileValue(floatValue: 3.14);
      expect(v.floatValue, 3.14);
      expect(v.doubleValue, isNull);
      expect(v.stringValue, isNull);
    });

    test('doubleValue returns value for double type', () {
      final v = VectorTileValue(doubleValue: 2.718);
      expect(v.doubleValue, 2.718);
      expect(v.floatValue, isNull);
    });

    test('intValue returns value for int type only', () {
      final v = VectorTileValue(intValue: Int64(5));
      expect(v.intValue, Int64(5));
      expect(v.uintValue, isNull);
      expect(v.sintValue, isNull);
    });

    test('boolValue returns value for bool type', () {
      final v = VectorTileValue(boolValue: false);
      expect(v.boolValue, false);
      expect(v.stringValue, isNull);
    });
  });

  group('VectorTileValue dart convenience getters', () {
    test('dartIntValue returns int, uint, or sint', () {
      expect(
        VectorTileValue(intValue: Int64(1)).dartIntValue,
        Int64(1),
      );
      expect(
        VectorTileValue(uintValue: Int64(2)).dartIntValue,
        Int64(2),
      );
      expect(
        VectorTileValue(sintValue: Int64(3)).dartIntValue,
        Int64(3),
      );
      expect(
        VectorTileValue(stringValue: 'x').dartIntValue,
        isNull,
      );
    });

    test('dartDoubleValue returns float or double', () {
      expect(VectorTileValue(floatValue: 1.0).dartDoubleValue, 1.0);
      expect(VectorTileValue(doubleValue: 2.0).dartDoubleValue, 2.0);
      expect(VectorTileValue(stringValue: 'x').dartDoubleValue, isNull);
    });

    test('dartStringValue returns string', () {
      expect(VectorTileValue(stringValue: 'hi').dartStringValue, 'hi');
      expect(VectorTileValue(boolValue: true).dartStringValue, isNull);
    });

    test('dartBoolValue returns bool', () {
      expect(VectorTileValue(boolValue: true).dartBoolValue, true);
      expect(VectorTileValue(stringValue: 'x').dartBoolValue, isNull);
    });
  });

  group('VectorTileValue fromRaw/toRaw round-trip', () {
    test('round-trips string value', () {
      final original = VectorTileValue(stringValue: 'hello');
      final rawVal = original.toRaw();
      final restored = VectorTileValue.fromRaw(rawVal);
      expect(restored.type, ValueType.string);
      expect(restored.stringValue, 'hello');
    });

    test('round-trips float value', () {
      final original = VectorTileValue(floatValue: 1.5);
      final rawVal = original.toRaw();
      final restored = VectorTileValue.fromRaw(rawVal);
      expect(restored.type, ValueType.float);
      expect(restored.floatValue, closeTo(1.5, 0.001));
    });

    test('round-trips double value', () {
      final original = VectorTileValue(doubleValue: 3.14159);
      final rawVal = original.toRaw();
      final restored = VectorTileValue.fromRaw(rawVal);
      expect(restored.type, ValueType.double);
      expect(restored.doubleValue, 3.14159);
    });

    test('round-trips int value', () {
      final original = VectorTileValue(intValue: Int64(-42));
      final rawVal = original.toRaw();
      final restored = VectorTileValue.fromRaw(rawVal);
      expect(restored.type, ValueType.int);
      expect(restored.intValue, Int64(-42));
    });

    test('round-trips bool value', () {
      final original = VectorTileValue(boolValue: true);
      final rawVal = original.toRaw();
      final restored = VectorTileValue.fromRaw(rawVal);
      expect(restored.type, ValueType.bool);
      expect(restored.boolValue, true);
    });
  });

  group('VectorTileValue.fromRaw', () {
    test('creates from raw string', () {
      final rawVal = raw.VectorTile_Value(stringValue: 'test');
      final v = VectorTileValue.fromRaw(rawVal);
      expect(v.type, ValueType.string);
      expect(v.value, 'test');
    });

    test('creates from raw bool', () {
      final rawVal = raw.VectorTile_Value(boolValue: false);
      final v = VectorTileValue.fromRaw(rawVal);
      expect(v.type, ValueType.bool);
      expect(v.value, false);
    });
  });
}
