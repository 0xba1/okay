# okay

Typed Error-handling for dart. An implementation of rust's [`Result`][result_link] type.

[`Result<T, E>`](https://pub.dev/documentation/okay/latest/okay/Result-class.html) is a type used for returning and propagating Errors. It is a type with the variants, [`Ok(T)`](https://pub.dev/documentation/okay/latest/okay/ok.html), representing success and containing a value, and [`Err(E)`](https://pub.dev/documentation/okay/latest/okay/Err.html), representing Error and containing an Error value.

![ci](https://github.com/0xba1/okay/actions/workflows/okay.yml/badge.svg)
[![pub package][pub_badge]][pub_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

---

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

final result = fallibleOp();

final goodString = switch(result) {
  Ok(v: final value) => value,
  Err(e: final error) => error,
};

// ------------- OR --------------

final goodString = result.when(
  ok: (value) {
    print('Success with value: $value');
    return value;
  },
  err: (error) {
    print('Failure with Error: $Error');
    return 'Fallback string';
  },
);

useString(goodString);

void useString(String value) {
  //
}

Result<String, FallibleOpFailure> fallibleOp() {
  if (true) {
    return Ok('Very good string');
  } else {
    return Err(FallibleOpFailure());
  }
}
```

## Methods and Getters Overview

---

### Extracting Contained Values

- [`expect`](https://pub.dev/documentation/okay/latest/okay/Result/expect.html) returns contained value if `Ok`, throws an exception with provided message if `Err`.
- [`unwrap`](https://pub.dev/documentation/okay/latest/okay/Result/unwrap.html) returns contained value if `Ok`, throws an exception if `Err`.
- [`unwrapOr`](https://pub.dev/documentation/okay/latest/okay/Result/unwrapOr.html) returns contained value if `Ok`, returns the provided fallback value if `Err`.
- [`unwrapOrElse`](https://pub.dev/documentation/okay/latest/okay/Result/unwrapOrElse.html) returns contained value if `Ok`, returns the result of function provided if `Err` (function takes in the contained Error type and returns a value type).
- [`expectErr`](https://pub.dev/documentation/okay/latest/okay/Result/expectErr.html) returns contained Error if Err, throws an exception with provided message if `Ok`.
- [`unwrapErr`](https://pub.dev/documentation/okay/latest/okay/Result/unwrapErr.html) returns contained Error if `Err`, throws an exception if `Ok`.

### Inspect, use the contained values without consuming the result

- [`inspect`](https://pub.dev/documentation/okay/latest/okay/Result/inspect.html) Calls the provided closure with the contained value (if `Ok`) without consuming the result
- [`inspectErr`](https://pub.dev/documentation/okay/latest/okay/Result/inspectErr.html) Calls the provided closure with the contained Error (if `Err`) without consuming the result.

### Querying the variant

- [`isOk`](https://pub.dev/documentation/okay/latest/okay/Result/isOk.html) Returns true if of `Ok` variant, false if not.
- [`isOkAnd`](https://pub.dev/documentation/okay/latest/okay/Result/isOkAnd.html) Returns true if the result is `Ok` and the contained value matches the provided predicate function, otherwise returns false.
- [`isErr`](https://pub.dev/documentation/okay/latest/okay/Result/isErr.html) Returns true if of `Err` variant, false if not.
- [`isErrAnd`](https://pub.dev/documentation/okay/latest/okay/Result/isErrAnd.html) Returns true if the result is `Err` and the contained value matches the provided predicate function, otherwise returns false.

### Adapters

- [`Ok`](https://pub.dev/documentation/okay/latest/okay/Result/ok.html) converts a `Result<T, E>` to a `T?`, i.e, if `Ok`, T, if `Err`, null.

### Transforming contained values

- [`when`](https://pub.dev/documentation/okay/latest/okay/Result/when.html) Converts a `Result<T, E>` to a `U` given a `U ErrMap(E)` and a `U okMap(T)`
- [`mapOrElse`](https://pub.dev/documentation/okay/latest/okay/Result/mapOrElse.html) Converts a `Result<T, E>` to a `U` given a `U ErrMap(E)` and a `U okMap(T)`
- [`mapOr`](https://pub.dev/documentation/okay/latest/okay/Result/mapOr.html) Converts a `Result<T, E>` to a `U`, given a `U fallback` and `U okMap(T)`
- [`map`](https://pub.dev/documentation/okay/latest/okay/Result/map.html) Converts a `Result<T, E>` to `Result<U, E>` by applying the provided function if to contained value if ok, or returning the original Error if Err.
- [`mapErr`](https://pub.dev/documentation/okay/latest/okay/Result/mapErr.html) Converts a `Result<T, E>` to `Result<T, F>` by applying the provided function if to contained Error if Err, or returning the original ok if ok.

### Compare contained ok or Err values

- [`contains`](https://pub.dev/documentation/okay/latest/okay/Result/contains.html) Returns true if the result is an `Ok` value containing the given value, otherwise returns false
- [`containsErr`](https://pub.dev/documentation/okay/latest/okay/Result/containsErr.html) Returns true if the result is an `Err` value containing the given value, otherwise returns false

### Boolean operators

These methods treat the `Result` as a boolean value, where the `Ok` variant is acts like `true` and `Err` acts like `false`.

The [`and`](https://pub.dev/documentation/okay/latest/okay/Result/and.html) `and`[or](https://pub.dev/documentation/okay/latest/okay/Result/or.html) take another `Result` as input, and produce `Result` as output. The [`and`](https://pub.dev/documentation/okay/latest/okay/Result/and.html) method can produce a `Result<U, E>` value having a different inner type `U` than `Result<T, E>`. The [`or`](https://pub.dev/documentation/okay/latest/okay/Result/or.html) method can produce a `Result<T, F>` value having a different Error type `F` than `Result<T, E>`.

| method                                                                    | this     | input    | output   |
| ------------------------------------------------------------------------- | -------- | -------- | -------- |
| [`and`](https://pub.dev/documentation/okay/latest/okay/Result/and.html) ) | `Err(e)` | --       | `Err(e)` |
| [`and`](https://pub.dev/documentation/okay/latest/okay/Result/and.html) ) | `Ok(x)`  | `Err(d)` | `Err(d)` |
| [`and`](https://pub.dev/documentation/okay/latest/okay/Result/and.html) ) | `Ok(x)`  | `Ok(y)`  | `Ok(y)`  |
| [`or`](https://pub.dev/documentation/okay/latest/okay/Result/or.html)     | `Err(e)` | `Err(d)` | `Err(d)` |
| [`or`](https://pub.dev/documentation/okay/latest/okay/Result/or.html)     | `Err(e)` | `Ok(y)`  | `Ok(y)`  |
| [`or`](https://pub.dev/documentation/okay/latest/okay/Result/or.html)     | `Ok(x)`  | --       | `Ok(x)`  |

The [`andThen`](https://pub.dev/documentation/okay/latest/okay/Result/andThen.html) and [`orElse`](https://pub.dev/documentation/okay/latest/okay/Result/orElse.html) methods take a function as input, and only evaluate the function when they need to produce a new value. The [`andThen`](https://pub.dev/documentation/okay/latest/okay/Result/andThen.html) method can produce a `Result<U, E>` value having a different inner type `U` than `Result<T, E>`. The [`orElse`](https://pub.dev/documentation/okay/latest/okay/Result/orElse.html) method can produce a `Result<T, F>` value having a different Error type `F` than `Result<T, E>`.

| method                                                                          | this     | function input | function result | output   |
| ------------------------------------------------------------------------------- | -------- | -------------- | --------------- | -------- |
| [`andThen`](https://pub.dev/documentation/okay/latest/okay/Result/andThen.html) | `Err(e)` | --             | --              | `Err(e)` |
| [`andThen`](https://pub.dev/documentation/okay/latest/okay/Result/andThen.html) | `Ok(x)`  | `x`            | `Err(d)`        | `Err(d)` |
| [`andThen`](https://pub.dev/documentation/okay/latest/okay/Result/andThen.html) | `Ok(x)`  | `x`            | `Ok(y)`         | `Ok(y)`  |
| [`orElse`](https://pub.dev/documentation/okay/latest/okay/Result/orElse.html)   | `Err(e)` | `e`            | `Err(d)`        | `Err(d)` |
| [`orElse`](https://pub.dev/documentation/okay/latest/okay/Result/orElse.html)   | `Err(e)` | `e`            | `Ok(y)`         | `Ok(y)`  |
| [`orElse`](https://pub.dev/documentation/okay/latest/okay/Result/orElse.html)   | `Ok(x)`  | --             | --              | `Ok(x)`  |

### [Extension methods on `Iterable<Result<T, E>>`](https://pub.dev/documentation/okay/latest/okay/Collect.html)

- [`collect`](https://pub.dev/documentation/okay/latest/okay/Collect/collect.html) Convert an `Iterable<Result<T, E>>` to a `Result<Iterable<T>, E>`. If there is an Err in the iterable, the first Err is returned.
- [collectOr](https://pub.dev/documentation/okay/latest/okay/Collect/collectOr.html) Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`. All Err values are replaced by the provided fallback.
- [collectOrElse](https://pub.dev/documentation/okay/latest/okay/Collect/collectOrElse.html) Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`. All Err values are replaced by the result of the provided function.
- [sieve](https://pub.dev/documentation/okay/latest/okay/Collect/sieve.html) Converts an `Iterable<Result<T, E>>` to a `<Iterable<T>`. All Err values skipped.
- [sieveErr](https://pub.dev/documentation/okay/latest/okay/Collect/sieveErr.html) Converts an `Iterable<Result<T, E>>` to a `<Iterable<E>`. All ok values skipped.

[ci_badge]: https://github.com/0xba1/okay/actions/workflows/okay.yml/badge.svg
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[pub_badge]: https://img.shields.io/pub/v/okay
[pub_link]: https://pub.dev/packages/okay
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[result_link]: https://doc.rust-lang.org/std/result/index.html
[coverage_badge]: https://raw.githubusercontent.com/0xba1/okay/b9311276cdc3a77071f18cb8a487368f8435f35c/.assets/coverage_badge.svg

This package was heavily inspired by [rustlang's result type][result_link].
