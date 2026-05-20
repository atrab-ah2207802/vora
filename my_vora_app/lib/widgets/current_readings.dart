import 'package:flutter/material.dart';
import '../model/app_colors.dart';

class CurrentReadings extends StatelessWidget {
  final int temperature;
  final int humidity;
  final bool isPowered;

  const CurrentReadings({
    super.key,
    required this.temperature,
    required this.humidity,
    required this.isPowered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _ReadingCell(
              icon: Icons.thermostat_outlined,
              iconBg: AppColors.tempAmberBg,
              iconColor: const Color(0xFF854F0B),
              label: 'Temperature',
              value: '$temperature',
              unit: '°C',
              isPowered: isPowered,
            )),
            VerticalDivider(
              width: 1,
              color: AppColors.borderLight,
              indent: 14,
              endIndent: 14,
            ),
            Expanded(child: _ReadingCell(
              icon: Icons.water_drop_outlined,
              iconBg: AppColors.coolBlueBg,
              iconColor: AppColors.coolBlue,
              label: 'Humidity',
              value: '$humidity',
              unit: '%',
              isPowered: isPowered,
            )),
          ],
        ),
      ),
    );
  }
}

class _ReadingCell extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;
  final String unit;
  final bool isPowered;

  const _ReadingCell({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.unit,
    required this.isPowered,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 15, color: iconColor),
              ),
              const SizedBox(width: 7),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AnimatedOpacity(
            opacity: isPowered ? 1.0 : 0.28,
            duration: const Duration(milliseconds: 300),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -1,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}