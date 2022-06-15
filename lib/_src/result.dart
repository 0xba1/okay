import 'package:okay/_src/result_type.dart';

part 'result/querying_values.dart';

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
}
