part of '../result.dart';

/// Transforming contained values
extension Transformers<T, E> on Result<T, E> {
  /// Maps a `Result<T, E>` to `Result<U, E>` by applying a function to a
  /// contained `ok` (success) value, and leaving an `err` (failure) value
  /// untouched.
  ///
  /// This function can be used to compose the results of two functions.
  ///
  /// # Examples
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
  Result<U, E> map<U>(U Function(T) op) {
    switch (_type) {
      case ResultType.ok:
        return Result.ok(op(_ok));
      case ResultType.err:
        return Result.err(_err);
    }
  }

  /// Returns the provided fallback (if `err` (failure)), or
  /// applies a function to the contained value (if `ok` (success)).
  ///
  /// # Examples
  ///
  /// ```dart
  /// Result<String, String> x = ok("foo");
  /// expect(x.map_or(42, (val) => val.length), 3);
  ///
  /// Result<String, String> y = err("foo");
  /// expect(y.map_or(42, (val) => val.length), 42);
  /// ```
  U mapOr<U>(U fallback, U Function(T) op) {
    switch (_type) {
      case ResultType.ok:
        return op(_ok);
      case ResultType.err:
        return fallback;
    }
  }
}
