// 团团 Tuunie · P2/P4/P5/P6/P7/P8/P9/P10/P11/P13 通用页面
// 紧凑实现，所有页面用真实可用的 Flutter widgets
import 'package:flutter/material.dart';
import '../theme.dart';
import '../i18n/i18n.dart';
import '../services/api.dart';

// ========== P2 家庭动态 ==========
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final posts = [
      {'who': '👩', 'name': '妈', 'time': '2 小时前', 'text': '今天煮了酸辣汤，味道很棒！😋', 'bg': TuunieColors.primary, 'photos': 3, 'likes': 5, 'cmts': 2},
      {'who': '👦', 'name': '弟弟', 'time': '5 小时前', 'text': '期末考完啦！🎉', 'bg': TuunieColors.mint, 'photos': 0, 'likes': 8, 'cmts': 3},
      {'who': '👨', 'name': '爸', 'time': '昨天', 'text': '老朋友聚会，怀念小时候的味道', 'bg': TuunieColors.lavender, 'photos': 2, 'likes': 6, 'cmts': 1},
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        const Text('家庭动态', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700)),
        const Text('看看家人在做什么', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        ...posts.map((p) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: cardDeco(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: p['bg'] as Color, shape: BoxShape.circle), child: Center(child: Text(p['who'] as String, style: const TextStyle(fontSize: 20)))),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p['name'] as String, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                Text(p['time'] as String, style: const TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
              ]),
            ]),
            const SizedBox(height: 8),
            Text(p['text'] as String, style: const TextStyle(fontSize: 14, height: 1.5)),
            if ((p['photos'] as int) > 0) ...[
              const SizedBox(height: 8),
              GridView.count(
                shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 6,
                children: List.generate(p['photos'] as int, (i) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [TuunieColors.lemon, TuunieColors.primary]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )),
              ),
            ],
            const SizedBox(height: 10),
            Row(children: [
              Text('❤️ ${p['likes']}', style: const TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w700)),
              const SizedBox(width: 14),
              Text('💬 ${p['cmts']}', style: const TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w700)),
              const SizedBox(width: 14),
              const Text('↗ 分享', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w700)),
            ]),
          ]),
        )),
      ],
    );
  }
}

// ========== P5 破冰小机关 ==========
class IceScreen extends StatelessWidget {
  const IceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final t = TuunieI18n.t;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        const Text('破冰小机关', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700)),
        const Text('不爱说话？让小东西先开口', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        // 团子宠物
        Container(
          padding: const EdgeInsets.all(18),
          decoration: cardDeco(bg: TuunieColors.lemon),
          child: Column(children: [
            Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: softShadow),
              child: const Center(child: Text('🥟', style: TextStyle(fontSize: 50)))),
            const SizedBox(height: 8),
            Text(t(context, 'pet_level'), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const Text('连续打卡 5 天 · 距 Lv 4 还差 2 天', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            const Wrap(spacing: 6, alignment: WrapAlignment.center, children: [
              _MiniTag(text: '💪 已早起 3 次', bg: TuunieColors.primary, fg: Colors.white),
              _MiniTag(text: '🍜 打卡 2 次', bg: TuunieColors.mint, fg: TuunieColors.text),
            ]),
            const SizedBox(height: 10),
            Text(t(context, 'pet_says'), style: const TextStyle(color: TuunieColors.text2, fontSize: 13, fontStyle: FontStyle.italic)),
          ]),
        ),
        const SizedBox(height: 12),
        // 心情树洞
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDeco(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('🌳 心情树洞', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: TuunieColors.lavender, borderRadius: BorderRadius.circular(10)),
                child: const Text('3 颗', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
            ]),
            const SizedBox(height: 8),
            Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: TuunieColors.bg, borderRadius: BorderRadius.circular(18)),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('匿名 · 1小时前', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text('今天有点累，想家了'),
              ])),
            const SizedBox(height: 8),
            const Row(children: [
              _MiniTag(text: '🍵 抱抱', bg: TuunieColors.mint, fg: TuunieColors.text),
              SizedBox(width: 6),
              _MiniTag(text: '☕ 喝茶', bg: TuunieColors.sky, fg: TuunieColors.text),
            ]),
          ]),
        ),
        const SizedBox(height: 12),
        // 默契小投票
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDeco(),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('🗳️ 默契小投票', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: TuunieColors.primary, borderRadius: BorderRadius.circular(10)),
                child: const Text('今天问', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
            ]),
            const SizedBox(height: 8),
            const Text('今晚吃什么？', style: TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Row(children: const [
              _VoteOpt(text: '🍜 汤面', selected: false),
              SizedBox(width: 8),
              _VoteOpt(text: '🍚 炒饭', selected: true),
              SizedBox(width: 8),
              _VoteOpt(text: '🍕 披萨', selected: false),
            ]),
            const SizedBox(height: 8),
            const Text('3/5 家已投 · 22:00 公布', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w700)),
          ]),
        ),
        const SizedBox(height: 12),
        // 家暗号
        Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDeco(bg: TuunieColors.lavender),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('🔐 家暗号', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
            SizedBox(height: 4),
            Text('还记得我们家的暗号吗？', style: TextStyle(color: Colors.white, fontSize: 13)),
            SizedBox(height: 8),
            Wrap(spacing: 6, children: [
              _MiniTag(text: '小汤圆', bg: Colors.white, fg: TuunieColors.lavender),
              _MiniTag(text: '沙巴夜', bg: Colors.white, fg: TuunieColors.lavender),
            ]),
          ]),
        ),
      ],
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String text; final Color bg; final Color fg;
  const _MiniTag({required this.text, required this.bg, required this.fg});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
    child: Text(text, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700)),
  );
}

