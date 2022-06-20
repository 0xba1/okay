import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  Result<int, String> parseToInt(String value) {
    try {
      return ok(int.parse(value));
    } catch (_) {
      return err(value);
    }
  }

  test('Result.inspect()', () {
    var randomSideVar = 0;

    final _ = parseToInt('4').inspect((val) => randomSideVar = val * 9);

    expect(randomSideVar, 36);
  });

  test('Result.inspect()', () {
    var randomSideVar = 0;

    final _ =
        parseToInt('four').inspectErr((val) => randomSideVar = val.length);

    expect(randomSideVar, 4);
  });
}
