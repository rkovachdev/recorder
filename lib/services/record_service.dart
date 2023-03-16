import 'dart:async';

import 'package:record/record.dart';

class RecordService {
  final record = Record();
  // final record = FlutterSoundRecorder();

  // Future<void> initializeRecorder() async {
  //   final status = await Permission.microphone.request();
  //   if (status.isGranted) {
  //     final rec = await record.openRecorder();
  //     rec.closeRecorder();
  //   }else{
  //     throw 'Microphone permission denyed';
  //   }
  // }

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      await record.start();
    }
  }

  Future<void> pauseRecording() async {
    if (await record.isRecording()) {
      await record.pause();
    }
  }

  Future<void> resumeRecording() async {
    if (await record.isPaused()) {
      await record.resume();
    }
  }

  Future<String?> stopRecording() async {
    String? path;
    if (await record.isRecording()) {
      path = await record.stop();
    }
    return path;
  }

  Stream<Duration> recordDuration() async*{
   yield* Stream.periodic(const Duration(seconds: 1), (data){
      return Duration(seconds: data);
    });
  }
}