class _VoteOpt extends StatelessWidget {
  final String text; final bool selected;
  const _VoteOpt({required this.text, required this.selected});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: selected ? TuunieColors.primary : TuunieColors.lemon, borderRadius: BorderRadius.circular(14)),
      child: Center(child: Text(text, style: TextStyle(color: selected ? Colors.white : TuunieColors.text, fontWeight: FontWeight.w700, fontSize: 13))),
    ),
  );
}

// ========== P4 多家庭切换 (支持长按重命名) ==========
class FamilySwitchScreen extends StatefulWidget {
  const FamilySwitchScreen({super.key});
  @override
  State<FamilySwitchScreen> createState() => _FamilySwitchScreenState();
}

class _FamilySwitchScreenState extends State<FamilySwitchScreen> {
  List<dynamic> _families = [];
  bool _loading = true;

  @override
  void initState() { super.initState(); _load(); }

  Future<void> _load() async {
    try {
      final fams = await TuunieApi.families();
      setState(() { _families = fams; _loading = false; });
    } catch (e) {
      setState(() { _loading = false; });
    }
  }

  Future<void> _renameFamily(Map<String, dynamic> fam) async {
    final ctrl = TextEditingController(text: fam['name'] ?? '');
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(children: [
          Text(fam['emoji'] ?? '🏠', style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
          const Text('重命名家庭', style: TextStyle(fontWeight: FontWeight.w700)),
        ]),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('给你的家起个新名字', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          TextField(
            controller: ctrl,
            autofocus: true,
            maxLength: 16,
            decoration: InputDecoration(
              hintText: '比如：小汤圆家',
              filled: true,
              fillColor: TuunieColors.bg,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await TuunieApi.resetFamilyName(fam['id']);
                if (ctx.mounted) Navigator.pop(ctx, '__reset__');
                _load();
              } catch (e) { /* ignore */ }
            },
            child: const Text('恢复默认', style: TextStyle(color: TuunieColors.text2)),
          ),
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('保存'),
          ),
        ],
      ),
    );
    if (result == null || result.isEmpty || result == '__reset__') return;
    try {
      await TuunieApi.renameFamily(fam['id'], result);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ 家庭名称已更新'), duration: Duration(seconds: 2)),
        );
      }
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ 重命名失败: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
    children: [
      const Text('我的家', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700)),
      const Text('三家不互通 · 一人多身 · 长按重命名', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(height: 14),
      if (_loading) const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))
      else ..._families.map((f) => _FamilyCard(
        emoji: f['emoji'] ?? '🏠',
        name: f['name'] ?? '',
        sub: '${f['id'] == 'fam_our' ? '4 人 · 深圳 + 马来' : f['id'] == 'fam_parents' ? '3 人 · 沙巴' : '2 人 · 槟城'}',
        current: f['id'] == 'fam_our',
        badge: f['id'] == 'fam_our' ? '当前' : '',
        bg: f['id'] == 'fam_our' ? TuunieColors.primary : Colors.white,
        fg: f['id'] == 'fam_our' ? Colors.white : TuunieColors.text,
        isRenamed: f['custom_name'] != null,
        onLongPress: () => _renameFamily(f),
      )),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: cardDeco(bg: TuunieColors.lavender),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('📨 跨家小信箱', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
          SizedBox(height: 4),
          Text('给另一家的私话，写在这里发送', style: TextStyle(color: Colors.white, fontSize: 12)),
          SizedBox(height: 10),
          _MiniTag(text: '+ 写一封', bg: Colors.white, fg: TuunieColors.lavender),
        ]),
      ),
      const SizedBox(height: 8),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text('💡 提示：长按家庭卡片可改名，恢复默认点对话框里的"恢复默认"',
          style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
      ),
    ],
  );
}

