// 团团 Tuunie · 主界面 Shell (5 Tab 底部导航)
import 'package:flutter/material.dart';
import '../i18n/i18n.dart';
import '../theme.dart';
import 'calendar_screen.dart';
import 'walkie_screen.dart';
import 'benbon_screen.dart';
import 'other_screens.dart';

class HomeShell extends StatefulWidget {
  final String familyId;
  const HomeShell({super.key, required this.familyId});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _idx = 0;

  List<Widget> get _pages => [
    CalendarScreen(familyId: widget.familyId),
    const FeedScreen(),
    const WalkieScreen(),
    const IceScreen(),
    BenbonScreen(familyId: widget.familyId),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(children: [
          IndexedStack(index: _idx, children: _pages),
          if (_idx == 1 || _idx == 4) Positioned(
            bottom: 92, right: 20,
            child: GestureDetector(
              child: Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: TuunieColors.primary, shape: BoxShape.circle, boxShadow: [BoxShadow(color: TuunieColors.shadow.withOpacity(0.6), blurRadius: 20, offset: const Offset(0, 8))]),
                child: const Center(child: Text('+', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w700))),
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        height: 78,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0x40E8D4B8), blurRadius: 20, offset: Offset(0, -4))], borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        child: Builder(builder: (ctx) => Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _Tab(icon: '🏠', label: TuunieI18n.t(ctx, 'tab_calendar'), idx: 0, current: _idx, onTap: () => setState(() => _idx = 0)),
          _Tab(icon: '📢', label: TuunieI18n.t(ctx, 'tab_feed'), idx: 1, current: _idx, onTap: () => setState(() => _idx = 1)),
          _Tab(icon: '📻', label: TuunieI18n.t(ctx, 'tab_walkie'), idx: 2, current: _idx, onTap: () => setState(() => _idx = 2)),
          _Tab(icon: '🐾', label: TuunieI18n.t(ctx, 'tab_ice'), idx: 3, current: _idx, onTap: () => setState(() => _idx = 3)),
          _Tab(icon: '📒', label: TuunieI18n.t(ctx, 'tab_benbon'), idx: 4, current: _idx, onTap: () => setState(() => _idx = 4)),
        ])),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String icon, label; final int idx, current; final VoidCallback onTap;
  const _Tab({required this.icon, required this.label, required this.idx, required this.current, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final active = idx == current;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(icon, style: TextStyle(fontSize: active ? 26 : 22)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: active ? TuunieColors.primary : TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w700)),
        ]),
      ),
    );
  }
}
