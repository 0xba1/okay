import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  group('Result.contains():', () {
    test('ok contains value, true', () {
      const x = Ok<int, String>(2);
      expect(x.contains(2), true);
    });

    test('ok contains value, false', () {
      const x = Ok<int, String>(3);
      expect(x.contains(2), false);
    });

    test('err contains value', () {
      const x = Err<int, String>('Some error message');
      expect(x.contains(2), false);
    });
  });

  group('Result.containsErr():', () {
    test('ok containsErr value', () {
      const x = Ok<int, String>(2);
      expect(x.containsErr('Some error message'), false);
    });

    test('err containsErr value, true', () {
      const x = Err<int, String>('Some error message');
      expect(x.containsErr('Some error message'), true);
    });

    test('err containsErr value, false', () {
      const x = Err<int, String>('Some other error message');
      expect(x.containsErr('Some error message'), false);
    });
  });
}
