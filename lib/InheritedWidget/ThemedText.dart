// 使用主题色的StatelessWidget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ThemeInheritedWidget.dart';

class ThemedText extends StatelessWidget {
  const ThemedText({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取最近的ThemeInheritedWidget
    final theme = ThemeInheritedWidget.of(context)?.theme;

    return Text(
      'This text is themed s',
      style: TextStyle(color: theme?.primaryColor ?? Colors.black),
    );
  }


}