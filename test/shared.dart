import 'package:react_state/react_state.dart';

class TestReactiveListener<U> extends ReactReactiveListener {
  int listenersCount = 0;

  @override
  void addRef<T>(ReactInterface<T> ref) {
    if (T != U) {
      return;
    }

    ++listenersCount;
  }
}

ReactMapRef<K, V> createTestMap<K, V>([
  ReactRef<int>? notifyCount,
  Map<K, V>? map,
]) {
  final reactMap = (map ?? {}).ref;
  if (notifyCount != null) {
    reactMap.addListener((_) => notifyCount.value++);
  }
  return reactMap;
}

ReactListRef<T> createTestList<T>([
  ReactRef<int>? notifyCount,
  List<T>? list,
]) {
  final reactList = (list ?? []).ref;
  if (notifyCount != null) {
    reactList.addListener((_) => notifyCount.value++);
  }
  return reactList;
}
