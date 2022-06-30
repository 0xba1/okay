// ignore_for_file: lines_longer_than_80_chars

import 'package:meta/meta.dart';
import 'package:okay/src/_exceptions.dart';

part 'result/adapter.dart';
part 'result/boolean.dart';
part 'result/contains.dart';
part 'result/extractors.dart';
part 'result/inspect.dart';
part 'result/ok_or_err.dart';
part 'result/querying_values.dart';
part 'result/transformers.dart';

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

  @override
  bool operator ==(Object? other) =>
      other is Result &&
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
