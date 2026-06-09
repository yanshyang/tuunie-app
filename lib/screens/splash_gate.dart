// 团团 Tuunie · 启动 + 登录 + 路由
// 启动屏 → 检查登录态 → 登录页/主界面
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/other_screens.dart';
import 'home_shell.dart';

class SplashGate extends StatefulWidget {
  const SplashGate({super.key});
  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    // 显示启动屏 1.5s
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    // 检查登录态
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('logged_in') ?? false;
    final familyId = prefs.getString('family_id') ?? 'fam_our';

    if (!mounted) return;
    if (loggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeShell(familyId: familyId)),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) => const SplashScreen();
}
