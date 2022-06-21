part of '../_result.dart';

/// Adapter for each variant
extension Adapter<T, E> on Result<T, E> {
  /// Converts from `Result<T, E>` to `T?`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.ok(), 2);
  ///
  /// Result<int, String> x = err('An error occured');
  /// expect(x.ok(), null);
  /// ```
  T? ok() {
    return _okValue;
  }

  /// Converts from `Result<T, E>` to `E?`.
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// Result<int, String> x = ok(2);
  /// expect(x.err(), null);
  ///
  /// Result<int, String> x = err('An error occured');
  /// expect(x.err(), 'An error occured');
  /// ```
  E? err() {
    return _errValue;
  }
}
