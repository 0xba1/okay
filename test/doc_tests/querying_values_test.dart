import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  group('Result.isOk', () {
    test('on `ok`', () {
      const x = Ok<int, String>(9);

      expect(x.isOk, true);
    });

    test('on `err`', () {
      const x = Err<int, String>('An unexpected error occured');

      expect(x.isOk, false);
    });
  });

  group('Result.isOkAnd', () {
    test('on `ok`', () {
      const x = Ok<int, String>(9);

      expect(x.isOkAnd((int val) => val > 5), true);

      expect(x.isOkAnd((int val) => val < 5), false);

      expect(x.isOk, true);
    });

    test('on `err`', () {
      const x = Err<int, String>('An unexpected error occured');

      expect(x.isOkAnd((_) => true), false);
    });
  });

  group('Result.isErr', () {
    test('on `err`', () {
      const x = Err<int, String>('An unexpected error occured');

      expect(x.isErr, true);
    });

    test('on `ok`', () {
      const x = Ok<int, String>(0);

      expect(x.isErr, false);
    });
  });

  group('Result.isErrAnd', () {
    test('on `err`', () {
      const x = Err<int, String>('An unexpected error occured');

      expect(x.isErrAnd((String value) => value.isNotEmpty), true);

      expect(x.isErrAnd((String value) => value.isEmpty), false);
    });

    test('on `ok`', () {
      const x = Ok<int, String>(0);

      expect(x.isErrAnd((_) => true), false);
    });
  });
}
