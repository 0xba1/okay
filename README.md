
# okay

Typesafe, intuitive error-handling for dart . An implementation of rust's `Result` type in dart.

[![ci][ci_badge]][ci_link]
[![coverage][coverage_badge]][ci_link]
[![pub package][pub_badge]][pub_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

**Note**: This package was heavily inspired by [rustlang's result type][result_link].

## Installation

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
  okay: <latest_version>
```

## Usage

```dart
import 'package:okay/okay.dart';

class FallibleOpSuccess {}
class FallibleOpFailure {}

Result<FallibleOpSuccess, FallibleOpFailure> fallibleOp() {
  if (true) {
    return ok(FallibleOpSuccess());
  } else {
    return err(FallibleOpFailure());
  }
}

final result = fallibleOp();

switch(result.type) {
  case ResultType.ok:
    print('Success with value: ${result.unwrap()}');
    break;
  case ResultType.err: 
    print('Failure with error: ${result.unwrapErr()};');
    break;      
}
```

[ci_badge]: https://img.shields.io/github/workflow/status/0xba1/okay/okay
[ci_link]: https://github.com/0xba1/okay/actions
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[pub_badge]: https://img.shields.io/pub/v/okay
[pub_link]: https://pub.dev/packages/okay
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[result_link]: https://doc.rust-lang.org/std/result/index.html
[coverage_badge]: https://raw.githubusercontent.com/0xba1/okay/b9311276cdc3a77071f18cb8a487368f8435f35c/.assets/coverage_badge.svg
