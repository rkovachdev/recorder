part of 'record_bloc.dart';

class RecordState extends Equatable {
  final RecorderStatus status;
  final String? exception;
  final Duration? progress;
  final String? path;
  const RecordState({this.status = RecorderStatus.initial, this.path, this.exception, this.progress});

  RecordState copyWith({
    RecorderStatus? status,
    final String? path,
    final String? exception,
    final Duration? progress,
  }){
    return RecordState(status: status ?? this.status, path: path ?? this.path, exception: exception ?? this.exception, progress: progress ?? this.progress);
  }

  List<Object?> get props => [ status, path, exception ];
}


