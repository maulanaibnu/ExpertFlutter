part of 'serial_detail_bloc.dart';

abstract class SerialDetailState extends Equatable {
  const SerialDetailState();
  @override
  List<Object> get props => [];

}

class SerialDetailLoading extends SerialDetailState {
  @override
  List<Object> get props => [];
}

class SerialDetailError extends SerialDetailState {
  final String message;

  SerialDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialDetailHasData extends SerialDetailState {
  final SerialDetail result;

  SerialDetailHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class SerialDetailEmpty extends SerialDetailState {
  @override
  List<Object> get props => [];
}
