part of 'serial_search_bloc.dart';

abstract class SerialSearchState extends Equatable {
  const SerialSearchState();

  @override
  List<Object> get props => [];
}

class SerialSearchEmpty extends SerialSearchState{}

class SerialSearchLoading extends SerialSearchState{}

class SerialSearchError extends SerialSearchState{
  final String message;

  SerialSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SerialSearchHasData extends SerialSearchState{
  final List<Serial> result;

  SerialSearchHasData(this.result);

   @override
  List<Object> get props => [result];
}

