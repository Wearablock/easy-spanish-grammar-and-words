import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/config/app_config.dart';
import 'content_store.dart';

/// 서버(Cloudflare)의 학습 데이터를 받아 둔다 — 10-29 리뉴얼 · 문제를 앱 업데이트 없이 매일 늘린다
///
///   1) manifest.json 하나만 받는다(가볍다) — {schema, min_app, files: {경로: {sha256, bytes}}}
///   2) 앱에 받아 둔 파일과 sha256 이 다른 것만 받는다
///   3) sha256 · JSON 모양을 검사하고 통과한 것만 임시 파일 → 바꿔치기로 저장한다
///   4) 받은 데이터는 다음 실행부터 쓴다(지금 화면의 캐시를 흔들지 않는다)
/// 무엇이든 실패하면 조용히 그만둔다 — 앱은 늘 앱에 든 데이터로 돈다
class RemoteContentService {
  RemoteContentService._();

  /// 🔴 서버 주소는 여기 한 곳 — `content-cdn/` 이 배포하는 곳
  static const String baseUrl = 'https://easy-spanish-content.h662hong.workers.dev';
  static const int schema = 1;
  static const Duration _minInterval = Duration(hours: 1);
  static const String _kLast = 'remote_content_last_check';
  static const String _kShaPrefix = 'remote_content_sha:';

  static Future<void> sync({bool force = false}) async {
    final dir = ContentStore.dir;
    if (dir == null) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final last = DateTime.tryParse(prefs.getString(_kLast) ?? '');
      if (!force && last != null && DateTime.now().difference(last) < _minInterval) return;

      final res = await http
          .get(Uri.parse('$baseUrl/manifest.json'))
          .timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) return;
      final manifest = json.decode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      if (manifest['schema'] != schema) return;
      final minApp = manifest['min_app'] as String?;
      if (minApp != null && _older(AppConfig.version, minApp)) return;

      final files = Map<String, dynamic>.from(manifest['files'] as Map);
      var got = 0;
      for (final e in files.entries) {
        final path = e.key;
        final sha = (e.value as Map)['sha256'] as String;
        if (!_safe(path) || prefs.getString('$_kShaPrefix$path') == sha) continue;
        final r = await http
            .get(Uri.parse('$baseUrl/data/$path?h=${sha.substring(0, 12)}'))
            .timeout(const Duration(seconds: 30));
        if (r.statusCode != 200) continue;
        if (sha256.convert(r.bodyBytes).toString() != sha) continue;
        final text = utf8.decode(r.bodyBytes);
        if (!_looksRight(path, text)) continue;
        final f = File('${dir.path}/$path');
        await f.parent.create(recursive: true);
        final tmp = File('${f.path}.tmp');
        await tmp.writeAsString(text, flush: true);
        await tmp.rename(f.path);
        await prefs.setString('$_kShaPrefix$path', sha);
        got++;
      }
      await prefs.setString(_kLast, DateTime.now().toIso8601String());
      if (got > 0) debugPrint('RemoteContent: $got file(s) updated — used from next launch');
    } catch (e) {
      debugPrint('RemoteContent: skipped ($e)');
    }
  }

  /// 경로 밖으로 나가는 이름은 받지 않는다
  static bool _safe(String p) => !p.contains('..') && !p.startsWith('/') && p.endsWith('.json');

  /// 문제 파일은 문제마다 question · correct 가 있어야 한다 · 나머지는 JSON 이기만 하면 된다
  static bool _looksRight(String path, String text) {
    try {
      final d = json.decode(text);
      if (path.startsWith('questions/') && !path.startsWith('questions/meta/')) {
        if (d is! Map || d.isEmpty) return false;
        return d.values.every((q) => q is Map && q['question'] is String && q['correct'] is String);
      }
      return d is Map || d is List;
    } catch (_) {
      return false;
    }
  }

  static bool _older(String a, String b) {
    List<int> p(String v) => v.split('.').map((x) => int.tryParse(x) ?? 0).toList();
    final x = p(a), y = p(b);
    for (var i = 0; i < 3; i++) {
      final xi = i < x.length ? x[i] : 0, yi = i < y.length ? y[i] : 0;
      if (xi != yi) return xi < yi;
    }
    return false;
  }
}
