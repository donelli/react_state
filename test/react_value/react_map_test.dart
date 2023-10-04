import 'package:flutter_test/flutter_test.dart';
import 'package:react_state/react_state.dart';

import '../shared.dart';

void main() {
  final testListener = TestReactiveListener<Map<String, int>>();
  ReactStateManager.instance.addListener(testListener);

  tearDown(() {
    testListener.listenersCount = 0;
  });

  test('Should correctly create ReactMap using the rx extension', () {
    final reactMap = <String, int>{}.rx;
    expect(reactMap.runtimeType, ReactMap<String, int>);
  });

  // ReactMap.value=

  test('Should trigger notify when updating the entire map', () {
    final notifyCount = 0.rx;
    final reactMap = createTestMap<String, int>(notifyCount);

    reactMap.value = {'a': 1, 'b': 7};

    expect(testListener.listenersCount, 0);
    expect(notifyCount.value, 1);
    expect(reactMap.length, 2);
  });

  // ReactMap.[]=

  test('Should only trigger 1 notify when updating a map entry', () {
    final notifyCount = 0.rx;
    final reactMap = createTestMap<String, int>(notifyCount);

    reactMap['a'] = 1;

    expect(testListener.listenersCount, 0);
    expect(notifyCount.value, 1);
    expect(reactMap.length, 1);
  });

  test(
    'Should trigger multiple notifies when updating a map entries on sequence',
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(notifyCount);

      reactMap['a'] = 1;
      reactMap['b'] = 2;
      reactMap['c'] = 3;

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 3);
      expect(reactMap.length, 3);
    },
  );

  test(
    'Should not trigger notifies if old entry value is equals to the new one on assignment',
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1},
      );

      reactMap['a'] = 1;

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 1);
    },
  );

  // ReactMap.clear

  test(
    'Should only trigger 1 notify when cleaning a ReactMap',
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 2, 'c': 3},
      );

      reactMap.clear();

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 0);
    },
  );

  test(
    "Should't notify when cleaning a empty map",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(notifyCount);

      reactMap.clear();

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
    },
  );

  // ReactMap.addAll

  test(
    'Should Map.addAll only notify once',
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'d': 4},
      );

      reactMap.addAll({
        'a': 1,
        'b': 3,
        'c': 2,
      });

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 4);
    },
  );

  test(
    "Shouldn't Map.addAll notify if all entries from the new map are already in the ReactMap",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 3, 'c': 2},
      );

      reactMap.addAll({
        'a': 1,
        'b': 3,
      });

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 3);
    },
  );

  // ReactMap.addEntries

  test(
    'Should Map.addEntries only notify once',
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'d': 4},
      );

      reactMap.addEntries([
        const MapEntry('a', 2),
        const MapEntry('b', 2),
        const MapEntry('c', 2),
      ]);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 4);
    },
  );

  test(
    "Shouldn't Map.addEntries notify if there is no new entry values",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 2, 'b': 3},
      );

      reactMap.addEntries([
        const MapEntry('a', 2),
        const MapEntry('b', 3),
      ]);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 2);
    },
  );

  // ReactMap.updateAll

  test(
    'Should Map.updateAll only notify once',
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 2, 'c': 3},
      );

      reactMap.updateAll((key, value) {
        return value * 2;
      });

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 3);
    },
  );

  test(
    "Shouldn't Map.updateAll notify if nothing changed",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 2, 'c': 3},
      );

      reactMap.updateAll((key, value) {
        return value;
      });

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 3);
    },
  );

  // ReactMap.remove

  test(
    'Should Map.remove notify once and actually remove the entry',
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 4},
      );

      reactMap.remove('a');

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 1);
      expect(reactMap.keys.first, 'b');
    },
  );

  test(
    "Should Map.remove don't notify if the entry doesn't exists",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1},
      );

      reactMap.remove('b');

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 1);
      expect(reactMap.keys.first, 'a');
    },
  );

  // ReactMap.removeWhere

  test(
    "Should Map.removeWhere only notify once",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 2, 'c': 3},
      );

      reactMap.removeWhere((key, value) => true);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 0);
    },
  );

  test(
    "Should't Map.removeWhere notify if no elements where removed",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 2, 'c': 3},
      );

      reactMap.removeWhere((key, value) => key == 'f');

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 3);
    },
  );

  // ReactMap.update

  test(
    "Should Map.update trigger once if the value is updated",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 2},
      );

      reactMap.update('a', (value) => value + 1);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 2);
    },
  );

  test(
    "Should't Map.update trigger if the new value is the same as the old value",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1, 'b': 2},
      );

      reactMap.update('a', (value) => value);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 2);
    },
  );

  test(
    "Should Map.update trigger once if the value is updated using ifAbsent property",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1},
      );

      reactMap.update('b', (value) => value, ifAbsent: () => 2);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 2);
    },
  );

  // ReactMap.putIfAbsent

  test(
    "Should ReactMap.putIfAbsent trigger once if the value is updated",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1},
      );

      reactMap.putIfAbsent('b', () => 2);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 1);
      expect(reactMap.length, 2);
    },
  );

  test(
    "Should't ReactMap.putIfAbsent trigger a notify if the value is already defined",
    () {
      final notifyCount = 0.rx;
      final reactMap = createTestMap<String, int>(
        notifyCount,
        {'a': 1},
      );

      reactMap.putIfAbsent('a', () => 2);

      expect(testListener.listenersCount, 0);
      expect(notifyCount.value, 0);
      expect(reactMap.length, 1);
    },
  );

  test('Should ReactMap.length add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.length;
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.value add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.value;
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.isEmpty add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.isEmpty;
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.isNotEmpty add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.isNotEmpty;
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.keys add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.keys.toList();
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.entries add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.entries.toList();
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.values add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.values.toList();
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.containsKey add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    final contains = map.containsKey('a');
    expect(testListener.listenersCount, 1);
    expect(contains, true);
  });

  test('Should ReactMap.containsValue add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    final contains = map.containsValue(1);
    expect(testListener.listenersCount, 1);
    expect(contains, true);
  });

  test('Should ReactMap.forEach add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    map.forEach((_, __) {});
    expect(testListener.listenersCount, 1);
  });

  test('Should ReactMap.forEach add this ReactValue to listeners', () {
    final map = createTestMap<String, int>(null, {'a': 1, 'b': 2, 'c': 3});
    final newMap = map.map((key, value) => MapEntry(key, value * 2));
    expect(testListener.listenersCount, 1);
    expect(newMap.length, map.length);
  });
}
