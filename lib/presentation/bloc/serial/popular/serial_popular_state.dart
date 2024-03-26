part of 'serial_popular_bloc.dart';

abstract class SerialPopularState extends Equatable {}

class SerialPopularLoading extends SerialPopularState {
  @override
  List<Object> get props => [];
}

class SerialPopularError extends SerialPopularState {
  final String message;

  SerialPopularError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialPopularHasData extends SerialPopularState {
  final List<Serial> result;

  SerialPopularHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class SerialPopularEmpty extends SerialPopularState {
  @override
  List<Object> get props => [];
}

