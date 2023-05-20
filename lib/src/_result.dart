// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';
import 'package:okay/src/_exceptions.dart';

/// {@template result}
/// `Result` is a type that that represents either success (`Ok`) or failure (`Err`)
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
///     return Ok(FallibleOpSuccess());
///   } else {
///     return Err(FallibleOpFailure());
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
/// {@endtemplate}
@immutable
sealed class Result<T, E> {
  // ignore: public_member_api_docs
  const Result();

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
  /// Result<int, String> x = Ok(2);
  /// expect(x.ok(), 2);
  ///
  /// Result<int, String> x = Err('An error occured');
  /// expect(x.ok(), null);
  /// ```
  T? ok();

  /// Converts from `Result<T, E>` to `E?`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = Ok(2);
  /// expect(x.err(), null);
  ///
  /// Result<int, String> x = Err('An error occured');
  /// expect(x.err(), 'An error occured');
  /// ```
  E? err();
  //-----------------------------------

  //-----------------------------------
  // Boolean
  // Boolean operations on the contained values

  /// Return `res` if the result is `Ok`,
  /// otherwise returns the `Err` value of `this`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = Ok(2);
  /// Result<String, String> y = Err('late error');
  /// expect(x.and(y), ErrString, String>('late error'));
  ///
  /// Result<int, String> x = Err('early error');
  /// Result<String, String> y = Ok('foo');
  /// expect(x.and(y), ErrString, String>('early error'));
  ///
  /// Result<int, String> x = Err('not a 2');
  /// Result<String, String> y = Err('late error');
  /// expect(x.and(y), ErrString, String>('not a too'));
  ///
  /// Result<int, String> x = Ok(2);
  /// Result<String, String> y = Ok('different result type');
  /// expect(x.and(y), Ok<String, String>('different result type'));
  /// ```
  Result<U, E> and<U>(Result<U, E> res);

  /// Calls `op` if the result is `Ok`,
  /// otherwise returns the `Err` value of `this`.
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
  ///     return Ok(int.parse(value));
  ///   } catch (_) {
  ///     return Err(value);
  ///   }
  /// }
  ///
  /// Result<String, String> x = Ok('4');
  /// Result<int, String> y = x.andThen(parseToInt);
  /// expect(y, Ok(4));
  /// ```
  Result<U, E> andThen<U>(Result<U, E> Function(T value) okMap);

  /// Returns `res` if the result is `Err`,
  /// otherwise returns the `Ok` (success) value of `this`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = Ok(2);
  /// Result<int, String> y = Err('late error');
  /// expect(x.or(y), Ok<int, String>(2));
  ///
  /// Result<int, String> x = Err('early error');
  /// Result<int, String> y = Ok(2);
  /// expect(x.or(y), Ok<int, String>(2));
  ///
  /// Result<int, String> x = Err('not a 2');
  /// Result<int, String> y = Errint, String>('late error');
  /// expect(x.or(y), Errint, String>('late error'));
  ///
  /// Result<int, String> x = Ok(2);
  /// Result<int, String> y = Ok(100);
  /// expect(x.or(y), Ok<int, String>(2));
  /// ```
  Result<T, F> or<F>(Result<T, F> res);

  /// Calls `op` if the result is `Err`,
  /// otherwise returns the `Ok` value of `this`.
  ///
  /// This function can be used for control flow based on result values.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, int> sq(int x) => Ok(x * x);
  /// Result<int, int> error(int x) => Err(x);
  ///
  /// expect(Ok<int, int>(2).orElse(sq).orElse(sq), Ok<int, int>(2));
  ///
  /// expect(Ok<int, int>(2).orElse(error).orElse(sq), Ok<int, int>(2));
  ///
  /// expect(Errint, int>(3).orElse(sq).orElse(error), Ok<int, int>(9));
  ///
  /// expect(Errint, int>(3).orElse(error).orElse(error), Errint, int>(3));
  /// ```
  Result<T, F> orElse<F>(Result<T, F> Function(E error) errMap);

  // -------------------------------

  // -------------------------------
  // Contains
  // Compares contained `Ok` or `Err` value

