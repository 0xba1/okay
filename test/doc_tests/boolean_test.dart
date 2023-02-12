import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  group('Result.and() docs:', () {
    test('ok and err', () {
      const x = Ok<int, String>(2);
      const y = Err<String, String>('late error');

      expect(x.and(y), const Err<String, String>('late error'));
    });

    test('err and ok', () {
      const x = Err<int, String>('early error');
      const y = Ok<String, String>('foo');

      expect(x.and(y), const Err<String, String>('early error'));
    });

    test('err and err', () {
      const x = Err<int, String>('not a 2');
      const y = Ok<String, String>('late error');

      expect(x.and(y), const Err<String, String>('not a 2'));
    });

    test('ok and ok', () {
      const x = Ok<int, String>(2);
      const y = Ok<String, String>('different result type');

      expect(x.and(y), const Ok<String, String>('different result type'));
    });
  });

  test('Result.andThen()', () {
    Result<int, String> parseToInt(String value) {
      try {
        return Ok(int.parse(value));
      } catch (_) {
        return Err(value);
      }
    }

    const x = Ok<String, String>('4');
    final y = x.andThen(parseToInt);

    expect(y, const Ok<int, String>(4));
  });

  group('Result.or():', () {
    test('ok or err', () {
      const x = Ok<int, String>(2);
      const y = Err<int, String>('late error');

      expect(x.or(y), const Ok<int, String>(2));
    });

    test('err or ok', () {
      const x = Err<int, String>('early error');
      const y = Ok<int, String>(2);

      expect(x.or(y), const Ok<int, String>(2));
    });

    test('err or err', () {
      const x = Err<int, String>('not a 2');
      const y = Err<int, String>('late error');

      expect(x.or(y), const Err<int, String>('late error'));
    });

    test('ok or ok', () {
      const x = Ok<int, String>(2);
      const y = Ok<int, String>(100);

      expect(x.or(y), const Ok<int, String>(2));
    });
  });

  group(
    'Result.orElse():',
    () {
      Result<int, int> sq(int x) => Ok(x * x);
      Result<int, int> error(int x) => Err(x);

      test('ok, ok, ok', () {
        expect(
          const Ok<int, int>(2).orElse(sq).orElse(sq),
          const Ok<int, int>(2),
        );
      });

      test('ok, err, ok', () {
        expect(
          const Ok<int, int>(2).orElse(error).orElse(sq),
          const Ok<int, int>(2),
        );
      });

      test('err, ok, err', () {
        expect(
          const Err<int, int>(3).orElse(sq).orElse(error),
          const Ok<int, int>(9),
        );
      });

      test('err, err, err', () {
        expect(
          const Err<int, int>(3).orElse(error).orElse(error),
          const Err<int, int>(3),
        );
      });
    },
  );
}
