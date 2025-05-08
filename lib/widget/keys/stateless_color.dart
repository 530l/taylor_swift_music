import 'package:flutter/material.dart';

import '../util/UniqueColorGenerator.dart';

class StatelessColor extends StatelessWidget {
  final Color defaultColor = UniqueColorGenerator().getColor();
  final String? flag; // 添加 flag 字段

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Container(
        color: defaultColor,
        child: Align(
          child: Text(flag ?? ""),
        ), // 使用 flag 字段
      ),
    );
  }

  // 修改构造函数以初始化 flag
  StatelessColor({Key? key, this.flag}) : super(key: key);
}
