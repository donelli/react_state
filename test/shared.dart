import 'package:react_state/react_state.dart';

class TestReactiveListener<U> extends ReactiveListener {
  int listenersCount = 0;

  @override
  void addRx<T>(ReactValue<T> rx) {
    if (T != U) {
      return;
    }

    ++listenersCount;
  }
}

ReactMap<K, V> createTestMap<K, V>([
  ReactPrim<int>? notifyCount,
  Map<K, V>? map,
]) {
  final reactMap = (map ?? {}).rx;
  if (notifyCount != null) {
    reactMap.addListener((_) => notifyCount.value++);
  }
  return reactMap;
}
