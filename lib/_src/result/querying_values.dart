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
}
