import 'package:okay/okay.dart';
import 'package:test/test.dart';

/// final list = [ok(4), ok(7), ok(2), err('first'), ok(9), err('second')];
/// final resultList = list.collect();
/// expect(resultList, err('first'));
///
/// final list = [ok(1), ok(2), ok(3), ok(4)];
/// final resultList = list.collect();
/// expect(resultList, ok([1, 2, 3, 4]));
void main() {
  group('Iterable.collect', () {
    test('List with an `err` returns `err`', () {
      final list = <Result<int, String>>[
        ok(4),
        ok(7),
        ok(2),
        err('first'),
        ok(9),
        err('second')
      ];
      final resultList = list.collect();
      expect(resultList, err<Iterable<int>, String>('first'));
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        ok(1),
        ok(2),
        ok(3),
        ok(4),
      ];
      final resultList = list.collect();
      expect(resultList.unwrap(), [1, 2, 3, 4]);
    });
  });

  group('Iterable.collectOr', () {
    test('List with an `err`', () {
      final list = <Result<int, String>>[
        ok(4),
        ok(7),
        ok(2),
        err('first'),
        ok(9),
        err('second')
      ];
      final valueList = list.collectOr(0);
      expect(valueList, [4, 7, 2, 0, 9, 0]);
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        ok(1),
        ok(2),
        ok(3),
        ok(4),
      ];
      final valueList = list.collectOr(1);
      expect(valueList, [1, 2, 3, 4]);
    });
  });

  group('Iterable.collectOrElse', () {
    test('List with an `err`', () {
      final list = <Result<int, String>>[
        ok(4),
        ok(7),
        ok(2),
        err('first'),
        ok(9),
        err('second')
      ];
      final valueList = list.collectOrElse((error) => error.length);
      expect(valueList, [4, 7, 2, 5, 9, 6]);
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        ok(1),
        ok(2),
        ok(3),
        ok(4),
      ];
      final valueList = list.collectOrElse((error) => error.length);
      expect(valueList, [1, 2, 3, 4]);
    });
  });

  group('Iterable.sieve', () {
    test('List with `err`', () {
      final list = <Result<int, String>>[
        ok(4),
        ok(7),
        ok(2),
        err('first'),
        ok(9),
        err('second')
      ];
      final valueList = list.sieve();
      expect(valueList, [4, 7, 2, 9]);
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        ok(1),
        ok(2),
        ok(3),
        ok(4),
      ];
      final valueList = list.sieve();
      expect(valueList, [1, 2, 3, 4]);
    });

    test('List with only `err`', () {
      final list = <Result<int, String>>[
        err('Bad'),
        err('Really bad'),
        err('Really really bad'),
      ];
      final valueList = list.sieve();
      expect(valueList, <int>[]);
    });
  });
}
