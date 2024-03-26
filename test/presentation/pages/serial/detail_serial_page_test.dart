import 'package:ditonton/presentation/bloc/serial/detail/serial_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/recommendation/serial_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/serial/watchlist/serial_watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/serial/detail_serial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import '../../../helpers/test_helper_bloc.dart';

void main() {
  late FakeSerialDetailBloc fakeserialBloc;
  late FakeSerialWatchlistBloc fakeWatchlistBloc;
  late FakeSerialRecommendatioBloc fakeRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(FakeSerialDetailEvent());
    registerFallbackValue(FakeSerialDetailState());
    fakeserialBloc = FakeSerialDetailBloc();

    registerFallbackValue(FakeSerialWatchlistEvent());
    registerFallbackValue(FakeSerialWatchlistState());
    fakeWatchlistBloc = FakeSerialWatchlistBloc();

    registerFallbackValue(FakeSerialRecommendationEvent());
    registerFallbackValue(FakeSerialRecommendatioState());
    fakeRecommendationBloc = FakeSerialRecommendatioBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SerialDetailBloc>(
          create: (context) => fakeserialBloc,
        ),
        BlocProvider<SerialWatchlistBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<SerialRecomendationBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SerialDetailBloc>(
          create: (context) => fakeserialBloc,
        ),
        BlocProvider<SerialWatchlistBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<SerialRecomendationBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: body,
    );
  }

  // ignore: unused_local_variable
  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) =>
        _makeAnotherTestableWidget(DetailSerialPage(id: 1)),
    DetailSerialPage.ROUTE_NAME: (context) => const FakeDestination(),
  };

  testWidgets('should show circular progress when serial detail is loading',
      (tester) async {
    when(() => fakeserialBloc.state).thenReturn(SerialDetailLoading());
    when(() => fakeRecommendationBloc.state).thenReturn(SerialRecomendationLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(SerialIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailSerialPage(id: tSerialDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message progress when serial detail is error',
      (tester) async {
    when(() => fakeserialBloc.state).thenReturn(SerialDetailError('error'));
    when(() => fakeRecommendationBloc.state).thenReturn(SerialRecomendationLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(SerialIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailSerialPage(id: tSerialDetail.id)));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('should show empty message progress when serial detail is empty',
      (tester) async {
    when(() => fakeserialBloc.state).thenReturn(SerialDetailEmpty());
    when(() => fakeRecommendationBloc.state).thenReturn(SerialRecomendationLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(SerialIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailSerialPage(id: tSerialDetail.id)));

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when serial not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeserialBloc.state).thenReturn(SerialDetailHasData(tSerialDetail));
    when(() => fakeRecommendationBloc.state).thenReturn(SerialRecomendationHasData(testSerialList));
    when(() => fakeWatchlistBloc.state).thenReturn(SerialIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        _makeTestableWidget(DetailSerialPage(id: tSerialDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when serial is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeserialBloc.state).thenReturn(SerialDetailHasData(tSerialDetail));
    when(() => fakeRecommendationBloc.state).thenReturn(SerialRecomendationHasData(testSerialList));
    when(() => fakeWatchlistBloc.state).thenReturn(SerialIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        _makeTestableWidget(DetailSerialPage(id: tSerialDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}

class FakeHome extends StatelessWidget {
  const FakeHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeHome'),
        onTap: () {
          Navigator.pushNamed(context, '/next');
        },
      ),
      appBar: AppBar(
        title: const Text('fakeHome'),
        leading: const Icon(Icons.menu),
      ),
    );
  }
}

class FakeDestination extends StatelessWidget {
  const FakeDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeDestination'),
        onTap: () {
          Navigator.pop(context);
        },
        title: const Text('fake Destination'),
        leading: const Icon(Icons.check),
      ),
    );
  }
}