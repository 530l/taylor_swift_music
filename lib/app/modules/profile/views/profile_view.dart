import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = '泰勒·斯威夫特';
    final userEmail = 'taylor@swift.com';

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 顶部渐变背景，建议高度180，既有层次感又不会太占空间
          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // 内容区
          Column(
            children: [
              const SizedBox(height: 40), // 头像与顶部的距离，保证头像悬浮效果
              // 头像悬浮，带白色描边和阴影，提升层次感
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=47',
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              // 卡片区域
              Expanded(
                child: Container(
                  width: double.infinity,
                  // margin底部设置为26，避免卡片和底部菜单贴合，视觉更舒适
                  margin: const EdgeInsets.fromLTRB(16, 24, 16, 26),
                  // 卡片内边距，保证内容不拥挤
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 昵称，居中显示
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // 邮箱，居中显示
                      Text(
                        userEmail,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 菜单项，使用ListView保证内容多时可滚动
                      Expanded(
                        child: ListView(
                          children: [
                            _buildProfileItem(
                              icon: Icons.favorite,
                              title: '我的收藏',
                              onTap: () {},
                            ),
                            _buildProfileItem(
                              icon: Icons.settings,
                              title: '设置',
                              onTap: () {},
                            ),
                            _buildProfileItem(
                              icon: Icons.language,
                              title: '语言',
                              onTap: () {},
                            ),
                            _buildProfileItem(
                              icon: Icons.logout,
                              title: '退出登录',
                              onTap: () {},
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建个人中心菜单项
  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.purple),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color ?? Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    );
  }
}
