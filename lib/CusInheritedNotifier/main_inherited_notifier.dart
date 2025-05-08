import 'package:flutter/material.dart';
import 'counter_inherited_notifier.dart';
import 'counter_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CounterNotifier counterNotifier = CounterNotifier();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. 在 Widget 树的顶层或者合适的位置提供 InheritedNotifier
    return CounterInheritedNotifier(
      notifier: counterNotifier,
      child: MaterialApp(
        title: 'InheritedNotifier Example',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 4. 在子 Widget 中获取 Notifier 并监听变化
    final counterNotifier = CounterInheritedNotifier.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedNotifier Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // 当 CounterNotifier 通知更新时，这个 Text Widget 会重建
            Text(
              '${counterNotifier?.count}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterNotifier?.increment, // 调用 Notifier 的方法
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}