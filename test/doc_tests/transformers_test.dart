import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  Result<int, String> parseToInt(String value) {
    try {
      return Ok(int.parse(value));
    } catch (_) {
      return Err(value);
    }
  }

  group('Result.when()', () {
    test('on `ok`', () {
      const x = Ok<int, int>(9);

      expect(
        x.when(
          err: (error) => 'Failure: $error',
          ok: (value) => 'Success: $value',
        ),
        'Success: 9',
      );
    });

    test('on `err`', () {
      const x = Err<int, int>(81);

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
      expect(isStringGreaterThanFive('7'), const Ok<bool, String>(true));

      expect(isStringGreaterThanFive('4'), const Ok<bool, String>(false));
    });

    test('on `err`', () {
      expect(isStringGreaterThanFive('five'), const Err<bool, String>('five'));
    });
  });

  group('Result.mapOr()', () {
    test('on `ok`', () {
      const x = Ok<String, String>('foo');

      expect(x.mapOr(fallback: 42, okMap: (val) => val.length), 3);
    });

    test('on `err`', () {
      const x = Err<String, String>('foo');

      expect(x.mapOr(fallback: 42, okMap: (val) => val.length), 42);
    });
  });

  group('Result.mapOrElse()', () {
    test('on `ok`', () {
      const x = Ok<int, int>(9);

      expect(
        x.mapOrElse(
          errMap: (error) => 'Failure: $error',
          okMap: (value) => 'Success: $value',
        ),
        'Success: 9',
      );
    });

    test('on `err`', () {
      const x = Err<int, int>(81);

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
