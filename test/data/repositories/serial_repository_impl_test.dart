
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/serial/serial_model.dart';
import 'package:ditonton/data/repositories/serial/serial_repository_impl.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_serial.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialRepositoryImpl repository;
  late MockSerialRemoteDataSource mockRemoteDataSource;
  late MockSerialLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockSerialRemoteDataSource();
    mockLocalDataSource = MockSerialLocalDataSource();
    repository = SerialRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tSerialModelList = <SerialModel>[tSerialModel];
  final tSerialList = <Serial>[tSerial];

  group('Now Playing Serial', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSerial())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getNowPlayingSerial();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSerial());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSerial())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingSerial();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSerial());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSerial())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingSerial();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSerial());
      expect(
        result,
        equals(Left(ConnectionFailure('Failed to connect to the network'))),
      );
    });
  });

  group('Popular Serial', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSerial())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getPopularSerial();
      // assert
      verify(mockRemoteDataSource.getPopularSerial());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSerial())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularSerial();
      // assert
      verify(mockRemoteDataSource.getPopularSerial());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSerial())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularSerial();
      // assert
      verify(mockRemoteDataSource.getPopularSerial());
      expect(
        result,
        equals(Left(ConnectionFailure('Failed to connect to the network'))),
      );
    });
  });

  group('Top Rated Serial', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSerial())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getTopRatedSerial();
      // assert
      verify(mockRemoteDataSource.getTopRatedSerial());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSerial())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedSerial();
      // assert
      verify(mockRemoteDataSource.getTopRatedSerial());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSerial())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedSerial();
      // assert
      verify(mockRemoteDataSource.getTopRatedSerial());
      expect(
        result,
        equals(Left(ConnectionFailure('Failed to connect to the network'))),
      );
    });
  });

  group('Search Serial', () {
    final tQuery = 'Hazbin Hotel';

    test('should return Serial series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSerial(tQuery))
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.searchSerial(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSerial(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSerial(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSerial(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSerial(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Data Serial Detail', () {
    final tId = 1;

    test(
        'should return data Serial data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialDetail(tId))
          .thenAnswer((_) async => tSerialResponse);
      // act
      final result = await repository.getSerialDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSerialDetail(tId));
      expect(result, equals(Right(tSerialDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSerialDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSerialDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get data Serial Recommendations', () {
    final tSerialList = <SerialModel>[];
    final tId = 1;

    test('should return data (serial list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialRecommendations(tId))
          .thenAnswer((_) async => tSerialList);
      // act
      final result = await repository.getSerialRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getSerialRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSerialList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getSerialRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getSerialRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(tSerialTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(tSerialDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(tSerialTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(tSerialDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(tSerialTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(tSerialDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(tSerialTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(tSerialDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getSerialById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistSerial())
          .thenAnswer((_) async => [tSerialTable]);
      // act
      final result = await repository.getWatchlistSerial();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tWatchlistSerial]);
    });
  });
}