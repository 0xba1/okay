part of '../result.dart';

/// Run closures on contained value or error
extension Inspect<T, E> on Result<T, E> {
  /// Calls the provided closure with the contained value (if `ok`)
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
  /// Result<int, String> x = parseToInt('4')
  ///   .inspect((val) => print('original: $val')) // prints 'original: 4'
  ///   .map((val) => val * val);
  /// ```
  Result<T, E> inspect(void Function(T) f) {
    if (_type == ResultType.ok) {
      f(_ok);
    }
    return this;
  }

  /// Calls the provided closure with the contained error (if `err`).
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
  /// Result<int, String> x = parseToInt('four')
  ///   .inspect((val) => print("'$val' could not be parsed into an integer")) // prints "'$four' could not be parsed into an integer"
  /// ```
  Result<T, E> inspectErr(void Function(E) f) {
    if (_type == ResultType.err) {
      f(_err);
    }
    return this;
  }
}
