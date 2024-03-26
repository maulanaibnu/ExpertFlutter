part of 'serial_recommendation_bloc.dart';


abstract class SerialRecomendationEvent extends Equatable {}

class OnSerialRecomendationEvent extends SerialRecomendationEvent {
  final int id;

  OnSerialRecomendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