class _FamilyCard extends StatelessWidget {
  final String emoji, name, sub, badge; final bool current, isRenamed;
  final Color bg, fg; final VoidCallback onLongPress;
  const _FamilyCard({required this.emoji, required this.name, required this.sub, required this.current, required this.badge, required this.bg, required this.fg, required this.isRenamed, required this.onLongPress});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onLongPress: onLongPress,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: cardDeco(bg: bg),
      child: Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 30)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Flexible(child: Text(name, style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 17), overflow: TextOverflow.ellipsis)),
            if (isRenamed) const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text('✏️', style: TextStyle(fontSize: 14)),
            ),
          ]),
          Text(sub, style: TextStyle(color: current ? Colors.white : TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
        ])),
        if (badge.isNotEmpty) Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: current ? Colors.white24 : TuunieColors.mint, borderRadius: BorderRadius.circular(12)),
          child: Text(badge, style: TextStyle(color: current ? Colors.white : TuunieColors.text, fontSize: 11, fontWeight: FontWeight.w700))),
      ]),
    ),
  );
}

// ========== P6 启动闪屏 ==========
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(gradient: LinearGradient(colors: [TuunieColors.lemon, TuunieColors.primary], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    child: const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text('🥟', style: TextStyle(fontSize: 100)),
      SizedBox(height: 16),
      // 双语品牌名 - 简中 + 英文始终共现
      Text('团团', style: TextStyle(fontFamily: 'Fredoka', fontSize: 48, color: Colors.white, fontWeight: FontWeight.w700)),
      Text('tuunie', style: TextStyle(fontFamily: 'Fredoka', fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 2)),
      SizedBox(height: 6),
      Text('一家人 · 一个团', style: TextStyle(color: Colors.white, fontSize: 14)),
    ])),
  );
}

// ========== P7 登录 ==========
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(20, 40, 20, 100),
    child: Column(children: [
      const SizedBox(height: 40),
      const Text('🥟', style: TextStyle(fontSize: 80)),
      const SizedBox(height: 16),
      const Text('欢迎回家', style: TextStyle(fontFamily: 'Fredoka', fontSize: 32, fontWeight: FontWeight.w700)),
      const Text('微信扫码 · 30 秒加入', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(height: 30),
      Container(width: 200, height: 200, decoration: cardDeco(),
        child: const Center(child: Text('📱', style: TextStyle(fontSize: 100)))),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        decoration: BoxDecoration(color: const Color(0xFF07C160), borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(color: const Color(0x3307C160), blurRadius: 18)]),
        child: const Row(mainAxisSize: MainAxisSize.min, children: [
          Text('💚', style: TextStyle(fontSize: 20)),
          SizedBox(width: 8),
          Text('微信一键登录', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        ]),
      ),
      const SizedBox(height: 20),
      const Text('还没有账号？输入邀请码', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
    ]),
  );
}

