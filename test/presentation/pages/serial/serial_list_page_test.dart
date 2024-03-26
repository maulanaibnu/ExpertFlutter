import 'package:ditonton/presentation/bloc/serial/playing/serial_now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/popular/serial_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/rated/serial_rated_bloc.dart';
import 'package:ditonton/presentation/pages/serial/serial_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import '../../../helpers/test_helper_bloc.dart';
void main() {
  late FakeSerialListBloc fakeSerialListBloc;
  late FakeSerialPopularBloc fakeSerialPopularBloc;
  late FakeSerialTopRatedBloc fakeSerialTopBloc;

  setUp(() {
    registerFallbackValue(FakeSerialListEvent());
    registerFallbackValue(FakeSerialListState());
    fakeSerialListBloc = FakeSerialListBloc();

    registerFallbackValue(FakeSerialPopularEvent());
    registerFallbackValue(FakeSerialPopularState());
    fakeSerialPopularBloc = FakeSerialPopularBloc();

    registerFallbackValue(FakeSerialWatchlistEvent());
    registerFallbackValue(FakeSerialWatchlistState());
    fakeSerialTopBloc = FakeSerialTopRatedBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SerialNowPlayingBloc>(
          create: (context) => fakeSerialListBloc,
        ),
        BlocProvider<SerialPopularBloc>(
          create: (context) => fakeSerialPopularBloc,
        ),
        BlocProvider<SerialRatedBloc>(
          create: (context) => fakeSerialTopBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeSerialListBloc.state)
        .thenReturn(SerialNowPlayingLoading());
    when(() => fakeSerialPopularBloc.state)
        .thenReturn(SerialPopularLoading());
    when(() => fakeSerialTopBloc.state).thenReturn(SerialRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const SerialListPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display lisserialiew seriallist when hasdata',
      (tester) async {
    when(() => fakeSerialListBloc.state)
        .thenReturn(SerialNowPlayingHasData(testSerialList));
    when(() => fakeSerialPopularBloc.state)
        .thenReturn(SerialPopularHasData(testSerialList));
    when(() => fakeSerialTopBloc.state)
        .thenReturn(SerialRatedHasData(testSerialList));

    final lisserialiewFinder = find.byType(ListView);
    final serialListFinder = find.byType(SerialList);

    await tester.pumpWidget(_createTestableWidget(const SerialListPage()));

    expect(lisserialiewFinder, findsNWidgets(3));
    expect(serialListFinder, findsNWidgets(3));
  });
}