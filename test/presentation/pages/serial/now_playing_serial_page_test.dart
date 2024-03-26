import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/serial/playing/serial_now_playing_bloc.dart';
import 'package:ditonton/presentation/pages/serial/now_playing_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_serial.dart';

class MockNowPlayingSerialBloc
    extends MockBloc<SerialNowPlayingEvent, SerialNowPlayingState>
    implements SerialNowPlayingBloc {}

class FakeNowPlayingSerialEvent extends Fake
    implements SerialNowPlayingEvent {}

class FakeNowPlayingSerialState extends Fake
    implements SerialNowPlayingState {}

void main() {
  late MockNowPlayingSerialBloc mockNowPlayingSerialBloc;

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingSerialEvent());
    registerFallbackValue(FakeNowPlayingSerialState());
  });

  setUp(() {
    mockNowPlayingSerialBloc = MockNowPlayingSerialBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SerialNowPlayingBloc>.value(
      value: mockNowPlayingSerialBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSerialBloc.state)
        .thenReturn(SerialNowPlayingLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(NowPlayingSerialPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSerialBloc.state)
        .thenReturn( SerialNowPlayingHasData([tSerial]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(NowPlayingSerialPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSerialBloc.state)
        .thenReturn( SerialNowPlayingError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(NowPlayingSerialPage()));

    expect(textFinder, findsOneWidget);
  });
}