// 团团 Tuunie · 声网 Agora 语音服务 (对讲机)
// AppID: e6628e6dfe674905b10b571f16f7d2ba (新加坡节点)
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class TuunieAgora {
  static const String appId = 'e6628e6dfe674905b10b571f16f7d2ba';
  static const String token = '';  // 测试模式不需要 token

  static RtcEngine? _engine;
  static bool _initialized = false;

  /// 初始化 Agora 引擎
  static Future<void> init() async {
    if (_initialized) return;
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(
      RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
    _engine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          print('[Agora] Joined: ${connection.channelId}');
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          print('[Agora] Remote user joined: $remoteUid');
        },
        onUserOffline: (connection, remoteUid, reason) {
          print('[Agora] Remote user left: $remoteUid');
        },
      ),
    );
    await _engine!.enableAudio();
    await _engine!.setAudioProfile(
      profile: AudioProfileType.audioProfileSpeechStandard,
      scenario: AudioScenarioType.audioScenarioChatroom,
    );
    _initialized = true;
  }

  /// 加入频道
  static Future<void> joinChannel(String channel, {int uid = 0}) async {
    await init();
    await _engine!.joinChannel(
      token: token,
      channelId: channel,
      uid: uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
      ),
    );
  }

  /// 离开频道
  static Future<void> leaveChannel() async {
    await _engine?.leaveChannel();
  }

  /// 切换静音 (PTT 按下时取消静音)
  static Future<void> setMute(bool muted) async {
    await _engine?.muteLocalAudioStream(muted);
  }

  /// 释放资源
  static Future<void> dispose() async {
    await _engine?.dispose();
    _initialized = false;
  }
}
