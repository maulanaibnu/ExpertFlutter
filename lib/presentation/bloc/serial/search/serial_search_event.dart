part of 'serial_search_bloc.dart';

abstract class SerialSearchEvent extends Equatable {
  const SerialSearchEvent();

  @override
  List<Object> get props => [];
}

class OnSerialQueryChanged extends SerialSearchEvent {
  final String query;
  OnSerialQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
