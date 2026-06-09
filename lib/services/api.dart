// 团团 Tuunie · 后端 API 客户端
// 后端地址: http://43.159.42.241:35888
import 'dart:convert';
import 'package:http/http.dart' as http;

class TuunieApi {
  // 部署到新加坡云端的外网地址
  static const String baseUrl = 'http://43.159.42.241:35888';

  static Map<String, String> get _headers => {
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  };

  static Future<Map<String, dynamic>> health() async {
    final r = await http.get(Uri.parse('$baseUrl/api/health'));
    return jsonDecode(r.body);
  }

  static Future<List<dynamic>> families() async {
    final r = await http.get(Uri.parse('$baseUrl/api/families'));
    final d = jsonDecode(r.body);
    return d['families'] ?? [];
  }

  static Future<List<dynamic>> benbon({String familyId = 'fam_our'}) async {
    final r = await http.get(Uri.parse('$baseUrl/api/benbon?family_id=$familyId'));
    final d = jsonDecode(r.body);
    return d['events'] ?? [];
  }

  static Future<List<dynamic>> walkieHistory({String? familyId}) async {
    final url = familyId == null
        ? '$baseUrl/api/walkie/history'
        : '$baseUrl/api/walkie/history?family_id=$familyId';
    final r = await http.get(Uri.parse(url));
    final d = jsonDecode(r.body);
    return d['messages'] ?? [];
  }

  static Future<List<dynamic>> walkieChannels() async {
    final r = await http.get(Uri.parse('$baseUrl/api/walkie/channels'));
    final d = jsonDecode(r.body);
    return d['channels'] ?? [];
  }

  static Future<Map<String, dynamic>> addEvent(Map<String, dynamic> event) async {
    final r = await http.post(
      Uri.parse('$baseUrl/api/benbon'),
      headers: _headers,
      body: jsonEncode(event),
    );
    return jsonDecode(r.body);
  }

  static Future<Map<String, dynamic>> postWalkieMessage(Map<String, dynamic> msg) async {
    final r = await http.post(
      Uri.parse('$baseUrl/api/walkie/post'),
      headers: _headers,
      body: jsonEncode(msg),
    );
    return jsonDecode(r.body);
  }

  static Future<Map<String, dynamic>> sos(Map<String, dynamic> sos) async {
    final r = await http.post(
      Uri.parse('$baseUrl/api/walkie/sos'),
      headers: _headers,
      body: jsonEncode(sos),
    );
    return jsonDecode(r.body);
  }

  static Future<Map<String, dynamic>> login(String code) async {
    final r = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: _headers,
      body: jsonEncode({'code': code}),
    );
    return jsonDecode(r.body);
  }

  /// 重命名家庭
  static Future<Map<String, dynamic>> renameFamily(String familyId, String newName) async {
    final r = await http.put(
      Uri.parse('$baseUrl/api/families/$familyId'),
      headers: _headers,
      body: jsonEncode({'custom_name': newName}),
    );
    return jsonDecode(r.body);
  }

  /// 重置家庭名为默认
  static Future<Map<String, dynamic>> resetFamilyName(String familyId) async {
    final r = await http.delete(
      Uri.parse('$baseUrl/api/families/$familyId/name'),
      headers: _headers,
    );
    return jsonDecode(r.body);
  }

  /// 获取版本信息
  static Future<Map<String, dynamic>> version() async {
    final r = await http.get(Uri.parse('$baseUrl/api/version'));
    return jsonDecode(r.body);
  }
}
