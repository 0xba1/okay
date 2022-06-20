import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  group('Result.okOrErr()', () {
    test('on `ok`', () {
      final x = ok<int, int>(3);

      expect(x.okOrErr(), 3);
    });

    test('on `err`', () {
      final x = err<int, int>(4);

      expect(x.okOrErr(), 4);
    });
  });
}
