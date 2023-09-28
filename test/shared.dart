import 'package:react_state/react_state.dart';

ReactMap<K, V> createTestMap<K, V>(
  ReactPrim<int> notifyCount, [
  Map<K, V>? map,
]) {
  final reactMap = (map ?? {}).rx;
  reactMap.addListener((_) => notifyCount.value++);
  return reactMap;
}
