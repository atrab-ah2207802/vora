import 'package:flutter/material.dart';
import '../model/app_colors.dart';
import '../model/climate_model.dart';

class FanSpeedSelector extends StatefulWidget {
  final FanSpeed selected;
  final bool isPowered;
  final ValueChanged<FanSpeed> onSelect;

  const FanSpeedSelector({
    super.key,
    required this.selected,
    required this.isPowered,
    required this.onSelect,
  });

  @override
  State<FanSpeedSelector> createState() => _FanSpeedSelectorState();
}

class _FanSpeedSelectorState extends State<FanSpeedSelector> {
  late FixedExtentScrollController _controller;
  final List<FanSpeed> _speeds = FanSpeed.values;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(
      initialItem: _speeds.indexOf(widget.selected),
    );
  }

  @override
  void didUpdateWidget(FanSpeedSelector old) {
    super.didUpdateWidget(old);
    final newIndex = _speeds.indexOf(widget.selected);
    if (_controller.selectedItem != newIndex) {
      _controller.animateToItem(
        newIndex,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isPowered ? 1.0 : 0.3,
      child: IgnorePointer(
        ignoring: !widget.isPowered,
        child: SizedBox(
          height: 66,
          width: 100,
          child: ListWheelScrollView.useDelegate(
            controller: _controller,
            itemExtent: 22,
            perspective: 0.003,
            diameterRatio: 1.4,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              widget.onSelect(_speeds[index]);
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: _speeds.length,
              builder: (context, index) {
                final isSelected = _speeds[index] == widget.selected;
                final isNear = (_speeds.indexOf(widget.selected) - index).abs() == 1;
                return Text(
                  _speeds[index].label,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: isSelected ? 15 : isNear ? 13 : 12,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected
                        ? AppColors.textPrimary
                        : isNear
                            ? AppColors.textSecondary
                            : AppColors.textMuted,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}