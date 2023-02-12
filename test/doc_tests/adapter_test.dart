import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  group('Result.Ok() docs', () {
    test('`ok` variant', () {
      const x = Ok<int, String>(2);

      expect(x.ok, 2);
    });

    test('`err` variant', () {
      const x = Err<int, String>('An error occured');

      expect(x.ok, null);
    });
  });

  group('Result.Err() docs', () {
    test('`ok` variant', () {
      const x = Ok<int, String>(2);

      expect(x.err, null);
    });

    test('`err` variant', () {
      const x = Err<int, String>('An error occured');

      expect(x.err, 'An error occured');
    });
  });
}
