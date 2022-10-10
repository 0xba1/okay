// ignore_for_file: lines_longer_than_80_chars, avoid_returning_this

import 'package:meta/meta.dart';
import 'package:okay/src/_exceptions.dart';

part 'result/ok_or_err.dart';

/// `Result` is a type that that represents either success (`ok`) or failure (`err`)
/// ## Examples
///
/// Basic usage:
///
/// ```dart
/// class FallibleOpSuccess {}
/// class FallibleOpFailure {}
///
/// Result<FallibleOpSuccess, FallibleOpFailure> fallibleOp() {
///   if (true) {
///     return ok(FallibleOpSuccess());
///   } else {
///     return err(FallibleOpFailure());
///   }
/// }
///
/// final result = fallibleOp();
///
/// result.inspect((value) {
///     print('Success with value: $value');
///   }).inspectErr((error) {
///     print('Failure with error: $error');
///   });
/// }
/// ```
@immutable
class Result<T, E> {
  /// Success `Result`
  const Result.ok(T okValue)
      : _okValue = okValue,
        _errValue = null,
        _type = _ResultType.ok;

  /// Failure `Result`
  const Result.err(E errValue)
      : _okValue = null,
        _errValue = errValue,
        _type = _ResultType.err;

  final T? _okValue;
  final E? _errValue;
  final _ResultType _type;

  T get _ok => _okValue as T;
  E get _err => _errValue as E;

  //------------------------------------------------------------------------
  // Methods

  //---------------------------------------
  // Adapters
  // Adapter for each variant

  /// Converts from `Result<T, E>` to `T?`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.ok, 2);
  ///
  /// Result<int, String> x = err('An error occured');
  /// expect(x.ok, null);
  /// ```
  T? get ok => _okValue;

  /// Converts from `Result<T, E>` to `E?`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.err, null);
  ///
  /// Result<int, String> x = err('An error occured');
  /// expect(x.err, 'An error occured');
  /// ```
  E? get err => _errValue;
  //-----------------------------------

  //-----------------------------------
  // Boolean
  // Boolean operations on the contained values

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

  // -------------------------------

  // -------------------------------
  // Contains
  // Compares contained `ok` or `err` value

  /// Returns `true` if the result is an `ok` (success) value
  /// containing the given value.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.contains(2), true);
  ///
  /// Result<int, String> x = ok(3);
  /// expect(x.contains(2), false);
  ///
  /// Result<int, String> x = err('Some error message');
  /// expect(x.contains(2), false);
  /// ```
  bool contains(Object? x) {
    switch (_type) {
      case _ResultType.ok:
        return _ok == x;
      case _ResultType.err:
        return false;
    }
  }

  /// Returns `true` if the result is an `err` (failure) value
  /// containing the given value.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.containsErr('Some error message'), false);
  ///
  /// Result<int, String> x = err('Some error message');
  /// expect(x.contains('Some error message'), true);
  ///
  /// Result<int, String> x = err('Some other error message');
  /// expect(x.contains('Some error message'), false);
  /// ```
  bool containsErr(Object? x) {
    switch (_type) {
      case _ResultType.err:
        return _err == x;
      case _ResultType.ok:
        return false;
    }
  }

  // --------------------------------