// ========== P8 长辈上手卡 ==========
class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
    children: [
      const Text('30 秒就会用', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700)),
      const Text('给爸妈爷爷奶奶的 3 步法', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(height: 14),
      Container(padding: const EdgeInsets.all(18), decoration: cardDeco(bg: TuunieColors.lemon),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('3 步法', style: TextStyle(color: TuunieColors.primary, fontWeight: FontWeight.w700, fontSize: 18)),
          SizedBox(height: 10),
          _GuideStep(num: '1', text: '看 · 家里人在做什么'),
          _GuideStep(num: '2', text: '按 · 按住大红按钮说话'),
          _GuideStep(num: '3', text: '发 · 一键发到家庭群'),
        ])),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(18), decoration: cardDeco(bg: TuunieColors.mint),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('3 个贴士', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          SizedBox(height: 10),
          _GuideStep(num: '💡', text: '点家人头像可单独呼叫'),
          _GuideStep(num: '💡', text: '长按说话，松开就发'),
          _GuideStep(num: '💡', text: '不懂就点右下角"求助"'),
        ])),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(20), decoration: cardDeco(bg: TuunieColors.lavender),
        child: const Column(children: [
          Text('🤝', style: TextStyle(fontSize: 40)),
          SizedBox(height: 6),
          Text('需要帮忙？', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          Text('点这个按钮，小辈会立刻看到', style: TextStyle(color: Colors.white, fontSize: 13)),
          SizedBox(height: 12),
          _MiniTag(text: '🆘 长辈求助', bg: Colors.white, fg: TuunieColors.lavender),
        ])),
    ],
  );
}

class _GuideStep extends StatelessWidget {
  final String num, text;
  const _GuideStep({required this.num, required this.text});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(children: [
      Container(width: 32, height: 32, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(child: Text(num, style: const TextStyle(fontWeight: FontWeight.w700, color: TuunieColors.primary)))),
      const SizedBox(width: 10),
      Text(text, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
    ]),
  );
}

// ========== P9 聊天 ==========
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) => Column(children: [
    Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: TuunieColors.shadow))),
      child: Row(children: [
        Container(width: 36, height: 36, decoration: const BoxDecoration(color: TuunieColors.primary, shape: BoxShape.circle),
          child: const Center(child: Text('👩', style: TextStyle(fontSize: 20)))),
        const SizedBox(width: 12),
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('妈', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          Text('在线 · 沙巴', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
        ]),
      ]),
    ),
    Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _MsgBubble(text: '在吗？今天汤很香 😋', isMe: false),
          _MsgBubble(text: '在！刚下班', isMe: true),
          _MsgBubble(text: '[语音 5"]', isMe: false),
          _MsgBubble(text: '[图片]', isMe: true),
          _MsgBubble(text: '下周六聚餐记得来', isMe: false),
          _MsgBubble(text: '好的妈，几点？', isMe: true),
          _MsgBubble(text: '晚上 6 点，海底捞', isMe: false),
        ],
      ),
    ),
    Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      color: Colors.white,
      child: Row(children: [
        const Text('🎙️', style: TextStyle(fontSize: 22)),
        const SizedBox(width: 8),
        Expanded(child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(color: TuunieColors.bg, borderRadius: BorderRadius.circular(18)),
          child: const Text('说点什么…', style: TextStyle(color: TuunieColors.text2, fontSize: 13)))),
        const Text('😊', style: TextStyle(fontSize: 22)),
        const SizedBox(width: 4),
        const Text('➕', style: TextStyle(fontSize: 22)),
      ]),
    ),
  ]);
}

class _MsgBubble extends StatelessWidget {
  final String text; final bool isMe;
  const _MsgBubble({required this.text, required this.isMe});
  @override
  Widget build(BuildContext context) => Align(
    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 250),
      decoration: BoxDecoration(
        color: isMe ? TuunieColors.primary : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(isMe ? 18 : 6),
          bottomRight: Radius.circular(isMe ? 6 : 18),
        ),
        boxShadow: isMe ? [] : softShadow,
      ),
      child: Text(text, style: TextStyle(color: isMe ? Colors.white : TuunieColors.text, fontSize: 14)),
    ),
  );
}

