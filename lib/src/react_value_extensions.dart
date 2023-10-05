part of '../react_state.dart';

// Object

extension ReactObjectExtension<T extends Object> on T {
  @pragma("vm:prefer-inline")
  ReactRef<T> get ref => ReactRef(this);

  @pragma("vm:prefer-inline")
  ReactRef<T?> get nullRef => ReactRef(this);
}

extension ReactObjectNullExtension on Null {
  @pragma("vm:prefer-inline")
  ReactRef<T?> ref<T>() => ReactRef(this);
}

// List

extension ReactListExtension<T> on List<T> {
  @pragma("vm:prefer-inline")
  ReactListRef<T> get ref => ReactListRef<T>(this);
}

// Map

extension ReactMapExtension<K, V> on Map<K, V> {
  @pragma("vm:prefer-inline")
  ReactMapRef<K, V> get ref => ReactMapRef<K, V>(this);
}
