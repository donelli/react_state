import 'package:flutter_test/flutter_test.dart';
import 'package:react_state/react_state.dart';

import '../shared.dart';

void main() {
  final testListener = TestReactiveListener<List<int>>();
  StateManager.states.add(testListener);

  tearDown(() {
    testListener.listenersCount = 0;
  });

  test('Should ReactList.length works', () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    expect(reactList.length, 3);
    expect(notifyCount.value, 0);
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactList assignment work', () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    reactList[0] = 22;

    expect(notifyCount.value, 1);
    expect(testListener.listenersCount, 0);
    expect(reactList.length, 3);
    expect(reactList[0], 22);
  });

  test(
    "Should ReactList assignment work and don't notify if value is the same",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

      reactList[1] = 2;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 0);
      expect(reactList.length, 3);
      expect(reactList[1], 2);
    },
  );

  test("Should ReactList.[] work and add this Value to listeners", () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    final value = reactList[1];

    expect(notifyCount.value, 0);
    expect(testListener.listenersCount, 1);
    expect(value, 2);
  });

  test("Should ReactList.batch work and only notify once", () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    reactList.batch((list) {
      list.clear();
      list.add(1);
      list.add(2);
    });

    expect(notifyCount.value, 1);
    expect(testListener.listenersCount, 0);
    expect(reactList, [1, 2]);
  });

  test("Should ReactList.first work and subscribe to listeners", () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    final firstItem = reactList.first;

    expect(notifyCount.value, 0);
    expect(testListener.listenersCount, 1);
    expect(firstItem, 1);
  });

  test(
    "Should ReactList.firstOrNull work and subscribe to listeners if there is elements",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

      final firstItem = reactList.firstOrNull;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(firstItem, 1);
    },
  );

  test(
    "Should ReactList.firstOrNull work and subscribe to listeners if there isn't a element",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);

      final firstItem = reactList.firstOrNull;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(firstItem, null);
    },
  );

  test(
    "Should ReactList.isEmpty work and subscribe to listeners",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);

      final isEmpty = reactList.isEmpty;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(isEmpty, true);
    },
  );

  test(
    "Should ReactList.isNotEmpty work and subscribe to listeners",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1]);

      final isNotEmpty = reactList.isNotEmpty;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(isNotEmpty, true);
    },
  );

  test("Should ReactList.last work and subscribe to listeners", () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    final lastItem = reactList.last;

    expect(notifyCount.value, 0);
    expect(testListener.listenersCount, 1);
    expect(lastItem, 3);
  });

  test(
    "Should ReactList.lastOrNull work and subscribe to listeners if there is elements",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

      final firstItem = reactList.lastOrNull;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(firstItem, 3);
    },
  );

  test(
    "Should ReactList.lastOrNull work and subscribe to listeners if there isn't a element",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);

      final firstItem = reactList.lastOrNull;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(firstItem, null);
    },
  );

  test(
    "Should ReactList.single work and subscribe to listeners",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [2]);

      final singleItem = reactList.single;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(singleItem, 2);
    },
  );

  test(
    "Should ReactList.single throws if there is more then one element",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [2, 2]);

      expect(() => reactList.single, throwsA(isA<StateError>()));

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
    },
  );

  test(
    "Should ReactList.single throws if there is no element",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);

      expect(() => reactList.single, throwsA(isA<StateError>()));

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
    },
  );

  test(
    "Should ReactList.add work and notify listeners",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);

      reactList.add(1);
      reactList.add(2);

      expect(notifyCount.value, 2);
      expect(testListener.listenersCount, 0);
      expect(reactList.value, [1, 2]);
    },
  );

  test(
    "Should ReactList.addAll work and notify listeners only once",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);
      final otherList = [2, 4, 6, 8, 10];

      reactList.addAll(otherList);

      expect(notifyCount.value, 1);
      expect(testListener.listenersCount, 0);
      expect(reactList.value, otherList);
    },
  );

  test(
    "Should't ReactList.addAll notify listeners if iterable is empty",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);

      reactList.addAll([]);

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 0);
      expect(reactList.length, 0);
    },
  );

  test(
    "Should ReactList.clear work and notify listeners only once",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1, 2]);

      reactList.clear();

      expect(notifyCount.value, 1);
      expect(testListener.listenersCount, 0);
      expect(reactList.length, 0);
    },
  );

  test(
    "Should't ReactList.clear notify listeners if it's already empty",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount);

      reactList.clear();

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 0);
      expect(reactList.length, 0);
    },
  );

  test(
    "Should ReactList.any work and subscribe to listeners",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1, 2, 3, 4]);

      final hasThree = reactList.any((value) => value == 3);

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(hasThree, true);
    },
  );

  test(
    "Should ReactList.any work and subscribe to listeners even if element is not founded",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1, 2, 3, 4]);

      final hasThree = reactList.any((value) => value == 9);

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(hasThree, false);
    },
  );

  // TODO: list.iterator
  // TODO: list.reversed
  // TODO: list.value
  // TODO: list.asMap()
  // TODO: list.batch((list) { })
  // TODO: list.contains
  // TODO: list.elementAt(index)
  // TODO: list.every
  // TODO: list.expand
  // TODO: list.fillRange
  // TODO: list.firstWhere
  // TODO: list.fold
  // TODO: list.followedBy
  // TODO: list.forEach((element) { })
  // TODO: list.getRange
  // TODO: list.indexOf(element)
  // TODO: list.indexWhere(element)
  // TODO: list.insert(index, element)
  // TODO: list.insertAll
  // TODO: list.join()
  // TODO: list.lastIndexOf(element)
  // TODO: list.lastIndexWhere((element) => false)
  // TODO: list.lastWhere((element) => false)
  // TODO: list.map((element) => null)
  // TODO: list.reduce((previousValue, element) => null)
  // TODO: list.remove(element)
  // TODO: list.removeAt(index)
  // TODO: list.removeLast()
  // TODO: list.removeRange(start, end)
  // TODO: list.removeWhere((element) => false)
  // TODO: list.replaceRange(start, end, newContents)
  // TODO: list.retainWhere((element) => false)
  // TODO: list.setAll(index, iterable)
  // TODO: list.setRange(start, end, iterable)
  // TODO: list.shuffle()
  // TODO: list.singleWhere((element) => false)
  // TODO: list.skip(count)
  // TODO: list.skipWhile((element) => false)
  // TODO: list.sort()
  // TODO: list.sublist(start)
  // TODO: list.take(count)
  // TODO: list.takeWhile((element) => false)
  // TODO: list.toList()
  // TODO: list.toSet()
  // TODO: list.where((element) => false)
  // TODO: list.whereType()
}
