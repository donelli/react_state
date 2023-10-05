part of '../../react_state.dart';

extension ReactValueDebouncedExtension<T> on T {
  ReactValueDebounced<T> debouncedRef({
    int? milliseconds,
    int? seconds,
  }) {
    return ReactValueDebounced<T>(
      this,
      Duration(
        milliseconds: milliseconds ?? 0,
        seconds: seconds ?? 0,
      ),
    );
  }
}
