part of '../react_state.dart';

// Primitive

extension ReactPrimInt on int {
  @pragma("vm:prefer-inline")
  ReactObject<int> get rx => ReactObject(this);
}

extension ReactPrimDouble on double {
  @pragma("vm:prefer-inline")
  ReactObject<double> get rx => ReactObject(this);
}

extension ReactPrimNum on num {
  @pragma("vm:prefer-inline")
  ReactObject<num> get rx => ReactObject(this);
}

extension ReactPrimBool on bool {
  @pragma("vm:prefer-inline")
  ReactObject<bool> get rx => ReactObject(this);
}

extension ReactPrimString on String {
  @pragma("vm:prefer-inline")
  ReactObject<String> get rx => ReactObject(this);
}

extension ReactPrimEnum<T extends Enum> on T {
  @pragma("vm:prefer-inline")
  ReactObject<T> get rx => ReactObject(this);
}

extension ReactPrimObject<T> on T {
  @pragma("vm:prefer-inline")
  ReactObject<T> get rx => ReactObject(this);
}

// List

extension ReactPrimList<T> on List<T> {
  @pragma("vm:prefer-inline")
  ReactList<T> get rx => ReactList<T>(this);
}

// Map

extension ReactPrimMap<K, V> on Map<K, V> {
  @pragma("vm:prefer-inline")
  ReactMap<K, V> get rx => ReactMap<K, V>(this);
}
