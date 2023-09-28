part of '../../react_state.dart';

class _ReactMapValuesIterable<K, V> extends Iterable<V> {
  final ReactMap<K, V> _map;
  _ReactMapValuesIterable(this._map);

  @override
  int get length => _map.length;

  @override
  bool get isEmpty => _map.isEmpty;

  @override
  bool get isNotEmpty => _map.isNotEmpty;

  @override
  V get first => _map[_map.keys.first] as V;

  @override
  V get single => _map[_map.keys.single] as V;

  @override
  V get last => _map[_map.keys.last] as V;

  @override
  Iterator<V> get iterator => _ReactMapValuesIterator<K, V>(_map);
}

class _ReactMapValuesIterator<K, V> implements Iterator<V> {
  final Iterator<K> _keys;
  final ReactMap<K, V> _map;
  V? _current;

  _ReactMapValuesIterator(ReactMap<K, V> map)
      : _map = map,
        _keys = map.keys.iterator;

  @override
  bool moveNext() {
    if (_keys.moveNext()) {
      _current = _map._value[_keys.current];
      return true;
    }
    _current = null;
    return false;
  }

  @override
  V get current => _current as V;
}
