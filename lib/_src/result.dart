import 'package:okay/_src/exceptions.dart';
import 'package:okay/_src/result_type.dart';

part 'result/adapter.dart';
part 'result/extractors.dart';
part 'result/inspect.dart';
part 'result/querying_values.dart';
part 'result/transformers.dart';
part 'result/ok_or_err.dart';

/// `Result` is a type that that represents either success (`ok`) or failure (`err`)
class Result<T, E> {
  /// Success `Result`
  Result.ok(T okValue)
      : _okValue = okValue,
        _type = ResultType.ok;

  /// Failure `Result`
  Result.err(E errValue)
      : _errValue = errValue,
        _type = ResultType.ok;

  T? _okValue;
  E? _errValue;
  late final ResultType _type;

  T get _ok => _okValue!;
  E get _err => _errValue!;
}
