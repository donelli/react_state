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
    expect(reactList.length, 2);
    expect(reactList, [1, 2]);
  });

  test("Should ReactList.first work and only notify once", () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    final firstItem = reactList.first;

    expect(notifyCount.value, 0);
    expect(testListener.listenersCount, 1);
    expect(firstItem, 1);
  });

  test(
    "Should ReactList.firstOrNull work and only notify once if there is elements",
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
    "Should ReactList.firstOrNull work and only notify once if there isn't a element",
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
    "Should ReactList.isEmpty work and only notify once",
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
    "Should ReactList.isNotEmpty work and only notify once",
    () {
      final notifyCount = 0.rx;
      final reactList = createTestList<int>(notifyCount, [1]);

      final isNotEmpty = reactList.isNotEmpty;

      expect(notifyCount.value, 0);
      expect(testListener.listenersCount, 1);
      expect(isNotEmpty, true);
    },
  );

  test("Should ReactList.last work and only notify once", () {
    final notifyCount = 0.rx;
    final reactList = createTestList<int>(notifyCount, [1, 2, 3]);

    final lastItem = reactList.last;

    expect(notifyCount.value, 0);
    expect(testListener.listenersCount, 1);
    expect(lastItem, 3);
  });

  test(
    "Should ReactList.lastOrNull work and only notify once if there is elements",
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
    "Should ReactList.lastOrNull work and only notify once if there isn't a element",
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
    "Should ReactList.single work and only notify once",
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

  // TODO: list.iterator
  // TODO: list.reversed
  // TODO: list.value
  // TODO: list.add(element)
  // TODO: list.addAll()
  // TODO: list.any((element) => false)
  // TODO: list.asMap()
  // TODO: list.batch((list) { })
  // TODO: list.clear
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
