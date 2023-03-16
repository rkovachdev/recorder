import 'package:flutter_blue/flutter_blue.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothBloc() : super(const BluetoothState(bluetoothDevices: [])) {
    on<GetBluetoothDevices>(_onGetBluetoothDevices);
    on<ConnectBluetoothDevice>(_onConnectBluetoothDevice);
  }

  void _onGetBluetoothDevices(
      GetBluetoothDevices event, Emitter<BluetoothState> emit) async {
    emit(state.copyWith(status: BluetoothStatus.loading));
    await flutterBlue.startScan(timeout: const Duration(seconds: 5));
      await emit.forEach(flutterBlue.scanResults, onData: (event) {
        return state.copyWith(status: BluetoothStatus.success, bluetoothDevices: event as List<ScanResult>);
      });

    // flutterBlue.scanResults.listen((event) {
    //   devices = event;
    // });
    await flutterBlue.stopScan();
    // emit(BluetoothState(status: BluetoothStatus.success, bluetoothDevices: devices));
  }

  void _onConnectBluetoothDevice(
      ConnectBluetoothDevice event, Emitter<BluetoothState> emit) async {
    await event.result.device.connect();
    emit(const BluetoothState(status: BluetoothStatus.connected, bluetoothDevices: []));
  }
}
