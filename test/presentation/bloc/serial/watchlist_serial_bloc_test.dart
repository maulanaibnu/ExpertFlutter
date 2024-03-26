import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/serial/get_watchlist_serial.dart';
import 'package:ditonton/domain/usecases/serial/get_watchlist_status_serial.dart';
import 'package:ditonton/domain/usecases/serial/remove_watchlist_serial.dart';
import 'package:ditonton/domain/usecases/serial/save_watchlist_serial.dart';
import 'package:ditonton/presentation/bloc/serial/watchlist/serial_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import 'watchlist_serial_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistSerial,
  GetWatchListStatusSerial,
  SaveWatchlistSerial,
  RemoveWatchlistSerial,
])
void main() {
  const watchlistAddSuccessMessage = 'Successfully Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Successfully Removed from Watchlist';

  late MockGetWatchlistSerial getWatchlistSerial;
  late MockGetWatchListStatusSerial getWatchlistSerialStatus;
  late MockSaveWatchlistSerial saveSerialWatchList;
  late MockRemoveWatchlistSerial removeSerialWatchlist;
  late SerialWatchlistBloc watchlistSerialBloc;

  setUp(() {
    getWatchlistSerial = MockGetWatchlistSerial();
    getWatchlistSerialStatus = MockGetWatchListStatusSerial();
    saveSerialWatchList = MockSaveWatchlistSerial();
    removeSerialWatchlist = MockRemoveWatchlistSerial();
    watchlistSerialBloc = SerialWatchlistBloc(
      getWatchlistSerial,
      getWatchlistSerialStatus,
      removeSerialWatchlist,
      saveSerialWatchList,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistSerialBloc.state, WatchlistSerialInitial());
  });

  group(
    'this test for get watchlist serial , ',
    () {
      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistSerial.execute())
              .thenAnswer((_) async => Right([tWatchlistSerial]));
          return watchlistSerialBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistSerial()),
        expect: () => [
          WatchlistSerialLoading(),
          WatchlistSerialHasData([tWatchlistSerial]),
        ],
        verify: (bloc) {
          verify(getWatchlistSerial.execute());
          return OnGethWatchlistSerial().props;
        },
      );

      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistSerial.execute()).thenAnswer(
              (_) async =>  Left(ServerFailure('Server Failure')));
          return watchlistSerialBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistSerial()),
        expect: () => [
          WatchlistSerialLoading(),
          WatchlistSerialError('Server Failure'),
        ],
        verify: (bloc) => WatchlistSerialLoading(),
      );

      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistSerial.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistSerialBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistSerial()),
        expect: () => [
          WatchlistSerialLoading(),
          WatchlistSerialEmpty(),
        ],
      );
    },
  );

  group(
    'this test for get serial  watchlist status,',
    () {
      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should get true when the watchlist status is true',
        build: () {
          when(getWatchlistSerialStatus.execute(tSerialDetail.id))
              .thenAnswer((_) async => true);
          return watchlistSerialBloc;
        },
        act: (bloc) =>
            bloc.add(FetchSerialWatchlistStatus(tSerialDetail.id)),
        expect: () => [
          SerialIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistSerialStatus.execute(tSerialDetail.id));
          return FetchSerialWatchlistStatus(tSerialDetail.id).props;
        },
      );

      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should get false when the watchlist status is false',
        build: () {
          when(getWatchlistSerialStatus.execute(tSerialDetail.id))
              .thenAnswer((_) async => false);
          return watchlistSerialBloc;
        },
        act: (bloc) =>
            bloc.add(FetchSerialWatchlistStatus(tSerialDetail.id)),
        expect: () => [
          SerialIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistSerialStatus.execute(tSerialDetail.id));
          return FetchSerialWatchlistStatus(tSerialDetail.id).props;
        },
      );
    },
  );

  group(
    'this test for add and remove serial  watchlist,',
    () {
      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveSerialWatchList.execute(tSerialDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistSerialBloc;
        },
        act: (bloc) => bloc.add(AddSerialToWatchlist(tSerialDetail)),
        expect: () => [
          WatchlistSerialMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveSerialWatchList.execute(tSerialDetail));
          return AddSerialToWatchlist(tSerialDetail).props;
        },
      );

      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveSerialWatchList.execute(tSerialDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistSerialBloc;
        },
        act: (bloc) => bloc.add(AddSerialToWatchlist(tSerialDetail)),
        expect: () => [
          WatchlistSerialError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveSerialWatchList.execute(tSerialDetail));
          return AddSerialToWatchlist(tSerialDetail).props;
        },
      );

      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeSerialWatchlist.execute(tSerialDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistSerialBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveSerialFromWatchlist(tSerialDetail)),
        expect: () => [
          WatchlistSerialMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeSerialWatchlist.execute(tSerialDetail));
          return RemoveSerialFromWatchlist(tSerialDetail).props;
        },
      );

      blocTest<SerialWatchlistBloc, WatchlistSerialState>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeSerialWatchlist.execute(tSerialDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('cannot add data to watchlist')));
          return watchlistSerialBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveSerialFromWatchlist(tSerialDetail)),
        expect: () => [
          WatchlistSerialError('cannot add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeSerialWatchlist.execute(tSerialDetail));
          return RemoveSerialFromWatchlist(tSerialDetail).props;
        },
      );
    },
  );
}
