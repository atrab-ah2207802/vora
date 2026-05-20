import 'package:flutter/material.dart';
import '../model/climate_model.dart';

const int _tempMin = 16;
const int _tempMax = 30;

class ClimateProvider extends ChangeNotifier {
  ClimateState _state = const ClimateState(
    rooms: [
      RoomData(
        name: 'Living Room',
        currentTemperature: 24,
        currentHumidity: 58,
        targetTemperature: 22,
      ),
      RoomData(
        name: 'Bedroom',
        currentTemperature: 21,
        currentHumidity: 63,
        targetTemperature: 20,
      ),
      RoomData(
        name: 'Kitchen',
        currentTemperature: 26,
        currentHumidity: 52,
        targetTemperature: 24,
      ),
    ],
  );

  ClimateState get state => _state;

  void switchRoom(int index) {
    _state = _state.copyWith(activeRoomIndex: index);
    notifyListeners();
  }

  void increaseTemp() {
    final room = _state.activeRoom;
    if (room.targetTemperature >= _tempMax) return;
    _updateActiveRoom(
      room.copyWith(targetTemperature: room.targetTemperature + 1),
    );
  }

  void decreaseTemp() {
    final room = _state.activeRoom;
    if (room.targetTemperature <= _tempMin) return;
    _updateActiveRoom(
      room.copyWith(targetTemperature: room.targetTemperature - 1),
    );
  }

  void setFanSpeed(FanSpeed speed) {
    _state = _state.copyWith(fanSpeed: speed);
    notifyListeners();
  }

  void togglePower() {
    _state = _state.copyWith(isPowered: !_state.isPowered);
    notifyListeners();
  }

  void _updateActiveRoom(RoomData updated) {
    final rooms = List<RoomData>.from(_state.rooms);
    rooms[_state.activeRoomIndex] = updated;
    _state = _state.copyWith(rooms: rooms);
    notifyListeners();
  }
}