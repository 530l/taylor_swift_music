import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/music_controller.dart';

class MusicView extends GetView<MusicController> {
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('音乐库')),
    );
  }
}
