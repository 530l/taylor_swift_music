# Taylor Swift Music App

一个使用Flutter开发的Taylor Swift音乐展示应用。

## 项目说明

这个项目使用Flutter框架开发，采用GetX状态管理，展示Taylor Swift的音乐列表，支持搜索和排序功能。

## 环境要求

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0
- iOS开发环境（用于iOS构建）
- Android开发环境（用于Android构建）

## 开始使用

1. **克隆项目**
```bash
git clone https://github.com/530l/taylor_swift_music.git
cd flutterdemo
```

2. **安装依赖**
```bash
# 获取项目依赖
flutter pub get

# 如果出现网络问题，可以使用国内镜像
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get
```

3. **运行项目**
```bash
# 运行开发版本
flutter run

# 指定设备运行
flutter devices  # 查看可用设备
flutter run -d [设备ID]

# 运行发布版本
flutter run --release
```

4. **构建应用**
```bash
# 构建Android APK
flutter build apk

# 构建Android App Bundle
flutter build appbundle

# 构建iOS
flutter build ios

# 构建Web版本
flutter build web
```

## 项目结构

```
lib/
  ├── app/
  │   ├── data/
  │   │   └── models/          # 数据模型
  │   ├── modules/
  │   │   └── home/           # 主页模块
  │   ├── routes/             # 路由配置
  │   └── widgets/            # 公共组件
  └── main.dart               # 入口文件
```

## 开发命令

```bash
# 清理项目
flutter clean

# 获取依赖
flutter pub get

# 运行测试
flutter test

# 生成代码
flutter pub run build_runner build

# 持续生成代码
flutter pub run build_runner watch

# 更新图标
flutter pub run flutter_launcher_icons

# 更新启动页
flutter pub run flutter_native_splash:create
```

## 常见问题

1. **依赖安装失败**
```bash
# 清理缓存后重试
flutter clean
flutter pub cache repair
flutter pub get
```

2. **编译错误**
```bash
# 清理项目并重新构建
flutter clean
flutter pub get
flutter run
```

3. **模拟器/设备未识别**
```bash
# 检查设备连接
flutter doctor
flutter devices
```

## 发布流程

1. **版本号更新**
- 修改`pubspec.yaml`中的版本号
```yaml
version: 1.0.0+1
```

2. **Android发布**
```bash
# 生成签名密钥
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

# 构建发布版本
flutter build apk --release
```

3. **iOS发布**
```bash
# 构建发布版本
flutter build ios --release

# 使用Xcode打开并发布
open ios/Runner.xcworkspace
```

## 技术栈

- Flutter
- GetX (状态管理)
- Dio (网络请求)
- cached_network_image (图片缓存)
- shimmer (加载动画)
- pull_to_refresh(刷新)
