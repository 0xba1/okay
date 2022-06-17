part of '../result.dart';

/// Compairs contained `ok` or `err` value
extension Contains<T, E> on Result<T, E> {
  /// Returns `true` if the result is an `ok` (success) value
  /// containing the given value.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.contains(2), true);
  ///
  /// Result<int, String> x = ok(3);
  /// expect(x.contains(2), false);
  ///
  /// Result<int, String> x = err('Some error message');
  /// expect(x.contains(2), false);
  /// ```
  bool contains(Object x) {
    switch (_type) {
      case ResultType.ok:
        return _ok == x;
      case ResultType.err:
        return false;
    }
  }
}
