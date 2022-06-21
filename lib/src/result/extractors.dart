// ignore_for_file: lines_longer_than_80_chars

part of '../_result.dart';

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
  /// print(y.expect("Should print `5`")); // 5
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

  /// Returns the contained `err` (failure) value.
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `ok`, with an exception message
  /// provided by the `ok`'s value.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// x.unwrapErr(); // Throws an exception with message `called `Result.unwrapErr()` on an `ok` value: 2`
  ///
  /// Result<int, String> y = err('emergency failure');
  /// expect(y.unwrapErr(), "emergency failure");
  /// ```
  E unwrapErr() {
    switch (_type) {
      case ResultType.err:
        return _err;
      case ResultType.ok:
        throw UnwrapErrException(
          okString: _okValue.toString(),
        );
    }
  }

  /// Returns the contained `ok` (success) value or a provided fallback.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// final fallback = 23;
  ///
  /// Result<int, String> x = ok(9);
  /// expect(x.unwrapOr(fallback), 9);
  ///
  /// Result<int, String> y = err('Error!');
  /// expect(y.unwrapOr(fallback), fallback);
  /// ```
  T unwrapOr(T fallback) {
    switch (_type) {
      case ResultType.ok:
        return _ok;
      case ResultType.err:
        return fallback;
    }
  }

  /// Returns the contained `ok` (success) value
  /// or computes it from the closure.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// int count(String x) => x.length;
  ///
  /// expect(ok<int, String>(2).unwrapOrElse(count), 2);
  /// expect(err<int, String>('foo').unwrapOrElse(count), 3);
  /// ```
  T unwrapOrElse(T Function(E) fallback) {
    switch (_type) {
      case ResultType.ok:
        return _ok;
      case ResultType.err:
        return fallback(_err);
    }
  }
}