  // --------------------------------
  // Extractors
  // Extract value or error

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
      case _ResultType.ok:
        return _ok;
      case _ResultType.err:
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
  ///
  /// Result<int, String> y = err('emergency failure');
  /// expect(y.unwrap(), "emergency failure"); // Throws an exception with message `called `Result.unwrapErr()` on an `err` value: 'emergency failure'`
  /// ```
  T unwrap() {
    switch (_type) {
      case _ResultType.ok:
        return _ok;
      case _ResultType.err:
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
      case _ResultType.err:
        return _err;
      case _ResultType.ok:
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
      case _ResultType.err:
        return _err;
      case _ResultType.ok:
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
      case _ResultType.ok:
        return _ok;
      case _ResultType.err:
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
  T unwrapOrElse(T Function(E error) fallback) {
    switch (_type) {
      case _ResultType.ok:
        return _ok;
      case _ResultType.err:
        return fallback(_err);
    }
  }

  // --------------------------------

  // --------------------------------
  // Inspect
  // Run closures on contained value or error

  /// Calls the provided closure with the contained value (if `ok`)
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
  /// Result<int, String> x = parseToInt('4')
  ///   .inspect((val) => print('original: $val')) // prints 'original: 4'
  ///   .map((val) => val * val);
  /// ```
  Result<T, E> inspect(void Function(T value) f) {
    if (_type == _ResultType.ok) {
      f(_ok);
    }
    return this;
  }

  /// Calls the provided closure with the contained error (if `err`).
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
  /// Result<int, String> x = parseToInt('four')
  ///   .inspectErr((val) => print("'$val' could not be parsed into an integer")) // prints "'$four' could not be parsed into an integer"
  /// ```
  Result<T, E> inspectErr(void Function(E error) f) {
    if (_type == _ResultType.err) {
      f(_err);
    }
    return this;
  }

  // --------------------------------

  // --------------------------------
  // QueryingValues
  // Querying the contained values

  /// Resturns `true` if the result is `ok` (success)
  ///
  /// ## Expamples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(9);
  /// expect(x.isOk, true);
  ///
  /// Result<int, String> y = err('An unexpected error occured');
  /// expect(x.isOk, false);
  /// ```
  bool get isOk => _type == _ResultType.ok;

  /// Returns `true` if the result is `ok` and the value matches the predicate `f`
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> x = ok(9);
  /// expect(x.isOkAnd((int val) => val > 5), true);
  ///
  /// expect(x.isOkAnd((int val) => val < 5), false);
  ///
  /// Result<int, String> y = err('An unexpected error occured');
  /// expect(x.isOkAnd((_) => true), false);
  /// ```
  bool isOkAnd(bool Function(T value) f) {
    if (_type == _ResultType.ok) {
      return f(_ok);
    }

    return false;
  }

  /// Resturns `true` if the result is `err` (failure)
  ///
  /// ## Expamples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> y = err('An unexpected error occured');
  /// expect(x.isErr, true);
  ///
  /// Result<int, String> x = ok(0);
  /// expect(x.isErr, false);
  /// ```
  bool get isErr => _type == _ResultType.err;

  /// Returns `true` if the result is `err` and the value matches the predicate `f`
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> y = err('An unexpected error occured');
  /// expect(x.isErrAnd((String value) => value.isNotEmpty), true);
  /// expect(x.isErrAnd((String value) => value.isEmpty), false);
  ///
  /// Result<int, String> x = ok(0);
  /// expect(x.isErrAnd((_) => true), false);
  /// ```
  bool isErrAnd(bool Function(E error) f) {
    if (_type == _ResultType.err) {
      return f(_err);
    }

    return false;
  }

  // --------------------------------

  // --------------------------------
  // Transformers
  // Transforming contained values

  /// Maps a `Result<T, E>` to `U`
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
  ///   x.when(
  ///     err: (error) => 'Failure: $error',
  ///     ok: (value) => 'Success: $value',
  ///   ),
  ///   'Success: 9',
  /// );
  ///
  /// Result<int, int> x = err(81);
  /// expect(
  ///   x.when(
  ///     err: (error) => 'Failure: $error',
  ///     ok: (value) => 'Success: $value',
  ///   ),
  ///   'Failed: 81',
  /// );
  /// ```
  U when<U>({
    required U Function(T value) ok,
    required U Function(E error) err,
  }) {
    return mapOrElse(errMap: err, okMap: ok);
  }

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
  Result<U, E> map<U>(U Function(T value) okMap) {
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
  U mapOr<U>({required U fallback, required U Function(T value) okMap}) {
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
    required U Function(E error) errMap,
    required U Function(T value) okMap,
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
  Result<T, F> mapErr<F>(F Function(E error) errMap) {
    switch (_type) {
      case _ResultType.err:
        return Result.err(errMap(_err));
      case _ResultType.ok:
        return Result.ok(_ok);
    }
  }

  // --------------------------------

  @override
  bool operator ==(Object? other) =>
      other is Result<T, E> &&
      other._type == _type &&
      other._okValue == _okValue &&
      other._errValue == _errValue;

  @override
  int get hashCode {
    switch (_type) {
      case _ResultType.ok:
        return Object.hash(_type, _okValue);
      case _ResultType.err:
        return Object.hash(_type, _errValue);
    }
  }

  @override
  String toString() {
    switch (_type) {
      case _ResultType.ok:
        return 'ok( $_okValue )';
      case _ResultType.err:
        return 'err( $_errValue )';
    }
  }
}

/// Indicating `Result` of type `ok` or `err`
enum _ResultType {
  /// Success `Result`
  ok,

  /// Failure `Result`
  err,
}
