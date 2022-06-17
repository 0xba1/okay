part of '../result.dart';

/// `ok` and `err` have the same type
extension OkOrErr<T> on Result<T, T> {}
