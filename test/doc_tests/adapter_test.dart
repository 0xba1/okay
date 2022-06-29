import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  group('Result.ok() docs', () {
    test('`ok` variant', () {
      final x = ok<int, String>(2);

      expect(x.ok, 2);
    });

    test('`err` variant', () {
      final x = err<int, String>('An error occured');

      expect(x.ok, null);
    });
  });

  group('Result.err() docs', () {
    test('`ok` variant', () {
      final x = ok<int, String>(2);

      expect(x.err, null);
    });

    test('`err` variant', () {
      final x = err<int, String>('An error occured');

      expect(x.err, 'An error occured');
    });
  });
}
