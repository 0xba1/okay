// ignore_for_file: no_default_cases

import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  test('ResultType.ok', () {
    const okResult = ResultType.ok;

    expect(okResult, ResultType.ok);
  });

  test('ResultType.err', () {
    const errResult = ResultType.err;

    expect(errResult, ResultType.err);
  });

  test('Only `ok` and `err` variants of `ResultType` exist', () {
    const results = ResultType.values;

    for (final result in results) {
      switch (result) {
        case ResultType.ok:
          break;
        case ResultType.err:
          break;
        default:
          throw Exception(
            'Only `ok` and `err` variants of `ResultType` should exist',
          );
      }
    }
  });
}
