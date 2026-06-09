// 团团 Tuunie · 极光 JPush 推送服务
// AppKey: 6095cac5a373f3ba78486905
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:flutter/material.dart';

class TuunieJPush {
  static const String appKey = '6095cac5a373f3ba78486905';
  static final JPush _jpush = JPush();

  /// 初始化推送
  static Future<void> init() async {
    _jpush.addEventHandler(
      onReceiveNotification: (message) {
        print('[JPush] Notification: ${message?.title}');
      },
      onReceiveMessage: (message) {
        print('[JPush] Message: ${message?.content}');
      },
      onOpenNotification: (message) async {
        print('[JPush] Opened: ${message?.title}');
        // 跳转到对应页面
      },
    );

    _jpush.setup(
      appKey: appKey,
      channel: 'tuunie',
      production: false,  // 测试模式
      debug: true,
    );

    _jpush.applyPushAuthority(
      const NotificationSettingsIOS(sound: true, alert: true, badge: true),
    );

    // 请求权限 (Android 13+)
    _jpush.requestPermission();
  }

  /// 设置别名 (按家庭 ID)
  static Future<void> setAlias(String familyId) async {
    _jpush.setAlias(familyId);
  }

  /// 获取 Registration ID (用于服务端推送)
  static Future<String?> getRegistrationId() async {
    return _jpush.getRegistrationID();
  }

  /// 设置 tag (对讲机频道等)
  static Future<void> setTags(List<String> tags) async {
    _jpush.setTags(tags);
  }
}
