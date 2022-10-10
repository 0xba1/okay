
# 1.3.1

- Updated readme

# 1.3.0

- Added `sieveErr` method on `Iterable<Result<T, E>>`
- Moved methods to class declaration for visibility

# 1.2.1

- Improved readme
- Added nullable values and errors test

# 1.2.0

- Added `sieve` method on `Iterable<Result<T, E>>`

# 1.1.0

- Added `Result.when` method.

# 1.0.1

- Fixed typo.

# 1.0.0

- Initial stable release.
- Better readme and example.
- Removed `ResultType` from api.
- Added methods on `Iterable` of `Result`.

# 0.6.0

Created extension Collect<T, E> on Iterable<Result<T, E>>: Iterable.collect, Iterable.collectOr, Iterable.collectOrElse

# 0.5.0

Changed dart version to 2.12

# 0.4.0

Breaking api changes: removed ResultType enum from api

# 0.3.0

Breaking api changes: Result.ok, Result.err

# 0.2.0

Breaking api changes: Result.mapOrElse(), Result.mapOr()

# 0.1.0

Initial release
