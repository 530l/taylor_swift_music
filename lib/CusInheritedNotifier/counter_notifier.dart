import 'package:flutter/foundation.dart';

// 1. 创建一个 ChangeNotifier
class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // 当状态改变时，通知监听者
  }
}