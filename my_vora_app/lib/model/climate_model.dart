enum FanSpeed { low, medium, high }

extension FanSpeedLabel on FanSpeed {
  String get label {
    switch (this) {
      case FanSpeed.low:
        return 'Low';
      case FanSpeed.medium:
        return 'Medium';
      case FanSpeed.high:
        return 'High';
    }
  }
}

class RoomData {
  final String name;
  final int currentTemperature;
  final int currentHumidity;
  final int targetTemperature;

  const RoomData({
    required this.name,
    required this.currentTemperature,
    required this.currentHumidity,
    required this.targetTemperature,
  });

  RoomData copyWith({
    String? name,
    int? currentTemperature,
    int? currentHumidity,
    int? targetTemperature,
  }) {
    return RoomData(
      name: name ?? this.name,
      currentTemperature: currentTemperature ?? this.currentTemperature,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      targetTemperature: targetTemperature ?? this.targetTemperature,
    );
  }
}

class ClimateState {
  final List<RoomData> rooms;
  final int activeRoomIndex;
  final bool isPowered;
  final FanSpeed fanSpeed;

  const ClimateState({
    required this.rooms,
    this.activeRoomIndex = 0,
    this.isPowered = true,
    this.fanSpeed = FanSpeed.high,
  });

  RoomData get activeRoom => rooms[activeRoomIndex];

  ClimateState copyWith({
    List<RoomData>? rooms,
    int? activeRoomIndex,
    bool? isPowered,
    FanSpeed? fanSpeed,
  }) {
    return ClimateState(
      rooms: rooms ?? this.rooms,
      activeRoomIndex: activeRoomIndex ?? this.activeRoomIndex,
      isPowered: isPowered ?? this.isPowered,
      fanSpeed: fanSpeed ?? this.fanSpeed,
    );
  }
}