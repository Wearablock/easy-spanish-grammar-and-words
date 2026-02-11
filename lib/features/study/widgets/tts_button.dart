import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/providers/tts_providers.dart';

/// 스페인어 텍스트 TTS 재생 버튼
class TtsButton extends ConsumerWidget {
  final String text;
  final double iconSize;

  const TtsButton({
    super.key,
    required this.text,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () {
        ref.read(ttsServiceProvider).speak(text);
      },
      icon: Icon(
        Icons.volume_up_rounded,
        size: iconSize,
        color: theme.colorScheme.primary,
      ),
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      splashRadius: 18,
      tooltip: 'TTS',
    );
  }
}
