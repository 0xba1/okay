part of '../result.dart';

/// Querying the contained values
extension QueryingValues<T, E> on Result<T, E> {
  /// Resturns `true` if the result is `ok` (success)
  ///
  /// # Expamples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(9);
  /// expect(x.isOk(), true);
  ///
  /// Result<int, String> y = err('An unexpected error occured');
  /// expect(x.isOk(), false);
  /// ```
  bool isOk() {
    return _type == ResultType.ok;
  }

  /// Returns `true` if the result is `ok` and the value matches the predicate `f`
  ///
  /// # Examples
  ///
  /// ```dart
  /// Result<int, String> x = ok(9);
  /// expect(x.isOkAnd((int val) => val > 5), true);
  ///
  /// expect(x.isOkAnd((int val) => val < 5), false);
  ///
  /// Result<int, String> y = err('An unexpected error occured');
  /// expect(x.isOk(), false);
  /// ```
  bool isOkAnd(bool Function(T) f) {
    if (_type == ResultType.ok) {
      return f(_ok);
    }

    return false;
  }

  /// Resturns `true` if the result is `ok` (success)
  ///
  /// # Expamples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> y = err('An unexpected error occured');
  /// expect(x.isErr(), true);
  ///
  /// Result<int, String> x = ok(0);
  /// expect(x.isErr(), false);
  /// ```
  bool isErr() {
    return _type == ResultType.err;
  }
}
