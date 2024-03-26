import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/serial/popular/serial_popular_bloc.dart';
import 'package:ditonton/presentation/pages/serial/popular_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_serial.dart';

class MockPopularSerialBloc
    extends MockBloc<SerialPopularEvent, SerialPopularState>
    implements SerialPopularBloc {}

class FakePopularSerialEvent extends Fake implements SerialPopularEvent {}

class FakePopularSerialState extends Fake implements SerialPopularState {}

void main() {
  late MockPopularSerialBloc mockPopularSerialBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularSerialEvent());
    registerFallbackValue(FakePopularSerialState());
  });

  setUp(() {
    mockPopularSerialBloc = MockPopularSerialBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SerialPopularBloc>.value(
      value: mockPopularSerialBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularSerialBloc.state)
        .thenReturn(SerialPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularSerialPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularSerialBloc.state)
        .thenReturn(SerialPopularHasData([tSerial]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularSerialPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularSerialBloc.state)
        .thenReturn( SerialPopularError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(PopularSerialPage()));

    expect(textFinder, findsOneWidget);
  });
} 