// 创建一个InheritedWidget来传递Theme
import 'package:flutter/cupertino.dart';

import 'CusTheme.dart';

class ThemeInheritedWidget extends InheritedWidget {
  // 需要共享的数据
  final CusTheme theme;

  const ThemeInheritedWidget({super.key, required this.theme, required super.child});

  // 定义一个便捷方法，方便子widget获取最近的ThemeInheritedWidget实例
  static ThemeInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();

  // 当InheritedWidget更新时，决定是否通知依赖它的子widget，这里判断theme对象是否改变
  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) => theme != oldWidget.theme;
}