import 'package:flutter_test/flutter_test.dart';
import 'package:react_state/react_state.dart';

import '../shared.dart';

void main() {
  late TestReactiveListener testListener;

  tearDown(() {
    testListener.listenersCount = 0;
  });

  void setupListener<T>() {
    testListener = TestReactiveListener<T>();
    StateManager.states.add(testListener);
  }

  test('Should correctly handle ReactValues of Strings', () {
    setupListener<String>();
    var notifyCount = 0;
    final value = 'Test'.rx;
    value.addListener((_) => notifyCount++);

    expect(value.value, 'Test');
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 0);

    value.value = 'Updated';
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 1);
    expect(value.value, 'Updated');
  });

  test('Should correctly handle ReactValues of bool', () {
    setupListener<bool>();
    var notifyCount = 0;
    final value = false.rx;
    value.addListener((_) => notifyCount++);

    expect(value.value, false);
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 0);

    value.value = true;
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 1);
    expect(value.value, true);
  });

  test('Should correctly handle ReactValues of int', () {
    setupListener<int>();
    var notifyCount = 0;
    final value = 123.rx;
    value.addListener((_) => notifyCount++);

    expect(value.value, 123);
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 0);

    value.value = 999;
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 1);
    expect(value.value, 999);
  });

  test('Should correctly handle ReactValues of num', () {
    setupListener<num>();
    var notifyCount = 0;
    // ignore: unnecessary_cast
    final value = (44 as num).rx;
    value.addListener((_) => notifyCount++);

    expect(value.value, 44);
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 0);

    value.value = 12;
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 1);
    expect(value.value, 12);
  });

  test('Should correctly handle ReactValues of double', () {
    setupListener<double>();
    var notifyCount = 0;
    final value = (55.42).rx;
    value.addListener((_) => notifyCount++);

    expect(value.value, 55.42);
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 0);

    value.value += 1;
    expect(testListener.listenersCount, 2);
    expect(notifyCount, 1);
    expect(value.value, 56.42);
  });

  test('Should correctly handle ReactValues of double', () {
    setupListener<TestEnum>();
    var notifyCount = 0;
    final value = TestEnum.two.rx;
    value.addListener((_) => notifyCount++);

    expect(value.value, TestEnum.two);
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 0);

    value.value = TestEnum.three;
    expect(testListener.listenersCount, 1);
    expect(notifyCount, 1);
    expect(value.value, TestEnum.three);
  });
}

enum TestEnum { one, two, three }
