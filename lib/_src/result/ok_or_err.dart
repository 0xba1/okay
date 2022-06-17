part of '../result.dart';

/// `ok` and `err` have the same type
extension OkOrErr<T> on Result<T, T> {
  /// Returns the `ok` (success) value if `type` is `ok`,
  /// and the `err` (failure) value if `type` is `err`.
  ///
  /// In other words, this function returns the value (`T`) of a `Result<T, T>`,
  /// regardless of whether or not that result is `ok` or `err`
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, int> x = ok(3);
  /// Result<int, int> y = err(4);
  ///
  /// expect(x.okOrErr(), 3);
  /// expect(y.okOrErr(), 4);
  /// ```
  T okOrErr() {
    switch (_type) {
      case ResultType.ok:
        return _ok;
      case ResultType.err:
        return _err;
    }
  }
}
