import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  group('Result.and() docs:', () {
    test('ok and err', () {
      final x = ok<int, String>(2);
      final y = err<String, String>('late error');

      expect(x.and(y), err<String, String>('late error'));
    });

    test('err and ok', () {
      final x = err<int, String>('early error');
      final y = ok<String, String>('foo');

      expect(x.and(y), err<String, String>('early error'));
    });

    test('err and err', () {
      final x = err<int, String>('not a 2');
      final y = ok<String, String>('late error');

      expect(x.and(y), err<String, String>('not a 2'));
    });

    test('ok and ok', () {
      final x = ok<int, String>(2);
      final y = ok<String, String>('different result type');

      expect(x.and(y), ok<String, String>('different result type'));
    });
  });

  test('Result.andThen()', () {
    Result<int, String> parseToInt(String value) {
      try {
        return ok(int.parse(value));
      } catch (_) {
        return err(value);
      }
    }

    final x = ok<String, String>('4');
    final y = x.andThen(parseToInt);

    expect(y, ok<int, String>(4));
  });

  group('Result.or():', () {
    test('ok or err', () {
      final x = ok<int, String>(2);
      final y = err<int, String>('late error');

      expect(x.or(y), ok<int, String>(2));
    });

    test('err or ok', () {
      final x = err<int, String>('early error');
      final y = ok<int, String>(2);

      expect(x.or(y), ok<int, String>(2));
    });

    test('err or err', () {
      final x = err<int, String>('not a 2');
      final y = err<int, String>('late error');

      expect(x.or(y), err<int, String>('late error'));
    });

    test('ok or ok', () {
      final x = ok<int, String>(2);
      final y = ok<int, String>(100);

      expect(x.or(y), ok<int, String>(2));
    });
  });

  group(
    'Result.orElse():',
    () {
      Result<int, int> sq(int x) => ok(x * x);
      Result<int, int> error(int x) => err(x);

      test('ok, ok, ok', () {
        expect(ok<int, int>(2).orElse(sq).orElse(sq), ok<int, int>(2));
      });

      test('ok, err, ok', () {
        expect(ok<int, int>(2).orElse(error).orElse(sq), ok<int, int>(2));
      });

      test('err, ok, err', () {
        expect(err<int, int>(3).orElse(sq).orElse(error), ok<int, int>(9));
      });

      test('err, err, err', () {
        expect(err<int, int>(3).orElse(error).orElse(error), err<int, int>(3));
      });
    },
  );
}
