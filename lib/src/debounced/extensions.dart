part of '../../react_state.dart';

extension ReactValueDebouncedExtension<T> on T {
  ReactValueDebounced<T> rxDebounced(Duration duration) {
    return ReactValueDebounced<T>(this, duration);
  }
}
