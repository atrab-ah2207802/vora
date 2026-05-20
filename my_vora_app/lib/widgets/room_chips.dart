import 'package:flutter/material.dart';
import '../model/app_colors.dart';
import '../model/climate_model.dart';

class RoomChips extends StatelessWidget {
  final List<RoomData> rooms;
  final int activeIndex;
  final ValueChanged<int> onSelect;

  const RoomChips({
    super.key,
    required this.rooms,
    required this.activeIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: rooms.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isActive = index == activeIndex;
          return GestureDetector(
            onTap: () => onSelect(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.textPrimary : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive
                      ? AppColors.textPrimary
                      : AppColors.borderMid,
                ),
              ),
              child: Text(
                rooms[index].name,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.background : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}