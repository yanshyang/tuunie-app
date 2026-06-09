// 团团 Tuunie · 三语 i18n
// 简中 / 繁中 / English
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TuunieI18n {
  static const supported = ['zh_CN', 'zh_TW', 'en'];
  static const Map<String, String> _labels = {
    'zh_CN': '简体中文',
    'zh_TW': '繁體中文',
    'en': 'English',
  };

  static String labelFor(String code) => _labels[code] ?? code;

  static const Map<String, Map<String, String>> _dict = {
    'zh_CN': {
      'app_name': '团团',
      'tab_calendar': '日历',
      'tab_feed': '动态',
      'tab_walkie': '对讲机',
      'tab_ice': '破冰',
      'tab_benbon': '团本本',
      'today': '今天',
      'this_week': '这周',
      'upcoming': '即将到来',
      'press_to_talk': '按住说话',
      'release_to_send': '松开发送',
      'family_channel': '家庭频道',
      'online': '在线',
      'morning_channel': '早安',
      'home_channel': '家庭',
      'sos_channel': 'SOS',
      'sos_help': '紧急呼叫全家',
      'recent_msg': '最近',
      'splash_tag': '一家人 · 一个团',
      'welcome_back': '欢迎回家',
      'wechat_login': '微信一键登录',
      'invite_code': '输入邀请码',
      'thirty_seconds': '30 秒就会用',
      'three_steps': '3 步法',
      'tips': '3 个贴士',
      'view_week': '周',
      'view_month': '月',
      'family_affair': '家事',
      'personal_public': '个人公开',
      'personal_private': '个人私密',
      'lang_zh_cn': '简体中文',
      'lang_zh_tw': '繁體中文',
      'lang_en': 'English',
      'wa_sync_home': '家事同步到 WhatsApp',
      'wa_sync_walkie': '对讲机同步',
      'smart_dnd': '智能勿扰',
      'auto_class': '上课/会议/睡觉自动静音',
      'family': '我们家',
      'parents': '爸妈家',
      'inlaws': '岳家',
      'add_event': '+ 记一件',
      'pet_level': '团子 · Lv 3',
      'tree_hole': '心情树洞',
      'vote_topic': '默契小投票',
      'code_word': '家暗号',
      'add': '+',
      'private_lock': '仅自己可见',
      'pet_says': '团子说：今天和爷爷打个招呼吧～',
    },
    'zh_TW': {
      'app_name': '團團',
      'tab_calendar': '日曆',
      'tab_feed': '動態',
      'tab_walkie': '對講機',
      'tab_ice': '破冰',
      'tab_benbon': '團本本',
      'today': '今天',
      'this_week': '這週',
      'upcoming': '即將到來',
      'press_to_talk': '按住說話',
      'release_to_send': '放開發送',
      'family_channel': '家庭頻道',
      'online': '在線',
      'morning_channel': '早安',
      'home_channel': '家庭',
      'sos_channel': 'SOS',
      'sos_help': '緊急呼叫全家',
      'recent_msg': '最近',
      'splash_tag': '一家人 · 一個團',
      'welcome_back': '歡迎回家',
      'wechat_login': '微信一鍵登入',
      'invite_code': '輸入邀請碼',
      'thirty_seconds': '30 秒就會用',
      'three_steps': '3 步法',
      'tips': '3 個貼士',
      'view_week': '週',
      'view_month': '月',
      'family_affair': '家事',
      'personal_public': '個人公開',
      'personal_private': '個人私密',
      'lang_zh_cn': '简体中文',
      'lang_zh_tw': '繁體中文',
      'lang_en': 'English',
      'wa_sync_home': '家事同步到 WhatsApp',
      'wa_sync_walkie': '對講機同步',
      'smart_dnd': '智能勿擾',
      'auto_class': '上課/會議/睡覺自動靜音',
      'family': '我們家',
      'parents': '爸媽家',
      'inlaws': '岳家',
      'add_event': '+ 記一件',
      'pet_level': '團子 · Lv 3',
      'tree_hole': '心情樹洞',
      'vote_topic': '默契小投票',
      'code_word': '家暗號',
      'add': '+',
      'private_lock': '僅自己可見',
      'pet_says': '團子說：今天和爺爺打個招呼吧～',
    },
    'en': {
      'app_name': 'Tuunie',
      'tab_calendar': 'Home',
      'tab_feed': 'Feed',
      'tab_walkie': 'Walkie',
      'tab_ice': 'Ice',
      'tab_benbon': 'Cal',
      'today': 'Today',
      'this_week': 'This Week',
      'upcoming': 'Upcoming',
      'press_to_talk': 'Hold to Talk',
      'release_to_send': 'Release to Send',
      'family_channel': 'Family',
      'online': 'Online',
      'morning_channel': 'Morning',
      'home_channel': 'Home',
      'sos_channel': 'SOS',
      'sos_help': 'Emergency · Call All',
      'recent_msg': 'Recent',
      'splash_tag': 'One Family · One Tuunie',
      'welcome_back': 'Welcome Home',
      'wechat_login': 'WeChat One-Tap Login',
      'invite_code': 'Enter Invite Code',
      'thirty_seconds': 'Learn in 30 sec',
      'three_steps': '3 Steps',
      'tips': '3 Tips',
      'view_week': 'Week',
      'view_month': 'Month',
      'family_affair': 'Family',
      'personal_public': 'Public',
      'personal_private': 'Private',
      'lang_zh_cn': '简体中文',
      'lang_zh_tw': '繁體中文',
      'lang_en': 'English',
      'wa_sync_home': 'Sync to WhatsApp',
      'wa_sync_walkie': 'Walkie Sync',
      'smart_dnd': 'Smart DND',
      'auto_class': 'Auto mute in class/meet/sleep',
      'family': 'Our Home',
      'parents': 'Parents',
      'inlaws': 'In-laws',
      'add_event': '+ Add',
      'pet_level': 'Tuunie · Lv 3',
      'tree_hole': 'Mood Hole',
      'vote_topic': 'Mini Vote',
      'code_word': 'Code Word',
      'add': '+',
      'private_lock': 'Only you',
      'pet_says': 'Tuunie says: say hi to grandpa today~',
    },
  };

  static String t(BuildContext ctx, String key) {
    final code = Localizations.localeOf(ctx).toString();
    final lang = code.startsWith('zh') && code.contains('TW') ? 'zh_TW' :
                code.startsWith('en') ? 'en' : 'zh_CN';
    return _dict[lang]?[key] ?? _dict['zh_CN']?[key] ?? key;
  }
}

class TuunieLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const TuunieLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['zh', 'en'].any((c) => locale.toString().startsWith(c));

  @override
  Future<MaterialLocalizations> load(Locale locale) async => DefaultMaterialLocalizations();

  @override
  bool shouldReload(TuunieLocalizationsDelegate old) => false;
}
