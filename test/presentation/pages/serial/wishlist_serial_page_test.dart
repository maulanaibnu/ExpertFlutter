import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/serial/watchlist/serial_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/serial/watchlist_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_serial.dart';

class MockWatchlistSerialBloc
    extends MockBloc<SerialWatchlistEvent, WatchlistSerialState>
    implements SerialWatchlistBloc {}

class FakeWatchlistTvEvent extends Fake
    implements SerialWatchlistEvent {}

class FakeWatchlistTvState extends Fake
    implements WatchlistSerialState {}

void main() {
  late MockWatchlistSerialBloc mockWatchlistSerialBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistTvEvent());
    registerFallbackValue(FakeWatchlistTvState());
  });

  setUp(() {
    mockWatchlistSerialBloc = MockWatchlistSerialBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SerialWatchlistBloc>.value(
      value: mockWatchlistSerialBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistSerialBloc.state)
        .thenReturn(WatchlistSerialLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget( WatchlistSerialPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

    testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistSerialBloc.state)
        .thenReturn(WatchlistSerialHasData(testSerialList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget( WatchlistSerialPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistSerialBloc.state)
        .thenReturn( WatchlistSerialError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget( WatchlistSerialPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text when data is empty',
      (WidgetTester tester) async {
    when(() => mockWatchlistSerialBloc.state)
        .thenReturn(WatchlistSerialEmpty());

    final textErrorBarFinder = find.text('Empty Watchlist');

    await tester.pumpWidget(makeTestableWidget( WatchlistSerialPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });
}