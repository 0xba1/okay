
# okay

Typed error-handling for dart. An implementation of rust's [`Result`][result_link] type.

[`Result<T, E>`](https://pub.dev/documentation/okay/latest/okay/Result-class.html) is a type used for returning and propagating errors. It is a type with the variants, [`ok(T)`](https://pub.dev/documentation/okay/latest/okay/ok.html), representing success and containing a value, and [`err(E)`](https://pub.dev/documentation/okay/latest/okay/err.html), representing error and containing an error value.

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

## Basic Usage

```dart
import 'package:okay/okay.dart';

class FallibleOpFailure {}

Result<String, FallibleOpFailure> fallibleOp() {
  if (true) {
    return ok('Very good string');
  } else {
    return err(FallibleOpFailure());
  }
}

final result = fallibleOp();

final goodString = result.inspect((value) {
  print('Success with value: $value');
}).inspectErr((error) {
  print('Failure with error: $error');
}).unwrapOr('Fallback string');

useString(goodString);




void useString(String value) {
  //
}

```

## Methods and Getters Overview

---

### [Extracting Contained Values](https://pub.dev/documentation/okay/latest/okay/Extractors.html)

- [`expect`](https://pub.dev/documentation/okay/latest/okay/Extractors/expect.html) returns contained value if ok, throws an exception with provided message if err.
- [`unwrap`](https://pub.dev/documentation/okay/latest/okay/Extractors/unwrap.html) returns contained value if `ok`, throws an exception if `err`.
- [`unwrapOr`](https://pub.dev/documentation/okay/latest/okay/Extractors/unwrapOr.html) returns contained value if `ok`, returns the provided fallback value if `err`.
- [`unwrapOrElse`](https://pub.dev/documentation/okay/latest/okay/Extractors/unwrapOrElse.html) returns contained value if `ok`, returns the result of function provided if `err` (function takes in the contained error type and returns a value type).

### [Inspect, use the contained values without consuming the result](https://pub.dev/documentation/okay/latest/okay/Inspect.html)

- [`inspect`](https://pub.dev/documentation/okay/latest/okay/Inspect/inspect.html) Calls the provided closure with the contained value (if `ok`) without consuming the result
- [`inspectErr`](https://pub.dev/documentation/okay/latest/okay/Inspect/inspectErr.html) Calls the provided closure with the contained error (if `err`) without consuming the result.

### [Querying the variant](https://pub.dev/documentation/okay/latest/okay/QueryingValues.html)

- [`isOk`](https://pub.dev/documentation/okay/latest/okay/QueryingValues/isOk.html) Returns true if of `ok` variant, false if not.
- [`isOkAnd`](https://pub.dev/documentation/okay/latest/okay/QueryingValues/isOkAnd.html) Returns true if the result is `ok` and the contained value matches the provided predicate function, otherwise returns false.
- [`isErr`](https://pub.dev/documentation/okay/latest/okay/QueryingValues/isErr.html) Returns true if of `err` variant, false if not.
- [`isErrAnd`](https://pub.dev/documentation/okay/latest/okay/QueryingValues/isErrAnd.html) Returns true if the result is `err` and the contained value matches the provided predicate function, otherwise returns false.

### [Adapters](https://pub.dev/documentation/okay/latest/okay/Adapter.html)

- [`ok`](https://pub.dev/documentation/okay/latest/okay/Adapter/ok.html) converts a `Result<T, E>` to a `T?`, i.e, if `ok`, T, if `err`, null.

### [Transforming contained values](https://pub.dev/documentation/okay/latest/okay/Transformers.html)

- [`mapOrElse`](https://pub.dev/documentation/okay/latest/okay/Transformers/mapOrElse.html) Converts a `Result<T, E>` to a `U` given a `U errMap(E)` and a `U okMap(T)`
- [`mapOr`](https://pub.dev/documentation/okay/latest/okay/Transformers/mapOr.html) Converts a `Result<T, E>` to a `U`, given a `U fallback` and `U okMap(T)`
- [`map`](https://pub.dev/documentation/okay/latest/okay/Transformers/map.html) Converts a `Result<T, E>` to `Result<U, E>` by applying the provided function if to contained value if ok, or returning the original error if err.

### [OkOrErr on `Result<T, T>`](https://pub.dev/documentation/okay/latest/okay/OkOrErr.html)

- [`okOrErr`](https://pub.dev/documentation/okay/latest/okay/OkOrErr/okOrErr.html) Returns value if `ok` or error if `err` (as the most precise same type `T`).

### [Compare contained ok or err values](https://pub.dev/documentation/okay/latest/okay/Contains.html)_

- [`contains`](https://pub.dev/documentation/okay/latest/okay/Contains/contains.html) Returns true if the result is an `ok` value containing the given value, otherwise returns false
- [`containsErr`](https://pub.dev/documentation/okay/latest/okay/Contains/containsErr.html) Returns true if the result is an `err` value containing the given value, otherwise returns false

### [Boolean operators](https://pub.dev/documentation/okay/latest/okay/Boolean.html)

These methods treat the `Result` as a boolean value, where the `ok` variant is acts like `true` and `err` acts like `false`.

The [`and`](https://pub.dev/documentation/okay/latest/okay/Boolean/and.html)` and `[or](https://pub.dev/documentation/okay/latest/okay/Boolean/or.html) take another `Result` as input, and produce `Result` as output. The [`and`](https://pub.dev/documentation/okay/latest/okay/Boolean/and.html) method can produce a `Result<U, E>` value having a different inner type `U` than `Result<T, E>`. The [`or`](https://pub.dev/documentation/okay/latest/okay/Boolean/or.html) method can produce a `Result<T, F>` value having a different error type `F` than `Result<T, E>`.

| method | this | input | output |
| ------ | ---- | ----- | ------ |
| [`and`](https://pub.dev/documentation/okay/latest/okay/Boolean/and.html) | `err(e)` | -- | `err(e)`|
| [`and`](https://pub.dev/documentation/okay/latest/okay/Boolean/and.html) | `ok(x)` | `err(d)` | `err(d)` |
| [`and`](https://pub.dev/documentation/okay/latest/okay/Boolean/and.html) | `ok(x)` | `ok(y)` | `ok(y)` |
| [`or`](https://pub.dev/documentation/okay/latest/okay/Boolean/or.html) | `err(e)` | `err(d)` | `err(d)` |
| [`or`](https://pub.dev/documentation/okay/latest/okay/Boolean/or.html) | `err(e)` | `ok(y)` | `ok(y)` |
| [`or`](https://pub.dev/documentation/okay/latest/okay/Boolean/or.html) | `ok(x)` | -- | `ok(x)` |

The [`andThen`](https://pub.dev/documentation/okay/latest/okay/Boolean/andThen.html) and [`orElse`](https://pub.dev/documentation/okay/latest/okay/Boolean/orElse.html) methods take a function as input, and only evaluate the function when they need to produce a new value. The [`andThen`](https://pub.dev/documentation/okay/latest/okay/Boolean/andThen.html) method can produce a `Result<U, E>` value having a different inner type `U` than `Result<T, E>`. The [`orElse`](https://pub.dev/documentation/okay/latest/okay/Boolean/orElse.html) method can produce a `Result<T, F>` value having a different error type `F` than `Result<T, E>`.

| method | this | function input | function result | output |
| ------ | ---- | -------------- | --------------- | ------ |
| [`andThen`](https://pub.dev/documentation/okay/latest/okay/Boolean/andThen.html) | `err(e)` | -- | -- | `err(e)`|
| [`andThen`](https://pub.dev/documentation/okay/latest/okay/Boolean/andThen.html) | `ok(x)` | `x` | `err(d)` | `err(d)` |
| [`andThen`](https://pub.dev/documentation/okay/latest/okay/Boolean/andThen.html) | `ok(x)` | `x` | `ok(y)` | `ok(y)` |
| [`orElse`](https://pub.dev/documentation/okay/latest/okay/Boolean/orElse.html) | `err(e)` | `e` | `err(d)` | `err(d)` |
| [`orElse`](https://pub.dev/documentation/okay/latest/okay/Boolean/orElse.html) | `err(e)` | `e` | `ok(y)` | `ok(y)` |
| [`orElse`](https://pub.dev/documentation/okay/latest/okay/Boolean/orElse.html) | `ok(x)` | -- | -- | `ok(x)` |

### [Extension methods on `Iterable<Result<T, E>>`](https://pub.dev/documentation/okay/latest/okay/Collect.html)

- [`collect`](https://pub.dev/documentation/okay/latest/okay/Collect/collect.html) Convert an `Iterable<Result<T, E>>` to a `Result<Iterable<T>, E>`. If there is an err in the iterable, the first err is returned.

- [collectOr](https://pub.dev/documentation/okay/latest/okay/Collect/collectOr.html) Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`. All err values are replaced by the provided fallback.

- [collectOrElse](https://pub.dev/documentation/okay/latest/okay/Collect/collectOrElse.html) Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`. All err values are replaced by the result of the provided function.

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
