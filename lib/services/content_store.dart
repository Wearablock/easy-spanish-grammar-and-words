import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../core/config/app_config.dart';

/// 학습 데이터(문제 · 주제 · 레벨 · 말하기) 읽기 창구 — 10-29 리뉴얼
///
/// 서버(Cloudflare)에서 받아 둔 파일이 있으면 그것을, 없거나 깨졌으면 앱에 든 파일을 읽는다.
/// 그래서 문제를 늘릴 때 앱 업데이트가 필요 없다(`RemoteContentService` 가 받아 둔다).
/// 앱 빌드가 바뀌면 받아 둔 파일을 비운다 — 새 앱에 든 데이터가 옛 서버 파일에 가려지지 않게.
class ContentStore {
  ContentStore._();

  static Directory? _dir;
  static const _assetRoot = 'assets/data/';

  static Directory? get dir => _dir;

  static Future<void> init() async {
    try {
      final base = await getApplicationSupportDirectory();
      final dir = Directory('${base.path}/content');
      final stamp = File('${base.path}/content.build');
      final build = AppConfig.buildNumber;
      if (!await stamp.exists() || (await stamp.readAsString()) != build) {
        if (await dir.exists()) await dir.delete(recursive: true);
        await stamp.writeAsString(build);
      }
      await dir.create(recursive: true);
      _dir = dir;
    } catch (e) {
      debugPrint('ContentStore init failed: $e');
    }
  }

  /// [assetPath] 는 `assets/data/...` 그대로 — 받아 둔 같은 경로의 파일이 먼저다
  static Future<String> load(String assetPath) async {
    final d = _dir;
    if (d != null && assetPath.startsWith(_assetRoot)) {
      final f = File('${d.path}/${assetPath.substring(_assetRoot.length)}');
      if (await f.exists()) {
        try {
          final s = await f.readAsString();
          json.decode(s);
          return s;
        } catch (e) {
          debugPrint('ContentStore: broken ${f.path} — using bundled');
        }
      }
    }
    return rootBundle.loadString(assetPath);
  }
}