  /// Returns `true` if the result is an `Ok` (success) value
  /// containing the given value.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = Ok(2);
  /// expect(x.contains(2), true);
  ///
  /// Result<int, String> x = Ok(3);
  /// expect(x.contains(2), false);
  ///
  /// Result<int, String> x = Err('Some error message');
  /// expect(x.contains(2), false);
  /// ```
  bool contains(Object? x);

  /// Returns `true` if the result is an `Err` (failure) value
  /// containing the given value.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = Ok(2);
  /// expect(x.containsErr('Some error message'), false);
  ///
  /// Result<int, String> x = Err('Some error message');
  /// expect(x.contains('Some error message'), true);
  ///
  /// Result<int, String> x = Err('Some other error message');
  /// expect(x.contains('Some error message'), false);
  /// ```
  bool containsErr(Object? x);

  // --------------------------------

  // --------------------------------
  // Extractors
  // Extract value or error

  /// Returns the contained `Ok` (success) value.
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `Err` (failure),
  /// with an exception message including the passed message,
  /// and the content of the `Err`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  /// ```dart
  /// Result<int, String> x = Err("emergency failure");
  /// x.expect("Testing expect"); // Throws an exception with message `Testing expect: emergency failure`
  ///
  /// Result<int, String> y = Ok(5);
  /// print(y.expect("Should print `5`")); // 5
  /// ```
  T expect(String message);

  /// Returns the contained `Ok` (success) value.
  /// Because this function may throw an exception, its use is generally discouraged.
  /// Instead, prefer to use `switch` statements with the `Result.type`
  /// and handle the `Err` (failure) case explicitly, or call [`unwrapOr`],
  /// [`unwrapOrElse`].
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `Err`, with exception message
  /// provided by the `Err`'s value.
  ///
  /// ## Examples
  ///
  /// Basic Usage:
  ///
  /// ```dart
  /// Result<int, String> x = Ok(69);
  /// expect(x.unwrap(), 69);
  ///
  /// Result<int, String> y = Err('emergency failure');
  /// expect(y.unwrap(), "emergency failure"); // Throws an exception with message `called `Result.unwrapErr()` on an `Err` value: 'emergency failure'`
  /// ```
  T unwrap();

  /// Returns the contained `Err` (failure) value.
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `Ok` (success),
  /// with the exception message including the passed message,
  /// and the content of the `Ok` value.
  ///
  /// ## Examples
  ///
  /// ```dart
  ///Result<int, String> x = Ok(9);
  ///x.expectErr("Testing expectErr"); // throws an exception with `Testing expectErr: 9`
  /// ```
  E expectErr(String message);

  /// Returns the contained `Err` (failure) value.
  ///
  /// ## Throws an exception
  ///
  /// Throws an exception if the value is an `Ok`, with an exception message
  /// provided by the `Ok`'s value.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> x = Ok(2);
  /// x.unwrapErr(); // Throws an exception with message `called `Result.unwrapErr()` on an `Ok` value: 2`
  ///
  /// Result<int, String> y = Err('emergency failure');
  /// expect(y.unwrapErr(), "emergency failure");
  /// ```
  E unwrapErr();

  /// Returns the contained `Ok` (success) value or a provided fallback.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// final fallback = 23;
  ///
  /// Result<int, String> x = Ok(9);
  /// expect(x.unwrapOr(fallback), 9);
  ///
  /// Result<int, String> y = Err('Error!');
  /// expect(y.unwrapOr(fallback), fallback);
  /// ```
  T unwrapOr(T fallback);

  /// Returns the contained `Ok` (success) value
  /// or computes it from the closure.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// int count(String x) => x.length;
  ///
  /// expect(Ok<int, String>(2).unwrapOrElse(count), 2);
  /// expect(Errint, String>('foo').unwrapOrElse(count), 3);
  /// ```
  T unwrapOrElse(T Function(E error) fallback);

  // --------------------------------

  // --------------------------------
  // Inspect
  // Run closures on contained value or error

