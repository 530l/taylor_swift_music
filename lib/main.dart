import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/views/home_view.dart';
import 'app/modules/main_tab/views/main_tab_view.dart';

void main() {
  runApp(
    RefreshConfiguration(
      headerBuilder: () => const MaterialClassicHeader(
        color: Colors.blue,
        backgroundColor: Colors.white,
      ),
      footerBuilder: () => const ClassicFooter(
        loadingText: "加载中...",
        canLoadingText: "松开加载更多",
        idleText: "上拉加载",
        noDataText: "没有更多数据了",
        textStyle: TextStyle(color: Colors.blue),
      ),
      child: GetMaterialApp(
        title: 'Taylor Swift 音乐',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        initialBinding: HomeBinding(),
        home: const MainTabView(),
      ),
    ),
  );
}
