import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  test('1 equals 1', () {
    expect(1, 1);
  });

  group('Result.expect():', () {
    test('on `ok`', () {
      final x = ok<int, String>(5);
      expect(x.expect('Should return 5'), 5);
    });

    test('on `err`', () {
      final x = err<int, String>('emergency failure');
      expect(() => x.expect('Should return 5'), throwsException);
    });
  });

  group('Result.unwrap():', () {
    test('on `ok`', () {
      final x = ok<int, String>(69);
      expect(x.unwrap(), 69);
    });
  });

  group('Result.expectErr():', () {
    test('on `ok`', () {
      final x = ok<int, String>(9);
      expect(() => x.expectErr('Testing expectErr'), throwsException);
    });
  });

  group('Result.unwrapErr():', () {
    test('on `ok`', () {
      final x = ok<int, String>(2);
      expect(x.unwrapErr, throwsException);
    });

    test('on `err`', () {
      final x = err<int, String>('emergency failure');
      expect(x.unwrapErr(), 'emergency failure');
    });
  });

  group('Result.unwrapOr():', () {
    const fallback = 23;

    test('on `ok`', () {
      final x = ok<int, String>(9);
      expect(x.unwrapOr(fallback), 9);
    });

    test('on `err`', () {
      final x = err<int, String>('Error!');
      expect(x.unwrapOr(fallback), fallback);
    });
  });

  group('Result.unwrapOr():', () {
    int count(String x) => x.length;

    test('on `ok`', () {
      final x = ok<int, String>(2);
      expect(x.unwrapOrElse(count), 2);
    });

    test('on `err`', () {
      final x = err<int, String>('foo');
      expect(x.unwrapOrElse(count), 3);
    });
  });
}
