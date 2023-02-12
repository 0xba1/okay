import 'package:okay/okay.dart';
import 'package:test/test.dart';

/// final list = [Ok(4), Ok(7), Ok(2), Err('first'), Ok(9), Err('second')];
/// final resultList = list.collect();
/// expect(resultList, Err('first'));
///
/// final list = [Ok(1), Ok(2), Ok(3), Ok(4)];
/// final resultList = list.collect();
/// expect(resultList, Ok([1, 2, 3, 4]));
void main() {
  group('Iterable.collect', () {
    test('List with an `err` returns `err`', () {
      final list = <Result<int, String>>[
        const Ok(4),
        const Ok(7),
        const Ok(2),
        const Err('first'),
        const Ok(9),
        const Err('second')
      ];
      final resultList = list.collect();
      expect(resultList, const Err<Iterable<int>, String>('first'));
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        const Ok(1),
        const Ok(2),
        const Ok(3),
        const Ok(4),
      ];
      final resultList = list.collect();
      expect(resultList.unwrap(), [1, 2, 3, 4]);
    });
  });

  group('Iterable.collectOr', () {
    test('List with an `err`', () {
      final list = <Result<int, String>>[
        const Ok(4),
        const Ok(7),
        const Ok(2),
        const Err('first'),
        const Ok(9),
        const Err('second')
      ];
      final valueList = list.collectOr(0);
      expect(valueList, [4, 7, 2, 0, 9, 0]);
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        const Ok(1),
        const Ok(2),
        const Ok(3),
        const Ok(4),
      ];
      final valueList = list.collectOr(1);
      expect(valueList, [1, 2, 3, 4]);
    });
  });

  group('Iterable.collectOrElse', () {
    test('List with an `err`', () {
      final list = <Result<int, String>>[
        const Ok(4),
        const Ok(7),
        const Ok(2),
        const Err('first'),
        const Ok(9),
        const Err('second')
      ];
      final valueList = list.collectOrElse((error) => error.length);
      expect(valueList, [4, 7, 2, 5, 9, 6]);
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        const Ok(1),
        const Ok(2),
        const Ok(3),
        const Ok(4),
      ];
      final valueList = list.collectOrElse((error) => error.length);
      expect(valueList, [1, 2, 3, 4]);
    });
  });

  group('Iterable.sieve', () {
    test('List with `err`', () {
      final list = <Result<int, String>>[
        const Ok(4),
        const Ok(7),
        const Ok(2),
        const Err('first'),
        const Ok(9),
        const Err('second')
      ];
      final valueList = list.sieve();
      expect(valueList, [4, 7, 2, 9]);
    });

    test('List with no `err` returns `ok`', () {
      final list = <Result<int, String>>[
        const Ok(1),
        const Ok(2),
        const Ok(3),
        const Ok(4),
      ];
      final valueList = list.sieve();
      expect(valueList, [1, 2, 3, 4]);
    });

    test('List with only `err`', () {
      final list = <Result<int, String>>[
        const Err('Bad'),
        const Err('Really bad'),
        const Err('Really really bad'),
      ];
      final valueList = list.sieve();
      expect(valueList, <int>[]);
    });
  });

  group('Iterable.sieveErr', () {
    test('List with `err`', () {
      final list = <Result<int, String>>[
        const Ok(4),
        const Ok(7),
        const Ok(2),
        const Err('first'),
        const Ok(9),
        const Err('second')
      ];
      final errorList = list.sieveErr();
      expect(errorList, ['first', 'second']);
    });

    test('List with no `err` returns `[]`', () {
      final list = <Result<int, String>>[
        const Ok(1),
        const Ok(2),
        const Ok(3),
        const Ok(4),
      ];
      final errorList = list.sieveErr();
      expect(errorList, <String>[]);
    });

    test('List with only `err`', () {
      final list = <Result<int, String>>[
        const Err('Bad'),
        const Err('Really bad'),
        const Err('Really really bad'),
      ];
      final errorList = list.sieveErr();
      expect(errorList, [
        'Bad',
        'Really bad',
        'Really really bad',
      ]);
    });
  });
}