// ========== P10 家庭相册 ==========
class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
    children: [
      const Text('家庭相册', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700)),
      const Text('1238 张 · 自动按家人+时间分类', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
      const SizedBox(height: 10),
      SizedBox(height: 36,
        child: ListView(scrollDirection: Axis.horizontal, children: const [
          _FilterChip(label: '全部', active: true),
          SizedBox(width: 6),
          _FilterChip(label: '妈'),
          SizedBox(width: 6),
          _FilterChip(label: '爸'),
          SizedBox(width: 6),
          _FilterChip(label: '弟弟'),
          SizedBox(width: 6),
          _FilterChip(label: '爷'),
          SizedBox(width: 6),
          _FilterChip(label: '奶'),
        ])),
      const SizedBox(height: 14),
      const Text('今天 · 6月9日', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      const SizedBox(height: 6),
      GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 6,
        children: List.generate(6, (i) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [TuunieColors.lemon, TuunieColors.primary, TuunieColors.mint, TuunieColors.lavender][i % 4].withOpacity(0.6) is Color ? [TuunieColors.lemon, TuunieColors.primary] : [TuunieColors.mint, TuunieColors.lavender]),
            borderRadius: BorderRadius.circular(14),
          )))),
      const SizedBox(height: 14),
      const Text('上周', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      const SizedBox(height: 6),
      GridView.count(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3, mainAxisSpacing: 6, crossAxisSpacing: 6,
        children: List.generate(4, (i) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: i.isEven ? [TuunieColors.sky, TuunieColors.mint] : [TuunieColors.lemon, TuunieColors.primary]),
            borderRadius: BorderRadius.circular(14),
          )))),
    ],
  );
}

class _FilterChip extends StatelessWidget {
  final String label; final bool active;
  const _FilterChip({required this.label, this.active = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: active ? TuunieColors.primary : Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [BoxShadow(color: TuunieColors.shadow.withOpacity(0.3), blurRadius: 6)],
    ),
    child: Text(label, style: TextStyle(color: active ? Colors.white : TuunieColors.text, fontSize: 12, fontWeight: FontWeight.w700)),
  );
}

