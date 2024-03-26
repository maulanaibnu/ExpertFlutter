import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/serial/search/serial_search_bloc.dart';
import 'package:ditonton/presentation/pages/serial/search_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_serial.dart';

class MockSearchSerialBloc
    extends MockBloc<SerialSearchEvent, SerialSearchState>
    implements SerialSearchBloc {}

class FakeSearchSerialEvent extends Fake implements SerialSearchEvent {}

class FakeSearchSerialState extends Fake implements SerialSearchState {}

void main() {
  late MockSearchSerialBloc mockSearchSerialBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchSerialEvent());
    registerFallbackValue(FakeSearchSerialState());
  });

  setUp(() {
    mockSearchSerialBloc = MockSearchSerialBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SerialSearchBloc>.value(
      value: mockSearchSerialBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchSerialBloc.state)
        .thenReturn(SerialSearchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchSerialPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchSerialBloc.state)
        .thenReturn( SerialSearchHasData([tSerial]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchSerialPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchSerialBloc.state)
        .thenReturn( SerialSearchHasData([tSerial]));

    final formSearch = find.byType(TextField);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchSerialPage()));

    await tester.enterText(formSearch, 'spiderman');
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display Text when data is empty',
      (WidgetTester tester) async {
    when(() => mockSearchSerialBloc.state).thenReturn(SerialSearchEmpty());

    final textErrorBarFinder = find.text('Search Not Found');

    await tester.pumpWidget(makeTestableWidget(const SearchSerialPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display when initial', (WidgetTester tester) async {
    when(() => mockSearchSerialBloc.state)
        .thenReturn(SerialSearchLoading());

    final textErrorBarFinder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const SearchSerialPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchSerialBloc.state)
        .thenReturn( SerialSearchError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SearchSerialPage()));

    expect(textFinder, findsOneWidget);
  });
}