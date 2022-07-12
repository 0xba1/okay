part of '../_result.dart';

/// Compares contained `ok` or `err` value
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
  bool contains(Object? x) {
    switch (_type) {
      case _ResultType.ok:
        return _ok == x;
      case _ResultType.err:
        return false;
    }
  }

  /// Returns `true` if the result is an `err` (failure) value
  /// containing the given value.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.containsErr('Some error message'), false);
  ///
  /// Result<int, String> x = err('Some error message');
  /// expect(x.contains('Some error message'), true);
  ///
  /// Result<int, String> x = err('Some other error message');
  /// expect(x.contains('Some error message'), false);
  /// ```
  bool containsErr(Object? x) {
    switch (_type) {
      case _ResultType.err:
        return _err == x;
      case _ResultType.ok:
        return false;
    }
  }
}
