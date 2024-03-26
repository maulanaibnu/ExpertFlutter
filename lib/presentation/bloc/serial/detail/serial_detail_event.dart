part of 'serial_detail_bloc.dart';

abstract class SerialDetailEvent extends Equatable {}

class OnSerialDetailEvent extends SerialDetailEvent {
  final int id;

  OnSerialDetailEvent(this.id);

  @override
  List<Object> get props => [id];
}
