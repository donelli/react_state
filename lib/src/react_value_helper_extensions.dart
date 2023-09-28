part of '../react_state.dart';

extension ReactValueBoolExtension on ReactPrim<bool> {
  void toggle() => value = !value;
}
