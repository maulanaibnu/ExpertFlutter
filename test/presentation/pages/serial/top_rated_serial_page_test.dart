import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/serial/rated/serial_rated_bloc.dart';
import 'package:ditonton/presentation/pages/serial/top_rated_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../dummy_data/dummy_objects_serial.dart';

class MockTopRatedSerialBloc
    extends MockBloc<SerialRatedEvent, SerialRatedState>
    implements SerialRatedBloc {}

class FakeTopRatedSerialEvent extends Fake implements SerialRatedEvent {}

class FakeTopRatedSerialState extends Fake implements SerialRatedState {}

void main() {
  late MockTopRatedSerialBloc mockTopRatedSerialBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedSerialEvent());
    registerFallbackValue(FakeTopRatedSerialState());
  });

  setUp(() {
    mockTopRatedSerialBloc = MockTopRatedSerialBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SerialRatedBloc>.value(
      value: mockTopRatedSerialBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedSerialBloc.state)
        .thenReturn(SerialRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(TopRatedSerialPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedSerialBloc.state)
        .thenReturn(SerialRatedHasData( [tSerial]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(TopRatedSerialPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedSerialBloc.state)
        .thenReturn(SerialRatedError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(TopRatedSerialPage()));

    expect(textFinder, findsOneWidget);
  });
}