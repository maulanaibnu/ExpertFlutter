// ignore_for_file: override_on_non_overriding_member

part of 'serial_now_playing_bloc.dart';

abstract class SerialNowPlayingState extends Equatable {}

class SerialNowPlayingLoading extends SerialNowPlayingState {
  @override
  List<Object> get props => [];
}

class SerialNowPlayingError extends SerialNowPlayingState {
  final String message;

  SerialNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialNowPlayingHasData extends SerialNowPlayingState {
  final List<Serial> result;

  SerialNowPlayingHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class SerialNowPlayingEmpty extends SerialNowPlayingState {
  @override
  List<Object> get props => [];
}

