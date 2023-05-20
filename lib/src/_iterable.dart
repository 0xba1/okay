import 'package:okay/src/_result.dart';

/// Methods on `Iterable<Result<T, E>>`
extension Collect<T, E> on Iterable<Result<T, E>> {
  /// Convert an `Iterable<Result<T, E>>` to a `Result<Iterable<T>, E>`.
  /// If there is an `Err` in the iterable the first `Err` is returned.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   Ok(4),
  ///   Ok(7),
  ///   Ok(2),
  ///   Err('first'),
  ///   Ok(9),
  ///   Err('second'),
  /// ];
  /// final resultList = list.collect();
  /// expect(resultList, ErrIterable<int>, String>('first'));
  ///
  /// final list = <Result<int, String>>[Ok(1), Ok(2), Ok(3), Ok(4)];
  /// final resultList = list.collect();
  /// expect(resultList.unwrap(), [1, 2, 3, 4]);
  /// ```
  Result<Iterable<T>, E> collect() {
    try {
      final error = firstWhere(
        (Result<T, E> result) => result.isErr,
      ).unwrapErr();
      return Err(error);
    } catch (_) {
      return Ok(map((Result<T, E> result) => result.unwrap()));
    }
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `Err` values are replaced by the provided `fallback`.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   Ok(4),
  ///   Ok(7),
  ///   Ok(2),
  ///   Err('first'),
  ///   Ok(9),
  ///   Err('second'),
  /// ];
  /// final valueList = list.collectOr(0);
  /// expect(valueList, [4, 7, 2, 0, 9, 0]);
  ///
  /// final list = <Result<int, String>>[Ok(1), Ok(2), Ok(3), Ok(4)];
  /// final valueList = list.collectOr(0);
  /// expect(valueList, [1, 2, 3, 4]);
  /// ```
  Iterable<T> collectOr(T fallback) {
    return map((Result<T, E> result) {
      return result.unwrapOr(fallback);
    });
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `Err` values are replaced by the result of the provided function.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   Ok(4),
  ///   Ok(7),
  ///   Ok(2),
  ///   Err('first'),
  ///   Ok(9),
  ///   Err('second'),
  /// ];
  /// final valueList = list.collectOrElse((error) => error.length);
  /// expect(valueList, [4, 7, 2, 5, 9, 6]);
  ///
  /// final list = <Result<int, String>>[Ok(1), Ok(2), Ok(3), Ok(4)];
  /// final valueList = list.collectOrElse((error) => error.length);
  /// expect(valueList, [1, 2, 3, 4]);
  /// ```
  Iterable<T> collectOrElse(T Function(E error) errMap) {
    return map((Result<T, E> result) {
      return result.unwrapOrElse(errMap);
    });
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `Err` values are skipped.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   Ok(4),
  ///   Ok(7),
  ///   Ok(2),
  ///   Err('first'),
  ///   Ok(9),
  ///   Err('second'),
  /// ];
  /// final valueList = list.sieve();
  /// expect(valueList, [4, 7, 2, 9]);
  ///
  /// final list = <Result<int, String>>[Ok(1), Ok(2), Ok(3), Ok(4)];
  /// final valueList = list.sieve();
  /// expect(valueList, [1, 2, 3, 4]);
  ///
  /// final list = <Result<int, String>>[
  ///   Err('Bad'),
  ///   Err('Really bad'),
  ///   Err('Really really bad'),
  /// ];
  /// final valueList = list.sieve();
  /// expect(valueList, <int>[]);
  /// ```
  Iterable<T> sieve() {
    return where((Result<T, E> result) => result.isOk)
        .map((Result<T, E> result) => result.unwrap());
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<E>`.
  /// All `Ok` values are skipped.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = <Result<int, String>>[
  ///   Ok(4),
  ///   Ok(7),
  ///   Ok(2),
  ///   Err('first'),
  ///   Ok(9),
  ///   Err('second'),
  /// ];
  /// final errorList = list.sieveErr();
  /// expect(errorList, ['first', 'second']);
  ///
  /// final list = <Result<int, String>>[Ok(1), Ok(2), Ok(3), Ok(4)];
  /// final errorList = list.sieveErr();
  /// expect(errorList, <String>[]);
  ///
  /// final list = <Result<int, String>>[
  ///   Err('Bad'),
  ///   Err('Really bad'),
  ///   Err('Really really bad'),
  /// ];
  /// final errorList = list.sieveErr();
  /// expect(errorList, ['Bad', 'Really bad', 'Really really bad']);
  /// ```
  Iterable<E> sieveErr() {
    return where((Result<T, E> result) => result.isErr)
        .map((Result<T, E> result) => result.unwrapErr());
  }
}
