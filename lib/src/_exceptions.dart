/// Abstract superclass of all `Result` `Exception`s
sealed class ResultException implements Exception {
  /// Abstract superclass of all `Result` `Exception`s
  const ResultException();

  /// Error message
  String get message;
}

/// {@template expect}
/// Exception thrown on calling `expect` on an `Err` `Result`
/// {@endtemplate}
class ExpectException extends ResultException {
  /// {@macro expect}
  const ExpectException({
    required String errorMessage,
    required String errString,
  }) : message = '$errorMessage: $errString';

  @override
  final String message;
}

/// {@template expect_err}
/// Exception thrown on calling `expectErr` on an `Ok` `Result`
/// {@endtemplate}
class ExpectErrException extends ResultException {
  /// {@macro expect_err}
  const ExpectErrException({
    required String errorMessage,
    required String okString,
  }) : message = '$errorMessage: $okString';

  @override
  final String message;
}

/// {@template unwrap}
/// Exception thrown on calling `unwrap` on an `Err` `Result`
/// {@endtemplate}
class UnwrapException extends ResultException {
  /// {@macro unwrap}
  const UnwrapException({required String errString})
      : message = 'called `Result.unwrap()` on an `Err` value: $errString';

  @override
  final String message;
}

/// {@template unwrap_err}
/// Exception thrown on calling `unwrapErr` on an `Ok` `Result`
/// {@endtemplate}
class UnwrapErrException extends ResultException {
  /// {@macro unwrap_err}
  const UnwrapErrException({required String okString})
      : message = 'called `Result.unwrapErr()` on an `Ok` value: $okString';

  @override
  final String message;
}
