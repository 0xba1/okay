part of '../result.dart';

/// Adapter for each variant
extension Adapter<T, E> on Result<T, E> {
  /// Converts from `Result<T, E>` to `T?`.
  ///
  /// # Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.ok(), 2);
  ///
  /// Result<int, String> y = err("An error occured");
  /// expect(y.ok(), null);
  /// ```
  T? ok() {
    switch (_type) {
      case ResultType.ok:
        return _okValue;
      case ResultType.err:
        return null;
    }
  }
}
