part of '../result.dart';

/// Extract value or error
extension Extractors<T, E> on Result<T, E> {
  /// Returns the contained `ok` (success) value.
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `err` (failure),
  /// with an exception message including the passed message,
  /// and the content of the `err`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = err("emergency failure");
  /// x.expect("Testing expect"); // Throws an exception with message `Testing expect: emergency failure`
  ///
  /// Result<int, String> y = ok(5);
  /// print(x.expect("Should print `5`")); // 5
  /// ```
  T expect(String message) {
    switch (_type) {
      case ResultType.ok:
        return _ok;
      case ResultType.err:
        throw ExpectException(
          errorMessage: message,
          errString: _errValue.toString(),
        );
    }
  }
}
