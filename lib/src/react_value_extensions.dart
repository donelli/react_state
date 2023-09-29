part of '../react_state.dart';

// Object

extension ReactObjectExtension<T> on T {
  @pragma("vm:prefer-inline")
  ReactObject<T> get rx => ReactObject(this);

  @pragma("vm:prefer-inline")
  ReactObject<T?> get rxNull => ReactObject(this);
}

extension ReactObjectNullExtension on Null {
  @pragma("vm:prefer-inline")
  ReactObject<T?> rxNull<T>() => ReactObject(this);
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
