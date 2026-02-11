import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 약관/정책/지원 페이지를 인앱 WebView로 표시
class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({
    super.key,
    required this.title,
    required this.url,
  });

  /// 현재 앱 로케일을 HTML ?lang= 파라미터로 변환
  static String _getLangParam(Locale locale) {
    final lang = locale.languageCode;
    final script = locale.scriptCode;

    if (lang == 'zh') {
      if (script == 'Hant' ||
          locale.countryCode == 'TW' ||
          locale.countryCode == 'HK') {
        return 'zh-TW';
      }
      return 'zh';
    }
    return lang;
  }

  /// URL에 언어 파라미터를 추가
  static String buildUrl(String baseUrl, Locale locale) {
    final lang = _getLangParam(locale);
    final separator = baseUrl.contains('?') ? '&' : '?';
    return '$baseUrl${separator}lang=$lang';
  }

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
