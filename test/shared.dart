import 'package:react_state/react_state.dart';

class TestReactiveListener<U> extends ReactiveListener {
  int listenersCount = 0;

  @override
  void addRx<T>(ReactInterface<T> rx) {
    if (T != U) {
      return;
    }

    ++listenersCount;
  }
}

ReactMap<K, V> createTestMap<K, V>([
  ReactValue<int>? notifyCount,
  Map<K, V>? map,
]) {
  final reactMap = (map ?? {}).rx;
  if (notifyCount != null) {
    reactMap.addListener((_) => notifyCount.value++);
  }
  return reactMap;
}

ReactList<T> createTestList<T>([
  ReactValue<int>? notifyCount,
  List<T>? list,
]) {
  final reactList = (list ?? []).rx;
  if (notifyCount != null) {
    reactList.addListener((_) => notifyCount.value++);
  }
  return reactList;
}
