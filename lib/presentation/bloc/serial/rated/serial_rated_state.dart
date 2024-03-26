part of 'serial_rated_bloc.dart';

abstract class SerialRatedState extends Equatable {}

class SerialRatedLoading extends SerialRatedState {
  @override
  List<Object> get props => [];
}

class SerialRatedError extends SerialRatedState {
  final String message;

  SerialRatedError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialRatedHasData extends SerialRatedState {
  final List<Serial> result;

  SerialRatedHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class SerialRatedEmpty extends SerialRatedState {
  @override
  List<Object> get props => [];
}

