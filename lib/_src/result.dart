import 'package:okay/_src/exceptions.dart';
import 'package:okay/_src/result_type.dart';

part 'result/adapter.dart';
part 'result/boolean.dart';
part 'result/contains.dart';
part 'result/extractors.dart';
part 'result/inspect.dart';
part 'result/ok_or_err.dart';
part 'result/querying_values.dart';
part 'result/transformers.dart';

/// `Result` is a type that that represents either success (`ok`) or failure (`err`)
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
        _type = ResultType.ok;

  final T? _okValue;
  final E? _errValue;
  final ResultType _type;

  T get _ok => _okValue!;
  E get _err => _errValue!;

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
}
