import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  Result<int, String> parseToInt(String value) {
    try {
      return ok(int.parse(value));
    } catch (_) {
      return err(value);
    }
  }

  group('Result.when()', () {
    test('on `ok`', () {
      final x = ok<int, int>(9);

      expect(
        x.when(
          err: (error) => 'Failure: $error',
          ok: (value) => 'Success: $value',
        ),
        'Success: 9',
      );
    });

    test('on `err`', () {
      final x = err<int, int>(81);

      expect(
        x.when(
          err: (error) => 'Failure: $error',
          ok: (value) => 'Success: $value',
        ),
        'Failure: 81',
      );
    });
  });

  group('Result.map()', () {
    Result<bool, String> isStringGreaterThanFive(String value) {
      return parseToInt(value).map((int val) => val > 5);
    }

    test('on `ok`', () {
      expect(isStringGreaterThanFive('7'), ok<bool, String>(true));

      expect(isStringGreaterThanFive('4'), ok<bool, String>(false));
    });

    test('on `err`', () {
      expect(isStringGreaterThanFive('five'), err<bool, String>('five'));
    });
  });

  group('Result.mapOr()', () {
    test('on `ok`', () {
      final x = ok<String, String>('foo');

      expect(x.mapOr(fallback: 42, okMap: (val) => val.length), 3);
    });

    test('on `err`', () {
      final x = err<String, String>('foo');

      expect(x.mapOr(fallback: 42, okMap: (val) => val.length), 42);
    });
  });

  group('Result.mapOrElse()', () {
    test('on `ok`', () {
      final x = ok<int, int>(9);

      expect(
        x.mapOrElse(
          errMap: (error) => 'Failure: $error',
          okMap: (value) => 'Success: $value',
        ),
        'Success: 9',
      );
    });

    test('on `err`', () {
      final x = err<int, int>(81);

      expect(
        x.mapOrElse(
          errMap: (error) => 'Failure: $error',
          okMap: (value) => 'Success: $value',
        ),
        'Failure: 81',
      );
    });
  });
}
