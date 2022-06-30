part of '../_result.dart';

/// Transforming contained values
extension Transformers<T, E> on Result<T, E> {
  /// Maps a `Result<T, E>` to `Result<U, E>` by applying a function to a
  /// contained `ok` (success) value, and leaving an `err` (failure) value
  /// untouched.
  ///
  /// This function can be used to compose the results of two functions.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> parseToInt(String value) {
  ///   try {
  ///     return ok(int.parse(value));
  ///   } catch (_) {
  ///     return err(value);
  ///   }
  /// }
  ///
  /// Result<bool, String> isStringGreaterThanFive(String value) {
  ///   return parseToInt(value).map((int val) => val > 5);
  /// }
  ///
  /// expect(isStringGreaterThanFive("7"), ok<bool, String>(true));
  /// expect(isStringGreaterThanFive("4"), ok<bool, String>(false));
  /// expect(isStringGreaterThanFive("five"), err<bool, String>("five"));
  /// ```
  Result<U, E> map<U>(U Function(T) okMap) {
    switch (_type) {
      case _ResultType.ok:
        return Result.ok(okMap(_ok));
      case _ResultType.err:
        return Result.err(_err);
    }
  }

  /// Returns the provided fallback (if `err` (failure)), or
  /// applies a function to the contained value (if `ok` (success)).
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<String, String> x = ok("foo");
  /// expect(x.mapOr(fallback: 42, okMap: (val) => val.length)), 3);
  ///
  /// Result<String, String> x = err("foo");
  /// expect(x.mapOr(fallback: 42, okMap: (val) => val.length), 42);
  /// ```
  U mapOr<U>({required U fallback, required U Function(T) okMap}) {
    switch (_type) {
      case _ResultType.ok:
        return okMap(_ok);
      case _ResultType.err:
        return fallback;
    }
  }

  /// Maps a `Result<T, E>` to `U` by applying fallback function `fallback` to
  /// a contained `err` (failure) value, or function `op` to a
  /// contained `ok` (success) value.
  ///
  /// This function can be used to unpack a successful result
  /// while handliing an error.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, int> x = ok(9);
  /// expect(
  ///   x.mapOrElse(
  ///     errMap: (error) => 'Failure: $error',
  ///     okMap: (value) => 'Success: $value',
  ///   ),
  ///   'Success: 9',
  /// );
  ///
  /// Result<int, int> x = err(81);
  /// expect(
  ///   x.mapOrElse(
  ///     errMap: (error) => 'Failure: $error',
  ///     okMap: (value) => 'Success: $value',
  ///   ),
  ///   'Failed: 81',
  /// );
  /// ```
  U mapOrElse<U>({
    required U Function(E) errMap,
    required U Function(T) okMap,
  }) {
    switch (_type) {
      case _ResultType.ok:
        return okMap(_ok);
      case _ResultType.err:
        return errMap(_err);
    }
  }

  /// Maps a `Result<T, E>` to `Result<T, F>` by applying a function to a
  /// contained `err` (failure) value,
  /// leaving an `ok` (success) value untouched.
  ///
  /// This function can be used to pass through a successful result while
  /// handling an error.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// String stringify(int x) => 'error code: $x';
  ///
  /// Result<int, int> x = ok(2);
  /// expect(x.mapErr(stringify), ok<int, String>(2));
  ///
  /// Result<int, int> y = err(13);
  /// expect(y.mapErr(stringify), err<int, String>('error code: 13'));
  /// ```
  Result<T, F> mapErr<F>(F Function(E) errMap) {
    switch (_type) {
      case _ResultType.err:
        return Result.err(errMap(_err));
      case _ResultType.ok:
        return Result.ok(_ok);
    }
  }
}
