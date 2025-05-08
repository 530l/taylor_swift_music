import 'package:flutter/material.dart';
import 'CusTheme.dart';
import 'ThemeInheritedWidget.dart';
import 'ThemedContainer.dart';
import 'ThemedText.dart';

void main() {
  runApp(MyApp());
}

// 调用处
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CusTheme _theme = CusTheme(primaryColor: Colors.blue);

  void _changeTheme() {
    setState(() {
      _theme = CusTheme(
          primaryColor:
              _theme.primaryColor == Colors.blue ? Colors.red : Colors.blue);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用ThemeInheritedWidget包裹MaterialApp，提供主题数据
    return ThemeInheritedWidget(
      key: const ValueKey("ThemeInheritedWidget"),
      theme: _theme,
      child: MaterialApp(
        title: 'InheritedWidget Example',
        home: Scaffold(
          appBar: AppBar(
            title: Text('InheritedWidget Example'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 使用继承的主题颜色
                ThemedContainer(),
                // 另一个使用继承的主题颜色的widget
                ThemedText(),
                ElevatedButton(
                  onPressed: _changeTheme,
                  child: Text('Change Theme'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
