import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/climate_provider.dart';
import '../model/app_colors.dart';
import '../model/climate_model.dart';

import '../widgets/current_readings.dart';
import '../widgets/temperature_control.dart';
import '../widgets/settings_card.dart';
import '../widgets/room_chips.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ClimateProvider>().state;
    final provider = context.read<ClimateProvider>();
    final room = state.activeRoom;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LOGO
              Image.network(
                'https://www.vora.qa/images/Vora_-_Green_logo.png',
                height: 32,
                alignment: Alignment.centerLeft,
              ),

              const SizedBox(height: 18),

              // ROOMS
              RoomChips(
                rooms: state.rooms,
                activeIndex: state.activeRoomIndex,
                onSelect: provider.switchRoom,
              ),

              const SizedBox(height: 18),

              // TITLE
              Text(
                room.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              // CURRENT READINGS
              CurrentReadings(
                temperature: room.currentTemperature,
                humidity: room.currentHumidity,
                isPowered: state.isPowered,
              ),

              const SizedBox(height: 16),

              // TEMPERATURE CONTROL
              TemperatureControl(
                target: room.targetTemperature,
                current: room.currentTemperature,
                isPowered: state.isPowered,
                onIncrease: provider.increaseTemp,
                onDecrease: provider.decreaseTemp,
              ),

              const SizedBox(height: 16),

              // SETTINGS (FAN + POWER)
              SettingsCard(
                fanSpeed: state.fanSpeed,
                isPowered: state.isPowered,
                onFanSelect: provider.setFanSpeed,
                onPowerTap: provider.togglePower,
              ),
            ],
          ),
        ),
      ),
    );
  }
}