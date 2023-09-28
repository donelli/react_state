part of '../react_state.dart';

// Primitive

extension ReactPrimInt on int {
  @pragma("vm:prefer-inline")
  ReactPrim<int> get rx => ReactPrim(this);
}

extension ReactPrimDouble on double {
  @pragma("vm:prefer-inline")
  ReactPrim<double> get rx => ReactPrim(this);
}

extension ReactPrimNum on num {
  @pragma("vm:prefer-inline")
  ReactPrim<num> get rx => ReactPrim(this);
}

extension ReactPrimBool on bool {
  @pragma("vm:prefer-inline")
  ReactPrim<bool> get rx => ReactPrim(this);
}

extension ReactPrimString on String {
  @pragma("vm:prefer-inline")
  ReactPrim<String> get rx => ReactPrim(this);
}

extension ReactPrimEnum<T extends Enum> on T {
  @pragma("vm:prefer-inline")
  ReactPrim<T> get rx => ReactPrim(this);
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
