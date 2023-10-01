part of '../react_state.dart';

// Object

extension ReactObjectExtension<T extends Object> on T {
  @pragma("vm:prefer-inline")
  ReactValue<T> get rx => ReactValue(this);

  @pragma("vm:prefer-inline")
  ReactValue<T?> get rxNull => ReactValue(this);
}

extension ReactObjectNullExtension on Null {
  @pragma("vm:prefer-inline")
  ReactValue<T?> rx<T>() => ReactValue(this);
}

// List

extension ReactListExtension<T> on List<T> {
  @pragma("vm:prefer-inline")
  ReactList<T> get rx => ReactList<T>(this);
}

// Map

extension ReactMapExtension<K, V> on Map<K, V> {
  @pragma("vm:prefer-inline")
  ReactMap<K, V> get rx => ReactMap<K, V>(this);
}
