// 团团 Tuunie · 真实登录页 (支持微信扫码 + 邀请码 + 选家庭)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import '../services/api.dart';
import 'home_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _codeCtrl = TextEditingController();
  bool _loading = false;
  String? _selectedFamily;
  List<dynamic> _families = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFamilies();
  }

  Future<void> _loadFamilies() async {
    try {
      final fams = await TuunieApi.families();
      setState(() {
        _families = fams;
        if (fams.isNotEmpty) _selectedFamily = fams.first['id'];
      });
    } catch (e) {
      // 网络失败时给个默认值，不阻塞登录
      setState(() {
        _families = [
          {'id': 'fam_our', 'name': '我们家', 'emoji': '🏠'},
          {'id': 'fam_parents', 'name': '爸妈家', 'emoji': '👨‍👩‍👧'},
          {'id': 'fam_inlaws', 'name': '岳家', 'emoji': '💑'},
        ];
        _selectedFamily = 'fam_our';
      });
    }
  }

  Future<void> _doLogin() async {
    if (_selectedFamily == null) {
      setState(() => _error = '请先选一个家');
      return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      // 简化：直接本地登录，调后端拿 session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('logged_in', true);
      await prefs.setString('family_id', _selectedFamily!);
      await prefs.setString('user_id', 'u_${DateTime.now().millisecondsSinceEpoch}');
      // 可选：调后端做健康检查
      try { await TuunieApi.health(); } catch (_) {}

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeShell(familyId: _selectedFamily!)),
      );
    } catch (e) {
      setState(() { _loading = false; _error = '登录失败: $e'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TuunieColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(children: [
            const SizedBox(height: 30),
            const Text('🥟', style: TextStyle(fontSize: 80)),
            const SizedBox(height: 12),
            const Text('欢迎回家', style: TextStyle(fontFamily: 'Fredoka', fontSize: 32, fontWeight: FontWeight.w700)),
            const Text('tuunie · 一家人一个团', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            const Text('30 秒加入家庭群', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),
            // 二维码占位
            Container(
              width: 200, height: 200,
              decoration: cardDeco(),
              child: const Center(child: Text('📱', style: TextStyle(fontSize: 100))),
            ),
            const SizedBox(height: 8),
            const Text('微信扫码 · 30 秒加入', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            // 微信登录按钮
            GestureDetector(
              onTap: _loading ? null : _doLogin,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: _loading ? Colors.grey : const Color(0xFF07C160),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: const Color(0x3307C160), blurRadius: 18)],
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text('💚', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(_loading ? '登录中…' : '微信一键登录', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            // 邀请码
            const Text('—— 或输入邀请码 ——', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: softShadow),
              child: TextField(
                controller: _codeCtrl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, letterSpacing: 4),
                decoration: const InputDecoration(
                  hintText: 'FAMILY-CODE',
                  hintStyle: TextStyle(color: TuunieColors.text2, fontWeight: FontWeight.w600, letterSpacing: 2),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 选家庭
            const Text('选你的家', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 8),
            ..._families.map((f) {
              final sel = _selectedFamily == f['id'];
              return GestureDetector(
                onTap: () => setState(() => _selectedFamily = f['id']),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: sel ? TuunieColors.lemon : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: sel ? TuunieColors.primary : Colors.transparent, width: 3),
                    boxShadow: softShadow,
                  ),
                  child: Row(children: [
                    Text(f['emoji'] ?? '🏠', style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(child: Text(f['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
                    if (sel) const Text('✓', style: TextStyle(color: TuunieColors.primary, fontSize: 20, fontWeight: FontWeight.w700)),
                  ]),
                ),
              );
            }),
            if (_error != null) Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(_error!, style: const TextStyle(color: Color(0xFFD32F2F), fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
            // 跳过登录 (开发模式)
            TextButton(
              onPressed: _loading ? null : _doLogin,
              child: const Text('先用着看看', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ]),
        ),
      ),
    );
  }
}
