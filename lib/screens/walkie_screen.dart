// 团团 Tuunie · P3 家庭对讲机
// 重要修改：PTT 按钮下移到 y=760 (底部 1/3, 拇指自然落点)
import 'package:flutter/material.dart';
import '../theme.dart';
import '../i18n/i18n.dart';
import '../services/agora_service.dart';

class WalkieScreen extends StatefulWidget {
  const WalkieScreen({super.key});
  @override
  State<WalkieScreen> createState() => _WalkieScreenState();
}

class _WalkieScreenState extends State<WalkieScreen> {
  int _selectedChannel = 1;  // 0=早安, 1=家庭, 2=SOS
  bool _pttPressed = false;
  String? _joinedChannel;

  @override
  void initState() {
    super.initState();
    _joinChannel('family');
  }

  Future<void> _joinChannel(String ch) async {
    if (_joinedChannel == ch) return;
    if (_joinedChannel != null) await TuunieAgora.leaveChannel();
    await TuunieAgora.joinChannel(ch);
    setState(() => _joinedChannel = ch);
  }

  Future<void> _onPttDown() async {
    setState(() => _pttPressed = true);
    await TuunieAgora.setMute(false);
  }

  Future<void> _onPttUp() async {
    setState(() => _pttPressed = false);
    await TuunieAgora.setMute(true);
    // 发送语音消息 (这里可以加上传到后端)
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🎙️ 语音已发送'), duration: Duration(seconds: 1)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = TuunieI18n.t;
    return Stack(
      children: [
        // 顶部状态
        Positioned(
          top: 8, left: 16, right: 16,
          child: Row(
            children: [
              Container(
                width: 30, height: 30,
                decoration: const BoxDecoration(color: TuunieColors.mint, shape: BoxShape.circle),
                child: const Center(child: Text('🟢', style: TextStyle(fontSize: 14))),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('4 ${t(context, 'online')}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                    const Text('妈 · 爸 · 弟 · 爷', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: TuunieColors.mint, borderRadius: BorderRadius.circular(10)),
                child: const Text('新加坡 · SG', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        // 频道标题 (中上)
        const Positioned(
          top: 60, left: 0, right: 0,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text('家庭频道', style: TextStyle(fontFamily: 'Fredoka', fontSize: 22, fontWeight: FontWeight.w700)),
                  Text('长按下面大按钮说话', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        // 中段装饰：头像云
        const Positioned(
          top: 140, left: 0, right: 0,
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              children: [
                _AvatarBubble(emoji: '👩', bg: TuunieColors.primary),
                _AvatarBubble(emoji: '👨', bg: TuunieColors.mint),
                _AvatarBubble(emoji: '👦', bg: TuunieColors.lavender),
                _AvatarBubble(emoji: '👴', bg: TuunieColors.sky),
                _AvatarBubble(emoji: '👵', bg: TuunieColors.lemon),
              ],
            ),
          ),
        ),
        // 频道条 (PTT 上方 y=380)
        Positioned(
          top: 200, left: 16, right: 16,
          child: Row(
            children: [
              _ChannelChip(emoji: '☀️', name: t(context, 'morning_channel'), selected: _selectedChannel == 0, onTap: () { setState(() => _selectedChannel = 0); _joinChannel('morning'); }),
              const SizedBox(width: 8),
              _ChannelChip(emoji: '🏠', name: t(context, 'home_channel'), selected: _selectedChannel == 1, onTap: () { setState(() => _selectedChannel = 1); _joinChannel('family'); }),
              const SizedBox(width: 8),
              _ChannelChip(emoji: '🆘', name: t(context, 'sos_channel'), selected: _selectedChannel == 2, onTap: () { setState(() => _selectedChannel = 2); _joinChannel('sos'); }),
            ],
          ),
        ),
        // PTT 状态文字
        const Positioned(
          top: 295, left: 0, right: 0,
          child: Center(
            child: Text('按住说话 · 松开发送',
              style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w700)),
          ),
        ),
        // 大红 PTT 按钮 (y=320 屏幕底部 1/3, 拇指自然落点)
        Positioned(
          bottom: 90, left: 0, right: 0,
          child: Center(
            child: GestureDetector(
              onTapDown: (_) => _onPttDown(),
              onTapUp: (_) => _onPttUp(),
              onTapCancel: _onPttUp,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 180, height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _pttPressed
                      ? [const Color(0xFFFF5252), const Color(0xFFFF6B6B)]
                      : [const Color(0xFFFF8A80), TuunieColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(color: TuunieColors.primaryDark.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 16)),
                    const BoxShadow(color: Color(0x33000000), blurRadius: 20, offset: Offset(0, -8)),
                  ],
                ),
                transform: _pttPressed ? (Matrix4.identity()..scale(0.96)) : Matrix4.identity(),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🎙️', style: TextStyle(fontSize: 56)),
                    SizedBox(height: 8),
                    Text('按住说话', style: TextStyle(color: Colors.white, fontFamily: 'Fredoka', fontSize: 18, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ),
        // 底部：SOS + 最近消息
        Positioned(
          bottom: 10, left: 16, right: 16,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _joinChannel('sos'),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFFFE0E0), borderRadius: BorderRadius.circular(18)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('🆘 SOS', style: TextStyle(color: Color(0xFFD32F2F), fontSize: 13, fontWeight: FontWeight.w700)),
                        Text('紧急呼叫全家', style: TextStyle(color: Color(0xFFD32F2F), fontSize: 10, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: softShadow),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('💬 最近', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                      Text('妈：今天汤好喝', style: TextStyle(color: TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarBubble extends StatelessWidget {
  final String emoji; final Color bg;
  const _AvatarBubble({required this.emoji, required this.bg});
  @override
  Widget build(BuildContext context) => Container(
    width: 36, height: 36,
    decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
    child: Center(child: Text(emoji, style: const TextStyle(fontSize: 18))),
  );
}

class _ChannelChip extends StatelessWidget {
  final String emoji; final String name; final bool selected; final VoidCallback onTap;
  const _ChannelChip({required this.emoji, required this.name, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: selected ? TuunieColors.primary : Colors.transparent, width: 3),
          boxShadow: softShadow,
        ),
        child: Column(children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 2),
          Text(name, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ]),
      ),
    ),
  );
}
