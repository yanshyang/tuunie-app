// 团团 Tuunie · P1 家庭日历
// 今日 3 件 + 即将 3 张 + 周/月切换 + FAB
import 'package:flutter/material.dart';
import '../theme.dart';
import '../i18n/i18n.dart';
import '../services/api.dart';

class CalendarScreen extends StatefulWidget {
  final String? familyId;
  const CalendarScreen({super.key, this.familyId});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List events = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

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
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [TuunieColors.primary, TuunieColors.lemon]),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('6月9日 · 周二',
                style: const TextStyle(color: Colors.white, fontFamily: 'Fredoka', fontSize: 24, fontWeight: FontWeight.w700)),
              const Text('📍 新加坡 · 晴天 · 30°C', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 10),
              const Wrap(spacing: 8, children: [
                _Tag(text: '🍜 家庭聚餐 18:00', color: Colors.white),
                _Tag(text: '🏥 妈复查 · 周日', color: Colors.white),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(t(context, 'this_week'), style: const TextStyle(fontFamily: 'Fredoka', fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Row(
          children: List.generate(7, (i) {
            final day = 9 + i;
            return Expanded(child: _DayCell(day: day, hasEvent: i == 0 || i == 5 || i == 6, isToday: i == 0));
          }),
        ),
        const SizedBox(height: 16),
        Text(t(context, 'upcoming'), style: const TextStyle(fontFamily: 'Fredoka', fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        if (loading) const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
        else ...events.map((e) => _EventCard(event: e)).toList(),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String text; final Color color;
  const _Tag({required this.text, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: color.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
    child: Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
  );
}

class _DayCell extends StatelessWidget {
  final int day; final bool hasEvent; final bool isToday;
  const _DayCell({required this.day, required this.hasEvent, required this.isToday});
  @override
  Widget build(BuildContext context) {
    const days = ['一','二','三','四','五','六','日'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isToday ? TuunieColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: TuunieColors.shadow.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$day', style: TextStyle(fontWeight: FontWeight.w700, color: isToday ? Colors.white : TuunieColors.text, fontSize: 14)),
          Text(days[day - 9], style: TextStyle(color: isToday ? Colors.white70 : TuunieColors.text2, fontSize: 9)),
          if (hasEvent) Container(
            margin: const EdgeInsets.only(top: 4),
            width: 6, height: 6,
            decoration: BoxDecoration(color: isToday ? Colors.white : TuunieColors.primary, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  const _EventCard({required this.event});

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
      child: Row(
        children: [
          SizedBox(
            width: 6, height: 40,
            child: Container(decoration: BoxDecoration(color: _ribbonColor, borderRadius: BorderRadius.circular(3))),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            child: Column(
              children: [
                Text(day, style: const TextStyle(fontFamily: 'Fredoka', fontSize: 22, fontWeight: FontWeight.w700)),
                Text(month, style: const TextStyle(color: TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                if (!isPrivate) Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text('${event['event_time'] ?? ''} · ${event['location'] ?? ''}',
                    style: const TextStyle(color: TuunieColors.text2, fontSize: 11)),
                ),
              ],
            ),
          ),
          if (isPrivate) const Text('🔒', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
