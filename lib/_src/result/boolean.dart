part of '../result.dart';

/// Boolean operations on the values
extension Boolean<T, E> on Result<T, E> {
  /// Return `res` if the result is `ok`,
  /// otherwise returns the `err` value of `this`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// Result<String, String> y = err('late error');
  /// expect(x.and(y), err('late error'));
  ///
  /// Result<int, String> x = err('early error');
  /// Result<String, String> y = ok('foo');
  /// expect(x.and(y), err('early error'));
  ///
  /// Result<int, String> x = err('not a 2');
  /// Result<String, String> y = err('late error');
  /// expect(x.and(y), err('not a too'));
  ///
  /// Result<int, String> x = ok(2);
  /// Result<String, String> y = ok('different result type');
  /// expect(x.and(y), err('different result type'));
  /// ```
  Result<U, E> and<U>(Result<U, E> res) {
    switch (_type) {
      case ResultType.ok:
        return res;
      case ResultType.err:
        return Result.err(_err);
    }
  }
}
