import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

enum OptionState { normal, selected, correct, wrong, disabled }

class OptionButton extends StatelessWidget {
  final int index;
  final String text;
  final OptionState optionState;
  final VoidCallback? onTap;

  const OptionButton({
    super.key,
    required this.index,
    required this.text,
    required this.optionState,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: optionState == OptionState.normal ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _backgroundColor(theme),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _borderColor(theme), width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _circleColor(theme),
                ),
                child: Center(child: _circleContent(theme)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _textColor(theme),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _backgroundColor(ThemeData theme) {
    switch (optionState) {
      case OptionState.correct:
        return AppColors.correct.withValues(alpha: 0.08);
      case OptionState.wrong:
        return AppColors.wrong.withValues(alpha: 0.08);
      case OptionState.disabled:
        return theme.colorScheme.outline.withValues(alpha: 0.05);
      default:
        return Colors.transparent;
    }
  }

  Color _borderColor(ThemeData theme) {
    switch (optionState) {
      case OptionState.correct:
        return AppColors.correct;
      case OptionState.wrong:
        return AppColors.wrong;
      case OptionState.selected:
        return theme.colorScheme.primary;
      case OptionState.disabled:
        return theme.colorScheme.outline.withValues(alpha: 0.2);
      default:
        return theme.colorScheme.outline.withValues(alpha: 0.3);
    }
  }

  Color _circleColor(ThemeData theme) {
    switch (optionState) {
      case OptionState.correct:
        return AppColors.correct;
      case OptionState.wrong:
        return AppColors.wrong;
      case OptionState.selected:
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.outline.withValues(alpha: 0.15);
    }
  }

  Widget _circleContent(ThemeData theme) {
    switch (optionState) {
      case OptionState.correct:
        return const Icon(Icons.check, color: Colors.white, size: 18);
      case OptionState.wrong:
        return const Icon(Icons.close, color: Colors.white, size: 18);
      default:
        final color = optionState == OptionState.selected
            ? Colors.white
            : (optionState == OptionState.disabled
                ? theme.colorScheme.outline
                : theme.colorScheme.onSurface);
        return Text(
          '${index + 1}',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: color,
          ),
        );
    }
  }

  Color _textColor(ThemeData theme) {
    if (optionState == OptionState.disabled) {
      return theme.colorScheme.outline;
    }
    return theme.colorScheme.onSurface;
  }
}
