part of 'serial_recommendation_bloc.dart';

abstract class SerialRecomendationState extends Equatable {
  const SerialRecomendationState();
  @override
  List<Object> get props => [];

}

class SerialRecomendationLoading extends SerialRecomendationState {
  @override
  List<Object> get props => [];
}

class SerialRecomendationError extends SerialRecomendationState {
  final String message;

  SerialRecomendationError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialRecomendationHasData extends SerialRecomendationState {
  final List<Serial> result;

  SerialRecomendationHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class SerialRecomendationEmpty extends SerialRecomendationState {
  @override
  List<Object> get props => [];
}
