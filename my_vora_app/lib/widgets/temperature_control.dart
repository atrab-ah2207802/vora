import 'package:flutter/material.dart';
import '../model/app_colors.dart';

const int tempMin = 16;
const int tempMax = 30;

class TemperatureControl extends StatelessWidget {
  final int target;
  final int current;
  final bool isPowered;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const TemperatureControl({
    super.key,
    required this.target,
    required this.current,
    required this.isPowered,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final diff = target - current;
    final atMin = target <= tempMin;
    final atMax = target >= tempMax;
    final progress = (target - tempMin) / (tempMax - tempMin);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TARGET TEMPERATURE',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _ArrowButton(
                icon: Icons.keyboard_arrow_down_rounded,
                onTap: onDecrease,
                disabled: !isPowered || atMin,
              ),
              Expanded(
                child: Column(
                  children: [
                    AnimatedOpacity(
                      opacity: isPowered ? 1.0 : 0.28,
                      duration: const Duration(milliseconds: 300),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$target',
                            style: const TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w300,
                              color: AppColors.textPrimary,
                              letterSpacing: -3,
                              height: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              '°C',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: AppColors.tempAmber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (isPowered) _DiffTag(diff: diff),
                  ],
                ),
              ),
              _ArrowButton(
                icon: Icons.keyboard_arrow_up_rounded,
                onTap: onIncrease,
                disabled: !isPowered || atMax,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text('${tempMin}°',
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: isPowered ? progress : 0,
                    minHeight: 3,
                    backgroundColor: AppColors.borderLight,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isPowered ? AppColors.tempAmberFill : AppColors.borderMid,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('${tempMax}°',
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool disabled;

  const _ArrowButton({
    required this.icon,
    required this.onTap,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.22 : 1.0,
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        child: Container(
          width: 56,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderMid),
          ),
          child: Icon(icon, size: 28, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

class _DiffTag extends StatelessWidget {
  final int diff;

  const _DiffTag({required this.diff});

  @override
  Widget build(BuildContext context) {
    final Color bg;
    final Color fg;
    final String label;

    if (diff == 0) {
      bg = const Color(0xFFEAF3DE);
      fg = const Color(0xFF27500A);
      label = 'At target';
    } else if (diff > 0) {
      bg = AppColors.heatRedBg;
      fg = AppColors.heatRed;
      label = 'Heating +$diff°';
    } else {
      bg = AppColors.tempAmberBg;
      fg = const Color(0xFF633806);
      label = 'Cooling $diff°';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}