import 'package:meta/meta.dart';
import 'package:okay/src/_exceptions.dart';
import 'package:okay/src/_result_type.dart';

part 'result/adapter.dart';
part 'result/boolean.dart';
part 'result/contains.dart';
part 'result/extractors.dart';
part 'result/inspect.dart';
part 'result/ok_or_err.dart';
part 'result/querying_values.dart';
part 'result/transformers.dart';

/// `Result` is a type that that represents either success (`ok`) or failure (`err`)
@immutable
class Result<T, E> {
  /// Success `Result`
  const Result.ok(T okValue)
      : _okValue = okValue,
        _errValue = null,
        _type = ResultType.ok;

  /// Failure `Result`
  const Result.err(E errValue)
      : _okValue = null,
        _errValue = errValue,
        _type = ResultType.err;

  final T? _okValue;
  final E? _errValue;
  final ResultType _type;

  T get _ok => _okValue as T;
  E get _err => _errValue as E;

  /// Type of result; `ok` (success) or `err` (failure)
  ///
  /// ## Examples
  ///
  /// Basic usage:
  ///
  /// ```dart
  /// switch (_type) {
  ///   case ResultType.ok:
  ///     print('Success');
  ///     break;
  ///   case ResultType.err:
  ///     print('Failure');
  ///     break;
  /// }
  /// ```
  ResultType get type => _type;

  @override
  bool operator ==(Object? other) =>
      other is Result &&
      other.type == _type &&
      other._okValue == _okValue &&
      other._errValue == _errValue;

  @override
  int get hashCode {
    switch (_type) {
      case ResultType.ok:
        return Object.hash(_type, _okValue);
      case ResultType.err:
        return Object.hash(_type, _errValue);
    }
  }

  @override
  String toString() {
    switch (_type) {
      case ResultType.ok:
        return 'ok( $_okValue )';
      case ResultType.err:
        return 'err( $_errValue )';
    }
  }
}