  /// Calls the provided closure with the contained value (if `Ok`)
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> parseToInt(String value) {
  ///   try {
  ///     return Ok(int.parse(value));
  ///   } catch (_) {
  ///     return Err(value);
  ///   }
  /// }
  ///
  /// Result<int, String> x = parseToInt('4')
  ///   .inspect((val) => print('original: $val')) // prints 'original: 4'
  ///   .map((val) => val * val);
  /// ```
  Result<T, E> inspect(void Function(T value) f);

  /// Calls the provided closure with the contained error (if `Err`).
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> parseToInt(String value) {
  ///   try {
  ///     return Ok(int.parse(value));
  ///   } catch (_) {
  ///     return Err(value);
  ///   }
  /// }
  /// Result<int, String> x = parseToInt('four')
  ///   .inspectErr((val) => print("'$val' could not be parsed into an integer")) // prints "'$four' could not be parsed into an integer"
  /// ```
  Result<T, E> inspectErr(void Function(E error) f);

  // --------------------------------

  // --------------------------------
  // QueryingValues
  // Querying the contained values

  /// Resturns `true` if the result is `Ok` (success)
  ///
  /// ## Expamples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = Ok(9);
  /// expect(x.isOk, true);
  ///
  /// Result<int, String> y = Err('An unexpected error occured');
  /// expect(x.isOk, false);
  /// ```
  bool get isOk;

  /// Returns `true` if the result is `Ok` and the value matches the predicate `f`
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> x = Ok(9);
  /// expect(x.isOkAnd((int val) => val > 5), true);
  ///
  /// expect(x.isOkAnd((int val) => val < 5), false);
  ///
  /// Result<int, String> y = Err('An unexpected error occured');
  /// expect(x.isOkAnd((_) => true), false);
  /// ```
  bool isOkAnd(bool Function(T value) f);

  /// Resturns `true` if the result is `Err` (failure)
  ///
  /// ## Expamples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> y = Err('An unexpected error occured');
  /// expect(x.isErr, true);
  ///
  /// Result<int, String> x = Ok(0);
  /// expect(x.isErr, false);
  /// ```
  bool get isErr;

  /// Returns `true` if the result is `Err` and the value matches the predicate `f`
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> y = Err('An unexpected error occured');
  /// expect(x.isErrAnd((String value) => value.isNotEmpty), true);
  /// expect(x.isErrAnd((String value) => value.isEmpty), false);
  ///
  /// Result<int, String> x = Ok(0);
  /// expect(x.isErrAnd((_) => true), false);
  /// ```
  bool isErrAnd(bool Function(E error) f);

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
  /// Result<int, int> x = Ok(9);
  /// expect(
  ///   x.when(
  ///     err: (error) => 'Failure: $error',
  ///     ok: (value) => 'Success: $value',
  ///   ),
  ///   'Success: 9',
  /// );
  ///
  /// Result<int, int> x = Err(81);
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
  });

  /// Maps a `Result<T, E>` to `Result<U, E>` by applying a function to a
  /// contained `Ok` (success) value, and leaving an `Err` (failure) value
  /// untouched.
  ///
  /// This function can be used to compose the results of two functions.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<int, String> parseToInt(String value) {
  ///   try {
  ///     return Ok(int.parse(value));
  ///   } catch (_) {
  ///     return Err(value);
  ///   }
  /// }
  ///
  /// Result<bool, String> isStringGreaterThanFive(String value) {
  ///   return parseToInt(value).map((int val) => val > 5);
  /// }
  ///
  /// expect(isStringGreaterThanFive("7"), Ok<bool, String>(true));
  /// expect(isStringGreaterThanFive("4"), Ok<bool, String>(false));
  /// expect(isStringGreaterThanFive("five"), Errbool, String>("five"));
  /// ```
  Result<U, E> map<U>(U Function(T value) okMap);

  /// Returns the provided fallback (if `Err` (failure)), or
  /// applies a function to the contained value (if `Ok` (success)).
  ///
  /// ## Examples
  ///
  /// ```dart
  /// Result<String, String> x = Ok("foo");
  /// expect(x.mapOr(fallback: 42, okMap: (val) => val.length)), 3);
  ///
  /// Result<String, String> x = Err("foo");
  /// expect(x.mapOr(fallback: 42, okMap: (val) => val.length), 42);
  /// ```
  U mapOr<U>({required U fallback, required U Function(T value) okMap});

