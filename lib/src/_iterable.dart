import 'package:okay/src/_result.dart';

/// Converts an `Iterable<Result<T, E>>` to a `Result<Iterable<T>, E>`
extension Collect<T, E> on Iterable<Result<T, E>> {
  /// Convert an `Iterable<Result<T, E>>` to a `Result<Iterable<T>, E>`.
  /// If there is an `err` in the iterable the first `err` is returned.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = [ok(4), ok(7), ok(2), err('first'), ok(9), err('second')];
  /// final resultList = list.collect();
  /// expect(resultList, err('first'));
  ///
  /// final list = [ok(1), ok(2), ok(3), ok(4)];
  /// final resultList = list.collect();
  /// expect(resultList, ok([1, 2, 3, 4]));
  /// ```
  Result<Iterable<T>, E> collect() {
    if (any((result) => result.isErr)) {
      final error = firstWhere(
        (Result<T, E> result) => result.isErr,
      ).unwrapErr();
      return Result.err(error);
    }

    return Result.ok(map((Result<T, E> result) => result.unwrap()));
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `err` values are replaced by the provided `fallback`.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = [ok(4), ok(7), ok(2), err('first'), ok(9), err('second')];
  /// final valueList = list.collectOr(0);
  /// expect(valueList, [4, 7, 2, 0, 9, 0]);
  ///
  /// final list = [ok(1), ok(2), ok(3), ok(4)];
  /// final valueList = list.collectOr(0);
  /// expect(valueList, [1, 2, 3, 4]);
  /// ```
  Iterable<T> collectOr(T fallback) {
    return map((Result<T, E> result) {
      if (result.isErr) {
        return fallback;
      }

      return result.unwrap();
    });
  }

  /// Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`.
  /// All `err` values are replaced by the result of the provided function.
  ///
  /// ## Basic usage
  ///
  /// ```dart
  /// final list = [ok(4), ok(7), ok(2), err('first'), ok(9), err('second')];
  /// final valueList = list.collectOrElse((error) => error.length);
  /// expect(valueList, [4, 7, 2, 5, 9, 6]);
  ///
  /// final list = [ok(1), ok(2), ok(3), ok(4)];
  /// final valueList = list.collectOrElse((error) => error.length);
  /// expect(valueList, [1, 2, 3, 4]);
  /// ```
  Iterable<T> collectOrElse(T Function(E error) errMap) {
    return map((Result<T, E> result) {
      if (result.isErr) {
        return errMap(result.unwrapErr());
      }

      return result.unwrap();
    });
  }
}
