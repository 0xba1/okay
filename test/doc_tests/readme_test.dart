// ignore_for_file: avoid_print

import 'package:okay/okay.dart';
import 'package:test/test.dart';

class FallibleOpFailure {}

void main() {
  test('README', () {
    void useString(String value) {
      //
    }
    Result<String, FallibleOpFailure> fallibleOp() {
      // ignore: literal_only_boolean_expressions
      if (true) {
        return ok('Very good string');
        // ignore: dead_code
      } else {
        return err(FallibleOpFailure());
      }
    }

    final result = fallibleOp();

    final goodString = result.when(
      ok: (value) {
        print('Success with value: $value');
        return value;
      },
      err: (error) {
        print('Failure with error: $error');
        return 'Fallback string';
      },
    );

    useString(goodString);
  });
}
