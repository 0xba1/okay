// ignore_for_file: lines_longer_than_80_chars

part of '../_result.dart';

/// Querying the contained values
extension QueryingValues<T, E> on Result<T, E> {
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
  bool isOkAnd(bool Function(T) f) {
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
  bool isErrAnd(bool Function(E) f) {
    if (_type == _ResultType.err) {
      return f(_err);
    }

    return false;
  }
}
