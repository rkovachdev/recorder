import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../index.dart';

part 'record_event.dart';
part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  final record = RecordService();
  RecordBloc() : super(const RecordState()) {
    on<StartRecord>(_onStartRecord);
    on<PauseRecord>(_onPauseRecord);
    on<ResumeRecord>(_onResumeRecord);
    on<StopRecord>(_onStopRecord);
  }

  void _onStartRecord(StartRecord events, Emitter<RecordState> emit) async {
    try {
      await record.startRecording();
      // await emit.forEach(record.recordDuration(), onData: (time) {
      //   Duration progress = time as Duration;
      //   print(progress);
      //   return state.copyWith(status: RecorderStatus.recording, progress: progress);
      // });
    } catch (err) {
      emit(state.copyWith(
          status: RecorderStatus.error, exception: err.toString()));
    }
  }

  void _onPauseRecord(PauseRecord events, Emitter<RecordState> emit) async {
    await record.pauseRecording();
    emit(state.copyWith(status: RecorderStatus.pause));
  }

  void _onResumeRecord(ResumeRecord events, Emitter<RecordState> emit) async {
    await record.resumeRecording();
    emit(state.copyWith(status: RecorderStatus.resume));
  }

  void _onStopRecord(StopRecord events, Emitter<RecordState> emit) async {
    final path = await record.stopRecording();
    emit(state.copyWith(status: RecorderStatus.stop, path: path));
  }
}
