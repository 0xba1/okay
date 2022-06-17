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

  /// Returns the contained `ok` (success) value.
  /// Because this function may throw an exception, its use is generally discouraged.
  /// Instead, prefer to use `switch` statements with the `Result.type`
  /// and handle the `err` (failure) case explicitly, or call [`unwrapOr`],
  /// [`unwrapOrElse`].
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `err`, with exception message
  /// provided by the `err`'s value.
  ///
  /// ## Examples
  ///
  /// Basic Usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(69);
  /// expect(x.unwrap(), 69);
  /// ```
  T unwrap() {
    switch (_type) {
      case ResultType.ok:
        return _ok;
      case ResultType.err:
        throw UnwrapException(
          errString: _errValue.toString(),
        );
    }
  }

  /// Returns the contained `err` (failure) value.
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `ok` (success),
  /// with the exception message including the passed message,
  /// and the content of the `ok` value.
  ///
  /// ## Examples
  ///
  /// ```dart
  ///Result<int, String> x = ok(9);
  ///x.expectErr("Testing expectErr"); // throws an exception with `Testing expectErr: 9`
  /// ```
  E expectErr(String message) {
    switch (_type) {
      case ResultType.err:
        return _err;
      case ResultType.ok:
        throw ExpectErrException(
          errorMessage: message,
          okString: _okValue.toString(),
        );
    }
  }
}
