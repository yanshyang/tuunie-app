// 团团 Tuunie · P12 团本本
// 月/周视图切换 + 三色归属色条 + 私密 🔒
import 'package:flutter/material.dart';
import '../theme.dart';
import '../i18n/i18n.dart';
import '../services/api.dart';

class BenbonScreen extends StatefulWidget {
  final String? familyId;
  const BenbonScreen({super.key, this.familyId});
  @override
  State<BenbonScreen> createState() => _BenbonScreenState();
}

class _BenbonScreenState extends State<BenbonScreen> {
  String _view = 'month';  // week / month
  List events = [];
  bool loading = true;
  int _year = 2026, _month = 6;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    try {
      final data = await TuunieApi.benbon(familyId: widget.familyId ?? 'fam_our');
      setState(() { events = data; loading = false; });
    } catch (e) {
      setState(() { loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = TuunieI18n.t;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('团本本', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: TuunieColors.mint, borderRadius: BorderRadius.circular(12)),
              child: Text('${_month}月', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        Text('家事 + 公开私事 · ${_view == 'month' ? t(context, 'view_month') : t(context, 'view_week')} 视图',
          style: const TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        // 视图切换 + 翻页
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: softShadow),
              child: Row(children: [
                _PillBtn(label: t(context, 'view_week'), selected: _view == 'week', onTap: () => setState(() => _view = 'week')),
                _PillBtn(label: t(context, 'view_month'), selected: _view == 'month', onTap: () => setState(() => _view = 'month')),
              ]),
            ),
            const Spacer(),
            _NavBtn(icon: '‹', onTap: () => setState(() => _month = _month == 1 ? (_year--, 12) : _month - 1)),
            const SizedBox(width: 6),
            Text('$_year.$_month', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(width: 6),
            _NavBtn(icon: '›', onTap: () => setState(() => _month = _month == 12 ? (_year++, 1) : _month + 1)),
          ],
        ),
        const SizedBox(height: 12),
        if (_view == 'month') _MonthGrid(year: _year, month: _month, events: events) else _WeekRow(events: events),
        const SizedBox(height: 10),
        // 图例
        Wrap(spacing: 12, children: [
          _LegendDot(color: TuunieColors.primary, label: t(context, 'family_affair')),
          _LegendDot(color: TuunieColors.sky, label: t(context, 'personal_public')),
          _LegendDot(color: TuunieColors.text2, label: t(context, 'personal_private')),
        ]),
        const SizedBox(height: 14),
        if (loading) const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
        else ...events.map((e) => _BenbonEventCard(event: e)).toList(),
      ],
    );
  }
}

class _PillBtn extends StatelessWidget {
  final String label; final bool selected; final VoidCallback onTap;
  const _PillBtn({required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? TuunieColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: TextStyle(color: selected ? Colors.white : TuunieColors.text2, fontWeight: FontWeight.w700, fontSize: 13)),
    ),
  );
}

class _NavBtn extends StatelessWidget {
  final String icon; final VoidCallback onTap;
  const _NavBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 32, height: 32,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: TuunieColors.shadow.withOpacity(0.3), blurRadius: 6)]),
      child: Center(child: Text(icon, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
    ),
  );
}

class _LegendDot extends StatelessWidget {
  final Color color; final String label;
  const _LegendDot({required this.color, required this.label});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    const SizedBox(width: 4),
    Text(label, style: const TextStyle(color: TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w700)),
  ]);
}

class _MonthGrid extends StatelessWidget {
  final int year, month; final List events;
  const _MonthGrid({required this.year, required this.month, required this.events});

