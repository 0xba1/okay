import 'package:okay/_src/result.dart';

/// Success `Result`
Result<T, E> ok<T, E>(T okValue) {
  return Result.ok(okValue);
}

/// Failure `Result`
Result<T, E> err<T, E>(E errValue) {
  return Result.err(errValue);
}
