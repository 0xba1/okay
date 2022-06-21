import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  Result<int, String> op1() => ok(666);

  Result<int, String> op2() => err('sadface');

  test('and', () {
    expect(op1().and(ok(667)).unwrap(), 667);
    expect(op1().and(err<int, String>('bad')).unwrapErr(), 'bad');

    expect(op2().and(ok(667)).unwrapErr(), 'sadface');
    expect(op2().and(err<int, String>('bad')).unwrapErr(), 'sadface');
  });

  test('andThen', () {
    expect(op1().andThen((i) => ok<int, String>(i + 1)).unwrap(), 667);
    expect(op1().andThen((_) => err<int, String>('bad')).unwrapErr(), 'bad');

    expect(op2().andThen((i) => ok<int, String>(i + 1)).unwrapErr(), 'sadface');
    expect(
      op2().andThen((_) => err<int, String>('bad')).unwrapErr(),
      'sadface',
    );
  });

  test('or', () {
    expect(op1().or(ok<int, String>(667)).unwrap(), 666);
    expect(op1().or(err('bad')).unwrap(), 666);

    expect(op2().or(ok<int, String>(667)).unwrap(), 667);
    expect(op2().or(err('bad')).unwrapErr(), 'bad');
  });

  test('orElse', () {
    expect(op1().orElse((_) => ok<int, String>(667)).unwrap(), 666);
    expect(op1().orElse((e) => err<int, String>(e)).unwrap(), 666);

    expect(op2().orElse((_) => ok<int, String>(667)).unwrap(), 667);
    expect(
      op2().orElse((e) => err<int, String>(e)).unwrapErr(),
      'sadface',
    );
  });

  test('map', () {
    expect(ok<int, int>(1).map((x) => x + 1), ok<int, int>(2));

    expect(err<int, int>(1).map((x) => x + 1), err<int, int>(1));
  });

  test('mapErr', () {
    expect(ok<int, int>(1).mapErr((x) => x + 1), ok<int, int>(1));

    expect(err<int, int>(1).mapErr((x) => x + 1), err<int, int>(2));
  });

  test('unwrapOr', () {
    final tOk = ok<int, String>(100);
    final tOkErr = err<int, String>('Err');

    expect(tOk.unwrapOr(50), 100);
    expect(tOkErr.unwrapOr(50), 50);
  });

  test('okOrErr', () {
    final tOk = ok<int, int>(100);
    final tErr = err<int, int>(200);

    expect(tOk.okOrErr(), 100);
    expect(tErr.okOrErr(), 200);
  });

  test('unwrapOrElse', () {
    int handler(String msg) {
      if (msg == 'I got this.') {
        return 50;
      } else {
        throw Exception('BadBad');
      }
    }

    final tOk = ok<int, String>(100);
    final tErr = err<int, String>('I got this.');

    expect(tOk.unwrapOrElse(handler), 100);
    expect(tErr.unwrapOrElse(handler), 50);
  });

  test('unwrapOrElse throw exception', () {
    int handler(String msg) {
      if (msg == 'I got this.') {
        return 50;
      } else {
        throw Exception('BadBad');
      }
    }

    final badErr = err<int, String>('Unrecoverable mess.');

    expect(() => badErr.unwrapOrElse(handler), throwsException);
  });

  test('expect (`ok`)', () {
    final tOk = ok<int, String>(100);

    expect(tOk.expect('Unexpected error'), 100);
  });

  test('expect (`err`)', () {
    final tErr = err<int, String>('All good');

    expect(() => tErr.expect('Got expected error'), throwsException);
  });

  test('expectErr (`err`)', () {
    final tErr = err<String, int>(100);

    expect(tErr.expectErr('Unexpected ok'), 100);
  });

  test('expectErr (`ok`)', () {
    final tOk = ok<String, int>('All good');

    expect(() => tOk.expectErr('Got expected ok'), throwsException);
  });
}
