import 'package:okay/src/_result.dart';

/// Success `Result`
Result<T, E> ok<T, E>(T okValue) => Result.ok(okValue);

/// Failure `Result`
Result<T, E> err<T, E>(E errValue) => Result.err(errValue);
