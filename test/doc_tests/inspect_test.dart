import 'package:okay/okay.dart';
import 'package:test/test.dart';

void main() {
  Result<int, String> parseToInt(String value) {
    try {
      return Ok(int.parse(value));
    } catch (_) {
      return Err(value);
    }
  }

  test('Result.inspect() on Ok', () {
    var randomSideVar = 0;

    final _ = parseToInt('4').inspect((val) => randomSideVar = val * 9);

    expect(randomSideVar, 36);
  });

  test('Result.inspectErr() on Err', () {
    var randomSideVar = 0;

    final _ =
        parseToInt('four').inspectErr((val) => randomSideVar = val.length);

    expect(randomSideVar, 4);
  });

  test('Result.inspectErr() on Ok', () {
    var randomSideVar = 0;

    final _ = parseToInt('4').inspectErr((err) => randomSideVar = err.length);

    expect(randomSideVar, 0);
  });

  test('Result.inspect() on Err', () {
    var randomSideVar = 0;

    final _ = parseToInt('four').inspect((val) => randomSideVar = val);

    expect(randomSideVar, 0);
  });
}