// ========== P11 设置 ==========
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _langIdx = 0;
  bool _waHome = true, _waWalkie = false, _dnd = true;
  String _version = '...';
  String _developer = '...';

  @override
  void initState() { super.initState(); _loadVersion(); }

  Future<void> _loadVersion() async {
    try {
      final v = await TuunieApi.version();
      if (mounted) setState(() {
        _version = 'v${v['version']} (build ${v['build']})';
        _developer = v['developer'] ?? 'Tuunie Team';
      });
    } catch (e) { /* ignore */ }
  }

  @override
  Widget build(BuildContext context) {
    final t = TuunieI18n.t;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        const Text('设置', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700)),
        const Text('语言 · 通知 · 隐私', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        const Text('🌐 语言', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 6),
        Row(children: [
          for (var i = 0; i < 3; i++) ...[
            Expanded(child: GestureDetector(
              onTap: () => setState(() => _langIdx = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _langIdx == i ? TuunieColors.lemon : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _langIdx == i ? TuunieColors.primary : Colors.transparent, width: 3),
                  boxShadow: softShadow,
                ),
                child: Center(child: Text(['简体中文', '繁體中文', 'English'][i], style: const TextStyle(fontWeight: FontWeight.w700))),
              ),
            )),
            if (i < 2) const SizedBox(width: 8),
          ],
        ]),
        const SizedBox(height: 14),
        const Text('💬 WhatsApp 同步', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 6),
        _ToggleRow(emoji: '💚', title: t(context, 'wa_sync_home'), sub: '海外家人也能收到', value: _waHome, onChange: (v) => setState(() => _waHome = v)),
        const SizedBox(height: 6),
        _ToggleRow(emoji: '📻', title: t(context, 'wa_sync_walkie'), sub: '让不会用 App 的家人也能听到', value: _waWalkie, onChange: (v) => setState(() => _waWalkie = v)),
        const SizedBox(height: 14),
        const Text('🌙 勿扰', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 6),
        _ToggleRow(emoji: '🌙', title: t(context, 'smart_dnd'), sub: t(context, 'auto_class'), value: _dnd, onChange: (v) => setState(() => _dnd = v)),
        const SizedBox(height: 30),
        // 关于 / 版本 / 开发者信息
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: TuunieColors.bg, borderRadius: BorderRadius.circular(20)),
          child: const Column(children: [
            Text('🀄', style: TextStyle(fontSize: 32)),
            SizedBox(height: 6),
            Text('团团 Tuunie', style: TextStyle(fontFamily: 'Fredoka', fontSize: 18, fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('一家人 · 一个团', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
          ]),
        ),
        const SizedBox(height: 12),
        // 版本号 + 开发者 (不显眼但能查到)
        Center(
          child: Column(children: [
            Text(_version, style: const TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text('Developed 🩷 by $_developer · 2026', style: const TextStyle(color: TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            // 检查更新按钮
            GestureDetector(
              onTap: () async {
                try {
                  final v = await TuunieApi.version();
                  if (!context.mounted) return;
                  final latest = 'v${v['version']} (build ${v['build']})';
                  showDialog(context: context, builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: const Text('更新检查', style: TextStyle(fontWeight: FontWeight.w700)),
                    content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('当前: $_version', style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 6),
                      Text('最新: $latest', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: TuunieColors.primary)),
                      const SizedBox(height: 10),
                      const Text('💡 更新方式：\n• 家人小辈帮你装新版本\n• 或联系开发者 Terence Goh\n• 微信群转 APK 即可', style: TextStyle(color: TuunieColors.text2, fontSize: 12, height: 1.5)),
                    ]),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('好的')),
                    ],
                  ));
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('检查失败: $e')));
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: TuunieColors.bg, borderRadius: BorderRadius.circular(12)),
                child: const Text('🔄 检查更新', style: TextStyle(color: TuunieColors.primary, fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Text('🇸🇬 新加坡节点 · 后端 tuunie.app', style: TextStyle(color: TuunieColors.text2, fontSize: 9, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String emoji, title, sub; final bool value; final ValueChanged<bool> onChange;
  const _ToggleRow({required this.emoji, required this.title, required this.sub, required this.value, required this.onChange});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: cardDeco(),
    child: Row(children: [
      Text(emoji, style: const TextStyle(fontSize: 24)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
        Text(sub, style: const TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
      ])),
      Switch(value: value, onChanged: onChange, activeColor: TuunieColors.primary),
    ]),
  );
}

// ========== P13 全球可用 ==========
class GlobalScreen extends StatelessWidget {
  const GlobalScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
    children: [
      const Center(child: Text('全球可用', style: TextStyle(fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.w700))),
      const Center(child: Text('跨境不延误 · 自动识别位置', style: TextStyle(color: TuunieColors.text2, fontSize: 13, fontWeight: FontWeight.w600))),
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(gradient: const LinearGradient(colors: [TuunieColors.mint, TuunieColors.sky]), borderRadius: BorderRadius.circular(24)),
        child: const Column(children: [
          Row(children: [
            Text('📥', style: TextStyle(fontSize: 36)),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('下载团团', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              Text('25MB · 安卓 7.0+', style: TextStyle(fontSize: 12)),
            ])),
          ]),
          SizedBox(height: 10),
          // 真实二维码 (用 GitHub CDN 公开资源)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(children: [
              Image.network('https://api.qrserver.com/v1/create-qr-code/?size=140x140&data=https://43.159.42.241:35888/tuunie.apk',
                width: 140, height: 140, errorBuilder: (c, e, s) => const Text('📱\n扫码下载', textAlign: TextAlign.center)),
              SizedBox(height: 4),
              Text('微信扫码下载', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
            ]),
          ),
        ]),
      ),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(16), decoration: cardDeco(),
        child: const Row(children: [
          Text('🌍', style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('时区', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            Text('自动按位置识别', style: TextStyle(color: TuunieColors.text2, fontSize: 11, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text('马来西亚 · 中国 · 新加坡 · 全部准确', style: TextStyle(color: TuunieColors.text2, fontSize: 10, fontWeight: FontWeight.w600)),
          ])),
          _MiniTag(text: 'GMT+8', bg: TuunieColors.mint, fg: TuunieColors.text),
        ])),
      const SizedBox(height: 12),
      Container(padding: const EdgeInsets.all(16), decoration: cardDeco(bg: TuunieColors.lemon),
        child: const Column(children: [
          Text('🚀', style: TextStyle(fontSize: 36)),
          SizedBox(height: 6),
          Text('不翻墙 · 不掉线', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          SizedBox(height: 4),
          Text('微信原生支持 · 4G 友好', style: TextStyle(color: TuunieColors.text2, fontSize: 12, fontWeight: FontWeight.w600)),
        ])),
    ],
  );
}
