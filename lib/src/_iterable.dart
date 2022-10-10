import 'package:okay/src/_result.dart';

/// Methods on `Iterable<Result<T, E>>`
extension Collect<T, E> on Iterable<Result<T, E>> {
  /// Convert an `Iterable<Result<T, E>>` to a `Result<Iterable<T>, E>`.
  /// If there is an `err` in the iterable the first `err` is returned.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   ok(4),
  ///   ok(7),
  ///   ok(2),
  ///   err('first'),
  ///   ok(9),
  ///   err('second'),
  /// ];
  /// final resultList = list.collect();
  /// expect(resultList, err<Iterable<int>, String>('first'));
  ///
  /// final list = <Result<int, String>>[ok(1), ok(2), ok(3), ok(4)];
  /// final resultList = list.collect();
  /// expect(resultList.unwrap(), [1, 2, 3, 4]);
  /// ```
  Result<Iterable<T>, E> collect() {
    try {
      final error = firstWhere(
        (Result<T, E> result) => result.isErr,
      ).unwrapErr();
      return Result.err(error);
    } catch (_) {
      return Result.ok(map((Result<T, E> result) => result.unwrap()));
    }
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `err` values are replaced by the provided `fallback`.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   ok(4),
  ///   ok(7),
  ///   ok(2),
  ///   err('first'),
  ///   ok(9),
  ///   err('second'),
  /// ];
  /// final valueList = list.collectOr(0);
  /// expect(valueList, [4, 7, 2, 0, 9, 0]);
  ///
  /// final list = <Result<int, String>>[ok(1), ok(2), ok(3), ok(4)];
  /// final valueList = list.collectOr(0);
  /// expect(valueList, [1, 2, 3, 4]);
  /// ```
  Iterable<T> collectOr(T fallback) {
    return map((Result<T, E> result) {
      return result.unwrapOr(fallback);
    });
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `err` values are replaced by the result of the provided function.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   ok(4),
  ///   ok(7),
  ///   ok(2),
  ///   err('first'),
  ///   ok(9),
  ///   err('second'),
  /// ];
  /// final valueList = list.collectOrElse((error) => error.length);
  /// expect(valueList, [4, 7, 2, 5, 9, 6]);
  ///
  /// final list = <Result<int, String>>[ok(1), ok(2), ok(3), ok(4)];
  /// final valueList = list.collectOrElse((error) => error.length);
  /// expect(valueList, [1, 2, 3, 4]);
  /// ```
  Iterable<T> collectOrElse(T Function(E error) errMap) {
    return map((Result<T, E> result) {
      return result.unwrapOrElse(errMap);
    });
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `err` values are skipped.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   ok(4),
  ///   ok(7),
  ///   ok(2),
  ///   err('first'),
  ///   ok(9),
  ///   err('second'),
  /// ];
  /// final valueList = list.sieve();
  /// expect(valueList, [4, 7, 2, 9]);
  ///
  /// final list = <Result<int, String>>[ok(1), ok(2), ok(3), ok(4)];
  /// final valueList = list.sieve();
  /// expect(valueList, [1, 2, 3, 4]);
  ///
  /// final list = <Result<int, String>>[
  ///   err('Bad'),
  ///   err('Really bad'),
  ///   err('Really really bad'),
  /// ];
  /// final valueList = list.sieve();
  /// expect(valueList, <int>[]);
  /// ```
  Iterable<T> sieve() {
    return where((Result<T, E> result) => result.isOk)
        .map((Result<T, E> result) => result.unwrap());
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<E>`.
  /// All `ok` values are skipped.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   ok(4),
  ///   ok(7),
  ///   ok(2),
  ///   err('first'),
  ///   ok(9),
  ///   err('second'),
  /// ];
  /// final errorList = list.sieveErr();
  /// expect(errorList, ['first', 'second']);
  ///
  /// final list = <Result<int, String>>[ok(1), ok(2), ok(3), ok(4)];
  /// final errorList = list.sieveErr();
  /// expect(errorList, <String>[]);
  ///
  /// final list = <Result<int, String>>[
  ///   err('Bad'),
  ///   err('Really bad'),
  ///   err('Really really bad'),
  /// ];
  /// final errorList = list.sieveErr();
  /// expect(errorList, ['Bad', 'Really bad', 'Really really bad']);
  /// ```
  Iterable<E> sieveErr() {
    return where((Result<T, E> result) => result.isErr)
        .map((Result<T, E> result) => result.unwrapErr());
  }
}
