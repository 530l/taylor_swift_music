import 'package:flutter/material.dart';
import 'counter_notifier.dart';

// 2. 创建一个 InheritedNotifier
class CounterInheritedNotifier extends InheritedNotifier<CounterNotifier> {
  const CounterInheritedNotifier({
    super.key,
    required CounterNotifier notifier,
    required super.child,
  }) : super(notifier: notifier);

  // 提供一个静态方法方便子 Widget 访问 CounterNotifier
  static CounterNotifier? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedNotifier>()
        ?.notifier;
  }
}
///### InheritedNotifier 详解
// InheritedNotifier 是 Flutter 框架中一个非常有用的类，
// 它结合了 InheritedWidget 和 Listenable (例如 ChangeNotifier ) 的优点，
// 专门用于高效地将 Listenable 对象的变化通知给子树中依赖它的 Widget。

//  核心作用
// 1. 数据传递 : 像 InheritedWidget 一样，它允许子树中的 Widget 访问祖先节点提供的 Listenable 对象。

// 2. 高效更新 : 当 Listenable 对象发出变更通知时（调用 notifyListeners() ），
//    InheritedNotifier 会自动触发依赖它的子 Widget 进行重建，而不需要手动实现 updateShouldNotify 的比较逻辑。
//    工作原理
// - InheritedNotifier 继承自 InheritedWidget ，因此它利用了 InheritedWidget 的依赖收集机制。
//    当子 Widget 通过 context.dependOnInheritedWidgetOfExactType<MyInheritedNotifier>()
//    或类似的 of(context) 方法访问它时，就会建立依赖关系。

// - InheritedNotifier 内部持有一个 Listenable 对象（在构造函数中传入）。
// - 它会自动监听这个 Listenable 对象。当 Listenable 调用 notifyListeners() 时， InheritedNotifier 会被通知。
// - 收到通知后， InheritedNotifier 会标记自己需要重建，
//   并触发所有依赖它的子 Widget 的 didChangeDependencies 方法，进而导致这些子 Widget 重建。
//
//   与 InheritedWidget 的区别
// - 简化 : 对于基于 Listenable 的状态管理， InheritedNotifier 极大地简化了 InheritedWidget 的使用。
//  你不需要再手动实现 updateShouldNotify 来比较新旧 Listenable 对象或其内部状态，
//  InheritedNotifier 已经为你处理好了监听和通知的逻辑。

// - 专注 : 它专注于 Listenable 对象的场景。 使用场景
// 当你需要将一个 ChangeNotifier 或其他 Listenable 对象的状态共享给子树，
// 并且希望在状态变化时自动更新相关 UI 时， InheritedNotifier 是一个非常合适的选择。
// 它是 provider 包中 ChangeNotifierProvider 等类似组件的底层实现基础之一。