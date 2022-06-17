/// Superclass of all `Result` `Exception`s
abstract class ResultException implements Exception {
  /// Error message
  String get message;
}

/// {@template expect}
/// Exception thrown on calling `expect` on an `err` `Result`
/// {@endtemplate}
class ExpectException extends ResultException {
  /// {@macro expect}
  ExpectException({required String errorMessage, required String errString})
      : message = '$errorMessage: $errString';

  @override
  final String message;
}

/// {@template expect_err}
/// Exception thrown on calling `expectErr` on an `ok` `Result`
/// {@endtemplate}
class ExpectErrException extends ResultException {
  /// {@macro expect_err}
  ExpectErrException({required String errorMessage, required String okString})
      : message = '$errorMessage: $okString';

  @override
  final String message;
}

/// {@template unwrap}
/// Exception thrown on calling `unwrap` on an `err` `Result`
/// {@endtemplate}
class UnwrapException extends ResultException {
  /// {@macro unwrap}
  UnwrapException({required String errString})
      : message = 'called `Result.unwrap()` on an `err` value: $errString';

  @override
  final String message;
}

/// {@template unwrap_err}
/// Exception thrown on calling `unwrapErr` on an `ok` `Result`
/// {@endtemplate}
class UnwrapErrException extends ResultException {
  /// {@macro unwrap_err}
  UnwrapErrException({required String okString})
      : message = 'called `Result.unwrapErr()` on an `ok` value: $okString';

  @override
  final String message;
}
