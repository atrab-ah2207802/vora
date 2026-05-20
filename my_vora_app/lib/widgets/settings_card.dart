import 'package:flutter/material.dart';
import '../model/app_colors.dart';
import '../model/climate_model.dart';
import 'fan_speed_selector.dart';

class SettingsCard extends StatelessWidget {
  final FanSpeed fanSpeed;
  final bool isPowered;
  final ValueChanged<FanSpeed> onFanSelect;
  final VoidCallback onPowerTap;

  const SettingsCard({
    super.key,
    required this.fanSpeed,
    required this.isPowered,
    required this.onFanSelect,
    required this.onPowerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _FanRow(
            fanSpeed: fanSpeed,
            isPowered: isPowered,
            onSelect: onFanSelect,
          ),
          Divider(height: 1, color: AppColors.background, indent: 16, endIndent: 16),
          _PowerRow(isPowered: isPowered, onTap: onPowerTap),
        ],
      ),
    );
  }
}

class _FanRow extends StatelessWidget {
  final FanSpeed fanSpeed;
  final bool isPowered;
  final ValueChanged<FanSpeed> onSelect;

  const _FanRow({
    required this.fanSpeed,
    required this.isPowered,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.coolBlueBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.air, size: 17, color: AppColors.coolBlue),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fan speed',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  fanSpeed.label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          FanSpeedSelector(
            selected: fanSpeed,
            isPowered: isPowered,
            onSelect: onSelect,
          ),
        ],
      ),
    );
  }
}

class _PowerRow extends StatelessWidget {
  final bool isPowered;
  final VoidCallback onTap;

  const _PowerRow({required this.isPowered, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isPowered ? AppColors.activeGreenBg : AppColors.dangerRedBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.power_settings_new,
              size: 17,
              color: isPowered ? AppColors.activeGreen : AppColors.dangerRed,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Power',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 1),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    isPowered ? 'System is running' : 'System is off',
                    key: ValueKey(isPowered),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isPowered ? AppColors.dangerRedBg : AppColors.activeGreenBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isPowered
                      ? AppColors.dangerRedBorder
                      : AppColors.activeGreenBorder,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.power_settings_new,
                    size: 13,
                    color: isPowered ? AppColors.dangerRed : AppColors.activeGreen,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    isPowered ? 'Turn off' : 'Turn on',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isPowered ? AppColors.dangerRed : AppColors.activeGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}