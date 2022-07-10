
# 0.1.0

Initial release

# 0.2.0

Breaking api changes: Result.mapOrElse(), Result.mapOr()

# 0.3.0

Breaking api changes: Result.ok, Result.err

# 0.4.0

Breaking api changes: removed ResultType enum from api

# 0.5.0

Changed dart version to 2.12

# 0.6.0

Created extension Collect<T, E> on Iterable<Result<T, E>>: Iterable.collect, Iterable.collectOr, Iterable.collectOrElse
