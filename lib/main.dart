// 团团 Tuunie · 主入口
// 启动 → 启动屏 (检查登录态) → 登录 / 主界面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'i18n/i18n.dart';
import 'theme.dart';
import 'screens/splash_gate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const TuunieApp());
}

class TuunieApp extends StatelessWidget {
  const TuunieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '团团 Tuunie',
      debugShowCheckedModeBanner: false,
      theme: TuunieTheme.light,
      home: const SplashGate(),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        TuunieLocalizationsDelegate(),
      ],
      supportedLocales: const [Locale('zh', 'CN'), Locale('zh', 'TW'), Locale('en', 'US')],
    );
  }
}
