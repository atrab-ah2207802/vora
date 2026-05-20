import 'package:flutter/material.dart';

class PowerToggle extends StatelessWidget {
  final bool isOn;
  final VoidCallback onToggle;

  const PowerToggle({
    super.key,
    required this.isOn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Power",
          style: TextStyle(fontSize: 18),
        ),

        Switch(
          value: isOn,
          onChanged: (_) => onToggle(),
        ),
      ],
    );
  }
}