  /// Maps a `Result<T, E>` to `U` by applying fallback function `fallback` to
  /// a contained `Err` (failure) value, or function `op` to a
  /// contained `Ok` (success) value.
  ///
  /// This function can be used to unpack a successful result
  /// while handliing an error.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, int> x = Ok(9);
  /// expect(
  ///   x.mapOrElse(
  ///     errMap: (error) => 'Failure: $error',
  ///     okMap: (value) => 'Success: $value',
  ///   ),
  ///   'Success: 9',
  /// );
  ///
  /// Result<int, int> x = Err(81);
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
  });

  /// Maps a `Result<T, E>` to `Result<T, F>` by applying a function to a
  /// contained `Err` (failure) value,
  /// leaving an `Ok` (success) value untouched.
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
  /// Result<int, int> x = Ok(2);
  /// expect(x.mapErr(stringify), Ok<int, String>(2));
  ///
  /// Result<int, int> y = Err(13);
  /// expect(y.mapErr(stringify), Errint, String>('error code: 13'));
  /// ```
  Result<T, F> mapErr<F>(F Function(E error) errMap);
}

/// {@macro result}
class Ok<T, E> extends Result<T, E> {
  /// {@macro result}
  const Ok(this.v);

  /// Ok wrapped value
  final T v;

  //------------------------------------------------------------------------
  // Methods

  //---------------------------------------
  // Adapters
  // Adapter for each variant

  @override
  T? ok() => v;

  @override
  E? err() => null;
  //-----------------------------------

  //-----------------------------------
  // Boolean
  // Boolean operations on the contained values
  @override
  Result<U, E> and<U>(Result<U, E> res) {
    return res;
  }

  @override
  Result<U, E> andThen<U>(Result<U, E> Function(T value) okMap) {
    return okMap(v);
  }

  @override
  Result<T, F> or<F>(Result<T, F> res) {
    return Ok(v);
  }

  @override
  Result<T, F> orElse<F>(Result<T, F> Function(E error) errMap) {
    return Ok(v);
  }

  // -------------------------------

  // -------------------------------
  // Contains
  // Compares contained `Ok` or `Err` value

  @override
  bool contains(Object? x) {
    return v == x;
  }

  @override
  bool containsErr(Object? x) {
    return false;
  }

  // --------------------------------

  // --------------------------------
  // Extractors
  // Extract value or error

  @override
  T expect(String message) {
    return v;
  }

  @override
  T unwrap() {
    return v;
  }

  @override
  E expectErr(String message) {
    throw ExpectErrException(
      errorMessage: message,
      okString: v.toString(),
    );
  }

  @override
  E unwrapErr() {
    throw UnwrapErrException(
      okString: v.toString(),
    );
  }

  @override
  T unwrapOr(T fallback) {
    return v;
  }

  @override
  T unwrapOrElse(T Function(E error) fallback) {
    return v;
  }

  // --------------------------------

  // --------------------------------
  // Inspect
  // Run closures on contained value or error

  @override
  Result<T, E> inspect(void Function(T value) f) {
    f(v);

    return this;
  }

  @override
  Result<T, E> inspectErr(void Function(E error) f) {
    return this;
  }

  // --------------------------------

  // --------------------------------
  // QueryingValues
  // Querying the contained values

  @override
  bool get isOk => true;

  @override
  bool isOkAnd(bool Function(T value) f) {
    return f(v);
  }

  @override
  bool get isErr => false;

  @override
  bool isErrAnd(bool Function(E error) f) {
    return false;
  }

  // --------------------------------

  // --------------------------------
  // Transformers
  // Transforming contained values

  @override
  U when<U>({
    required U Function(T value) ok,
    required U Function(E error) err,
  }) {
    return mapOrElse(errMap: err, okMap: ok);
  }

