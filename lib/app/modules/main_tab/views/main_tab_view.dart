import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_view.dart';
import '../../music/views/music_view.dart';
import '../../community/views/community_view.dart';
import '../../profile/views/profile_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _currentIndex = 0;
  final List<Widget?> _pages = [null, null, null, null];

  Widget _getPage(int index) {
    if (_pages[index] == null) {
      switch (index) {
        case 0:
          _pages[index] = const HomeView();
          break;
        case 1:
          _pages[index] = const MusicView();
          break;
        case 2:
          _pages[index] = const CommunityView();
          break;
        case 3:
          _pages[index] = const ProfileView();
          break;
      }
    }
    return _pages[index]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AutomaticKeepAliveClientMixin 主要用于TabBarView、PageView等“滑动切换”场景，防止页面被销毁。
      // 对于你现在用的 IndexedStack，其实不需要用 AutomaticKeepAliveClientMixin，
      // 因为 IndexedStack 本身就会把所有子页面都保留在内存中，不会销毁页面，状态天然保留。

      // 什么时候需要用 AutomaticKeepAliveClientMixin？
      // 你用 TabBarView、PageView 这类懒加载+滑动切换的容器时，未显示的页面会被销毁（dispose），
      // 这时你需要让页面实现 AutomaticKeepAliveClientMixin，并重写 wantKeepAlive => true，这样页面才会被保留。
      // 但IndexedStack 不会销毁页面，所以不需要用这个 mixin。
      body: IndexedStack(
        index: _currentIndex,
        children: List.generate(4, (i) => _getPage(i)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_music), label: '音乐库'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '社区'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
