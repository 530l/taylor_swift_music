// 使用主题色的StatefulWidget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ThemeInheritedWidget.dart';

class ThemedContainer extends StatefulWidget {
  const ThemedContainer({super.key});

  @override
  State<StatefulWidget> createState() => ThemedContainerState();
}

class ThemedContainerState extends State<ThemedContainer> {
  @override
  Widget build(BuildContext context) {
    // 获取最近的ThemeInheritedWidget
    final theme = ThemeInheritedWidget.of(context)?.theme;

    return Container(
      height: 100,
      width: 100,
      color: theme?.primaryColor ?? Colors.white, // 使用InheritedWidget提供的颜色
    );
  }

  bool _didChangeDependenciesCalled = false;


  /*
  ### didChangeDependencies 首次调用的原因

  didChangeDependencies 方法在 StatefulWidget 的生命周期中，会在以下两个时机被调用：

  1. 首次构建时 ：当 State 对象被创建，并且首次关联到 BuildContext 之后，
     initState 方法执行完毕，紧接着就会调用 didChangeDependencies 。
     这是 State 对象初始化流程的一部分，发生在第一次调用 build 方法之前。

  2. 依赖变化时 ：当 State 对象所依赖的 InheritedWidget 发生变化时，
     框架会再次调用 didChangeDependencies 。

  因此，即使您没有显式地调用 dependOnInheritedWidgetOfExactType (或类似 .of(context) 的方法)，
     didChangeDependencies 也总会在 State 对象首次被创建并添加到 Widget 树时被调用一次 。
     这是 Flutter 框架确保 State 对象有机会在首次构建前执行依赖相关初始化逻辑的标准行为。

  简单来说，首次调用是 StatefulWidget 初始化过程的标准步骤，
  与后续因 InheritedWidget 更新而触发的调用是不同的。

  //todo 意思是如果StatefulWidget依赖了InheritedWidget，首次都会进入didChangeDependencies方法

  //todo 是的，您的理解是正确的。

  //todo 无论 StatefulWidget 是否
          显式 地通过 context.dependOnInheritedWidgetOfExactType (或其封装，如 .of(context) )
           依赖了 InheritedWidget ，它的 didChangeDependencies 方法 总会在首次构建时被调用一次 。

   //todo 这是 Flutter State 对象生命周期的一部分：
  //todo   1. createState() : 创建 State 对象。
  //todo   2. initState() : 执行 State 的初始化逻辑。
  //todo   3. didChangeDependencies() : 首次调用 ，
              允许 State 在第一次构建前执行与 BuildContext 相关的初始化或依赖设置。
  //todo   4. build() : 构建 Widget 界面。
             后续，只有当该 StatefulWidget 显式依赖 的 InheritedWidget 发生变化时，
             didChangeDependencies 才会被再次调用。

*/
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didChangeDependenciesCalled) {
      print("ThemedContainer: didChangeDependencies() - Initial call");
      _didChangeDependenciesCalled = true;
    } else {
      print(
          "ThemedContainer: didChangeDependencies() - Called due to dependency change");
    }
    print(
        "~~~~~~~~~~~~~~~~~~~didChangeDependencies() is Called in ThemedContainer");
  }
}
