import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  Result<int, String> op1() => const Ok(666);

  Result<int, String> op2() => const Err('sadface');

  test('and', () {
    expect(op1().and(const Ok(667)).unwrap(), 667);
    expect(op1().and(const Err<int, String>('bad')).unwrapErr(), 'bad');

    expect(op2().and(const Ok(667)).unwrapErr(), 'sadface');
    expect(op2().and(const Err<int, String>('bad')).unwrapErr(), 'sadface');
  });

  test('andThen', () {
    expect(op1().andThen((i) => Ok<int, String>(i + 1)).unwrap(), 667);
    expect(
      op1().andThen((_) => const Err<int, String>('bad')).unwrapErr(),
      'bad',
    );

    expect(op2().andThen((i) => Ok<int, String>(i + 1)).unwrapErr(), 'sadface');
    expect(
      op2().andThen((_) => const Err<int, String>('bad')).unwrapErr(),
      'sadface',
    );
  });

  test('or', () {
    expect(op1().or(const Ok<int, String>(667)).unwrap(), 666);
    expect(op1().or(const Err('bad')).unwrap(), 666);

    expect(op2().or(const Ok<int, String>(667)).unwrap(), 667);
    expect(op2().or(const Err('bad')).unwrapErr(), 'bad');
  });

  test('orElse', () {
    expect(op1().orElse((_) => const Ok<int, String>(667)).unwrap(), 666);
    expect(op1().orElse(Err<int, String>.new).unwrap(), 666);

    expect(op2().orElse((_) => const Ok<int, String>(667)).unwrap(), 667);
    expect(
      op2().orElse(Err<int, String>.new).unwrapErr(),
      'sadface',
    );
  });

  test('map', () {
    expect(const Ok<int, int>(1).map((x) => x + 1), const Ok<int, int>(2));

    expect(const Err<int, int>(1).map((x) => x + 1), const Err<int, int>(1));
  });

  test('mapErr', () {
    expect(const Ok<int, int>(1).mapErr((x) => x + 1), const Ok<int, int>(1));

    expect(const Err<int, int>(1).mapErr((x) => x + 1), const Err<int, int>(2));
  });

  test('unwrapOr', () {
    const tOk = Ok<int, String>(100);
    const tOkErr = Err<int, String>('Err');

    expect(tOk.unwrapOr(50), 100);
    expect(tOkErr.unwrapOr(50), 50);
  });

  test('unwrapOrElse', () {
    int handler(String msg) {
      if (msg == 'I got this.') {
        return 50;
      } else {
        throw Exception('BadBad');
      }
    }

    const tOk = Ok<int, String>(100);
    const tErr = Err<int, String>('I got this.');

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

    const badErr = Err<int, String>('Unrecoverable mess.');

    expect(() => badErr.unwrapOrElse(handler), throwsException);
  });

  test('expect (`ok`)', () {
    const tOk = Ok<int, String>(100);

    expect(tOk.expect('Unexpected error'), 100);
  });

  test('expect (`err`)', () {
    const tErr = Err<int, String>('All good');

    expect(() => tErr.expect('Got expected error'), throwsException);
  });

  test('expectErr (`err`)', () {
    const tErr = Err<String, int>(100);

    expect(tErr.expectErr('Unexpected ok'), 100);
  });

  test('expectErr (`ok`)', () {
    const tOk = Ok<String, int>('All good');

    expect(() => tOk.expectErr('Got expected ok'), throwsException);
  });

  test('toString (`ok`)', () {
    const tOk = Ok<int, int>(9);

    expect(tOk.toString(), 'Ok( 9 )');
  });

  test('toString (`err`)', () {
    const tErr = Err<int, int>(81);

    expect(tErr.toString(), 'Err( 81 )');
  });

  test('hashcode (`ok`)', () {
    const tOk = Ok<int, int>(9);

    expect(tOk.hashCode, const Ok<int, int>(9).hashCode);
  });

  test('hashcode (`err`)', () {
    const tErr = Err<int, int>(81);

    expect(tErr.hashCode, const Err<int, int>(81).hashCode);
  });

  test('Nullable values and errors', () {
    const String? nullOk = null;
    const int? nullErr = null;

    const okResult = Ok<String?, int?>(nullOk);

    const errResult = Err<String?, int?>(nullErr);

    expect(okResult.unwrap(), nullOk);
    expect(errResult.unwrapErr(), nullErr);
  });
}
