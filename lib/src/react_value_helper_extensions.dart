part of '../react_state.dart';

extension ReactValueBoolExtension on ReactObject<bool> {
  void toggle() => value = !value;
}
