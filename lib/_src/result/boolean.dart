part of '../result.dart';

/// Boolean operations on the values
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
  /// expect(x.and(y), err('late error'));
  ///
  /// Result<int, String> x = err('early error');
  /// Result<String, String> y = ok('foo');
  /// expect(x.and(y), err('early error'));
  ///
  /// Result<int, String> x = err('not a 2');
  /// Result<String, String> y = err('late error');
  /// expect(x.and(y), err('not a too'));
  ///
  /// Result<int, String> x = ok(2);
  /// Result<String, String> y = ok('different result type');
  /// expect(x.and(y), err('different result type'));
  /// ```
  Result<U, E> and<U>(Result<U, E> res) {
    switch (_type) {
      case ResultType.ok:
        return res;
      case ResultType.err:
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
  /// Result<int, String> y = x.andThen((val) => parseToInt(val));
  /// expect(y, ok(4));
  /// ```
  Result<U, E> andThen<U>(Result<U, E> Function(T) op) {
    switch (_type) {
      case ResultType.ok:
        return op(_ok);
      case ResultType.err:
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
  /// expect(x.or(y), ok(2));
  ///
  /// Result<int, String> x = err('early error');
  /// Result<int, String> y = ok(2);
  /// expect(x.or(y), ok(2));
  ///
  /// Result<int, String> x = err('not a 2');
  /// Result<int, String> y = err('late error');
  /// expect(x.or(y), err('late error'));
  ///
  /// Result<int, String> x = ok(2);
  /// Result<int, String> y = ok(100);
  /// expect(x.or(y), ok(2));
  /// ```
  Result<T, F> or<F>(Result<T, F> res) {
    switch (_type) {
      case ResultType.ok:
        return Result.ok(_ok);
      case ResultType.err:
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
  /// expect(ok(2).orElse(sq).orElse(sq), ok(2));
  /// expect(ok(2).orElse(error).orElse(sq), ok(2));
  /// expect(err(3).orElse(sq).orElse(error), ok(9));
  /// expect(err(3).orElse(sq).orElse(error), err(3));
  /// ```
  Result<T, F> orElse<F>(Result<T, F> Function(E) op) {
    switch (_type) {
      case ResultType.ok:
        return Result.ok(_ok);
      case ResultType.err:
        return op(_err);
    }
  }
}