  @override
  Result<U, E> map<U>(U Function(T value) okMap) {
    return Ok(okMap(v));
  }

  @override
  U mapOr<U>({required U fallback, required U Function(T value) okMap}) {
    return okMap(v);
  }

  @override
  U mapOrElse<U>({
    required U Function(E error) errMap,
    required U Function(T value) okMap,
  }) {
    return okMap(v);
  }

  @override
  Result<T, F> mapErr<F>(F Function(E error) errMap) {
    return Ok(v);
  }

  // --------------------------------

  @override
  bool operator ==(Object? other) => other is Ok<T, E> && other.v == v;

  @override
  int get hashCode {
    return Object.hash('Ok', v);
  }

  @override
  String toString() {
    return 'Ok( $v )';
  }
}

/// {@macro result}
class Err<T, E> extends Result<T, E> {
  /// {@macro result}
  const Err(this.e);

  /// Err wrapped error
  final E e;

  //------------------------------------------------------------------------
  // Methods

  //---------------------------------------
  // Adapters
  // Adapter for each variant

  @override
  T? ok() => null;

  @override
  E? err() => e;
  //-----------------------------------

  //-----------------------------------
  // Boolean
  // Boolean operations on the contained values
  @override
  Result<U, E> and<U>(Result<U, E> res) {
    return Err(e);
  }

  @override
  Result<U, E> andThen<U>(Result<U, E> Function(T value) okMap) {
    return Err(e);
  }

  @override
  Result<T, F> or<F>(Result<T, F> res) {
    return res;
  }

  @override
  Result<T, F> orElse<F>(Result<T, F> Function(E error) errMap) {
    return errMap(e);
  }

  // -------------------------------

  // -------------------------------
  // Contains
  // Compares contained `Ok` or `Err` value

  @override
  bool contains(Object? x) => false;

  @override
  bool containsErr(Object? x) => x == e;

  // --------------------------------

  // --------------------------------
  // Extractors
  // Extract value or error

  @override
  T expect(String message) {
    throw ExpectException(
      errorMessage: message,
      errString: e.toString(),
    );
  }

  @override
  T unwrap() {
    throw UnwrapException(
      errString: e.toString(),
    );
  }

  @override
  E expectErr(String message) {
    return e;
  }

  @override
  E unwrapErr() {
    return e;
  }

  @override
  T unwrapOr(T fallback) {
    return fallback;
  }

  @override
  T unwrapOrElse(T Function(E error) fallback) {
    return fallback(e);
  }

  // --------------------------------

  // --------------------------------
  // Inspect
  // Run closures on contained value or error

  @override
  Result<T, E> inspect(void Function(T value) f) {
    return this;
  }

  @override
  Result<T, E> inspectErr(void Function(E error) f) {
    f(e);

    return this;
  }

  // --------------------------------

  // --------------------------------
  // QueryingValues
  // Querying the contained values

  @override
  bool get isOk => false;

  @override
  bool isOkAnd(bool Function(T value) f) {
    return false;
  }

  @override
  bool get isErr => true;

  @override
  bool isErrAnd(bool Function(E error) f) {
    return f(e);
  }

  // --------------------------------

  // --------------------------------
  // Transformers
  // Transforming contained values

  @override
  U when<U>({
    required U Function(T value) ok,
    required U Function(E error) err,
  }) {
    return mapOrElse(errMap: err, okMap: ok);
  }

  @override
  Result<U, E> map<U>(U Function(T value) okMap) {
    return Err(e);
  }

  @override
  U mapOr<U>({required U fallback, required U Function(T value) okMap}) {
    return fallback;
  }

  @override
  U mapOrElse<U>({
    required U Function(E error) errMap,
    required U Function(T value) okMap,
  }) {
    return errMap(e);
  }

  @override
  Result<T, F> mapErr<F>(F Function(E error) errMap) {
    return Err(errMap(e));
  }

  // --------------------------------

  @override
  bool operator ==(Object? other) => other is Err<T, E> && other.e == e;

  @override
  int get hashCode {
    return Object.hash('Err', e);
  }

  @override
  String toString() {
    return 'Err( $e )';
  }
}
