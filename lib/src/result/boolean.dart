part of '../_result.dart';

/// Boolean operations on the contained values
extension Boolean<T, E> on Result<T, E> {
  /// Return `res` if the result is `ok`,
  /// otherwise returns the `err` value of `this`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// Result<String, String> y = err('late error');
  /// expect(x.and(y), err<String, String>('late error'));
  ///
  /// Result<int, String> x = err('early error');
  /// Result<String, String> y = ok('foo');
  /// expect(x.and(y), err<String, String>('early error'));
  ///
  /// Result<int, String> x = err('not a 2');
  /// Result<String, String> y = err('late error');
  /// expect(x.and(y), err<String, String>('not a too'));
  ///
  /// Result<int, String> x = ok(2);
  /// Result<String, String> y = ok('different result type');
  /// expect(x.and(y), ok<String, String>('different result type'));
  /// ```
  Result<U, E> and<U>(Result<U, E> res) {
    switch (_type) {
      case _ResultType.ok:
        return res;
      case _ResultType.err:
        return Result.err(_err);
    }
  }

  /// Calls `op` if the result is `ok`,
  /// otherwise returns the `err` value of `this`.
  ///
  /// This function can be used for control flow based on `Result` values.
  ///
  /// ## Examples
  ///
  /// Basic usage:
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
  /// Result<String, String> x = ok('4');
  /// Result<int, String> y = x.andThen(parseToInt);
  /// expect(y, ok(4));
  /// ```
  Result<U, E> andThen<U>(Result<U, E> Function(T value) okMap) {
    switch (_type) {
      case _ResultType.ok:
        return okMap(_ok);
      case _ResultType.err:
        return Result.err(_err);
    }
  }

  /// Returns `res` if the result is `err`,
  /// otherwise returns the `ok` (success) value of `this`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// Result<int, String> y = err('late error');
  /// expect(x.or(y), ok<int, String>(2));
  ///
  /// Result<int, String> x = err('early error');
  /// Result<int, String> y = ok(2);
  /// expect(x.or(y), ok<int, String>(2));
  ///
  /// Result<int, String> x = err('not a 2');
  /// Result<int, String> y = err<int, String>('late error');
  /// expect(x.or(y), err<int, String>('late error'));
  ///
  /// Result<int, String> x = ok(2);
  /// Result<int, String> y = ok(100);
  /// expect(x.or(y), ok<int, String>(2));
  /// ```
  Result<T, F> or<F>(Result<T, F> res) {
    switch (_type) {
      case _ResultType.ok:
        return Result.ok(_ok);
      case _ResultType.err:
        return res;
    }
  }

  /// Calls `op` if the result is `err`,
  /// otherwise returns the `ok` value of `this`.
  ///
  /// This function can be used for control flow based on result values.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, int> sq(int x) => ok(x * x);
  /// Result<int, int> error(int x) => err(x);
  ///
  /// expect(ok<int, int>(2).orElse(sq).orElse(sq), ok<int, int>(2));
  ///
  /// expect(ok<int, int>(2).orElse(error).orElse(sq), ok<int, int>(2));
  ///
  /// expect(err<int, int>(3).orElse(sq).orElse(error), ok<int, int>(9));
  ///
  /// expect(err<int, int>(3).orElse(error).orElse(error), err<int, int>(3));
  /// ```
  Result<T, F> orElse<F>(Result<T, F> Function(E error) errMap) {
    switch (_type) {
      case _ResultType.ok:
        return Result.ok(_ok);
      case _ResultType.err:
        return errMap(_err);
    }
  }
}
