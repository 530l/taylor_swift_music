import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/modules/home/views/home_view.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Taylor Swift 音乐',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialBinding: HomeBinding(),
      home: const HomeView(),
    ),
  );
}
