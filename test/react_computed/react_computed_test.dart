import 'package:flutter_test/flutter_test.dart';
import 'package:react_state/react_state.dart';

import '../shared.dart';

void main() {
  test('Should computed values work with one ', () {
    final testListener = TestReactiveListener<bool>();
    StateManager.states.add(testListener);
    final notifyCount = 0.rx;

    final text = ''.rx;
    final isNumber = React.computed(() {
      return num.tryParse(text.value) != null;
    }, immediate: true);
    isNumber.addListener((_) => notifyCount.value++);

    expect(isNumber.valueWithoutSubscription, false);
    expect(testListener.listenersCount, 0);
    expect(notifyCount.value, 0);

    bool isNumberValue = isNumber.value;

    expect(isNumberValue, false);
    expect(testListener.listenersCount, 1);
    expect(notifyCount.value, 0);

    text.value = 'Test';
    isNumberValue = isNumber.valueWithoutSubscription;

    expect(isNumberValue, false);
    expect(testListener.listenersCount, 1);
    expect(notifyCount.value, 0);

    text.value = '123';
    isNumberValue = isNumber.value;

    expect(isNumberValue, true);
    expect(testListener.listenersCount, 2);
    expect(notifyCount.value, 1);

    React.disposeComputed(isNumber);
  });

  test('Should computed values batch changes and only recompute once', () {
    final testListener = TestReactiveListener<double>();
    StateManager.states.add(testListener);
    final notifyCount = 0.rx;

    final number1 = 12.rx;
    final number2 = 24.rx;
    final number3 = 36.rx;

    final sum = React.computed(() {
      return (number1.value + number2.value + number3.value).toDouble();
    }, immediate: true);
    sum.addListener((_) => notifyCount.value++);

    expect(sum.value, 72);
    expect(testListener.listenersCount, 1);
    expect(notifyCount.value, 0);

    number1.value = 44;
    number2.value = 7;
    number3.value = 11;

    expect(sum.value, 62);
    expect(testListener.listenersCount, 2);
    expect(notifyCount.value, 3);

    React.disposeComputed(sum);
  });
}
