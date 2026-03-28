import 'package:test/test.dart';
import 'package:vector_tile/util/command.dart';

void main() {
  group('CommandID', () {
    test('has correct constant values', () {
      expect(CommandID.MoveTo, 1);
      expect(CommandID.LineTo, 2);
      expect(CommandID.ClosePath, 7);
    });
  });

  group('Command.CommandInteger', () {
    test('decodes MoveTo with count 1', () {
      // MoveTo(1) = (1 << 3) | 1 = 9
      final cmd = Command.CommandInteger(command: 9);
      expect(cmd.id, CommandID.MoveTo);
      expect(cmd.count, 1);
    });

    test('decodes LineTo with count 2', () {
      // LineTo(2) = (2 << 3) | 2 = 18
      final cmd = Command.CommandInteger(command: 18);
      expect(cmd.id, CommandID.LineTo);
      expect(cmd.count, 2);
    });

    test('decodes ClosePath with count 1', () {
      // ClosePath(1) = (1 << 3) | 7 = 15
      final cmd = Command.CommandInteger(command: 15);
      expect(cmd.id, CommandID.ClosePath);
      expect(cmd.count, 1);
    });

    test('decodes MoveTo with large count', () {
      // MoveTo(100) = (100 << 3) | 1 = 801
      final cmd = Command.CommandInteger(command: 801);
      expect(cmd.id, CommandID.MoveTo);
      expect(cmd.count, 100);
    });
  });

  group('zigZagEncode', () {
    test('encodes 0', () {
      expect(Command.zigZagEncode(0), 0);
    });

    test('encodes positive values', () {
      expect(Command.zigZagEncode(1), 2);
      expect(Command.zigZagEncode(2), 4);
      expect(Command.zigZagEncode(100), 200);
    });

    test('encodes negative values', () {
      expect(Command.zigZagEncode(-1), 1);
      expect(Command.zigZagEncode(-2), 3);
      expect(Command.zigZagEncode(-100), 199);
    });
  });

  group('zigZagDecode', () {
    test('decodes 0', () {
      expect(Command.zigZagDecode(0), 0);
    });

    test('decodes positive values', () {
      expect(Command.zigZagDecode(2), 1);
      expect(Command.zigZagDecode(4), 2);
      expect(Command.zigZagDecode(200), 100);
    });

    test('decodes negative values', () {
      expect(Command.zigZagDecode(1), -1);
      expect(Command.zigZagDecode(3), -2);
      expect(Command.zigZagDecode(199), -100);
    });

    test('round-trips with zigZagEncode', () {
      for (final val in [0, 1, -1, 42, -42, 1000, -1000]) {
        expect(Command.zigZagDecode(Command.zigZagEncode(val)), val);
      }
    });
  });
}