  @override
  Widget build(BuildContext context) {
    const days = ['一','二','三','四','五','六','日'];
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDay = DateTime(year, month, 1);
    // 周一开始
    final firstDow = (firstDay.weekday - 1) % 7;
    final totalCells = ((firstDow + daysInMonth + 6) ~/ 7) * 7;

    // 每天的事件 (按 day 索引)
    final Map<int, List> dayEvents = {};
    for (final e in events) {
      final date = e['event_date'] ?? '';
      final parts = date.split('-');
      if (parts.length == 3 && int.tryParse(parts[1]) == month) {
        final d = int.tryParse(parts[2]) ?? 0;
        dayEvents.putIfAbsent(d, () => []).add(e);
      }
    }

    return Column(children: [
      Row(children: days.map((d) => Expanded(child: Center(child: Text(d, style: const TextStyle(color: TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w700))))).toList()),
      const SizedBox(height: 4),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7, mainAxisSpacing: 3, crossAxisSpacing: 3, childAspectRatio: 1.0),
        itemCount: totalCells,
        itemBuilder: (ctx, i) {
          final day = i - firstDow + 1;
          if (day < 1 || day > daysInMonth) {
            return Container();  // 空白格
          }
          final evs = dayEvents[day] ?? [];
          final isToday = day == 9 && month == 6 && year == 2026;
          return Container(
            decoration: BoxDecoration(
              color: isToday ? TuunieColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$day', style: TextStyle(color: isToday ? Colors.white : TuunieColors.text, fontWeight: FontWeight.w700, fontSize: 13)),
                if (evs.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Wrap(spacing: 2, children: evs.take(3).map((e) {
                    final v = e['visibility'];
                    final c = v == 'private' ? TuunieColors.text2 : v == 'public' ? TuunieColors.sky : TuunieColors.primary;
                    return Container(width: 5, height: 5, decoration: BoxDecoration(color: c, shape: BoxShape.circle));
                  }).toList()),
                ),
              ],
            ),
          );
        },
      ),
    ]);
  }
}

class _WeekRow extends StatelessWidget {
  final List events;
  const _WeekRow({required this.events});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(7, (i) {
        final day = 9 + i;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: i == 0 ? TuunieColors.primary : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(children: [
              Text('$day', style: TextStyle(color: i == 0 ? Colors.white : TuunieColors.text, fontWeight: FontWeight.w700)),
              if (i == 0) const Text('今', style: TextStyle(color: Colors.white70, fontSize: 9)),
            ]),
          ),
        );
      }),
    );
  }
}

class _BenbonEventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  const _BenbonEventCard({required this.event});

  Color get _ribbonColor {
    final v = event['visibility'];
    if (v == 'private') return TuunieColors.text2;
    if (v == 'public') return TuunieColors.sky;
    return TuunieColors.primary;
  }
  Color get _bgColor {
    final v = event['visibility'];
    if (v == 'private') return const Color(0xFFF5F5F5);
    if (v == 'public') return Colors.white;
    return TuunieColors.lemon;
  }

  @override
  Widget build(BuildContext context) {
    final date = event['event_date'] ?? '';
    final parts = date.split('-');
    final day = parts.length == 3 ? parts[2] : '?';
    final month = parts.length == 3 ? '${parts[1]}月' : '';
    final isPrivate = event['visibility'] == 'private';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(20, 12, 14, 12),
      decoration: BoxDecoration(color: _bgColor, borderRadius: BorderRadius.circular(20), boxShadow: softShadow),
      child: Row(children: [
        SizedBox(width: 6, height: 40, child: Container(decoration: BoxDecoration(color: _ribbonColor, borderRadius: BorderRadius.circular(3)))),
        const SizedBox(width: 12),
        Container(width: 48, child: Column(children: [
          Text(day, style: const TextStyle(fontFamily: 'Fredoka', fontSize: 22, fontWeight: FontWeight.w700)),
          Text(month, style: const TextStyle(color: TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w700)),
        ])),
        const SizedBox(width: 8),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(event['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          if (!isPrivate) Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text('${event['event_time'] ?? ''} · ${event['location'] ?? ''}',
              style: const TextStyle(color: TuunieColors.text2, fontSize: 11)),
          ),
        ])),
        if (isPrivate) const Text('🔒', style: TextStyle(fontSize: 18)),
      ]),
    );
  }
}
