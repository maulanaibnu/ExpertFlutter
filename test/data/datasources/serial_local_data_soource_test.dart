
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/serial_local_data_source.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_serial.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource =SerialLocalDataSourceImpl(
      databaseHelper: mockDatabaseHelper,
    );
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistSerial(tSerialTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(tSerialTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistSerial(tSerialTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(tSerialTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSerial(tSerialTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(tSerialTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSerial(tSerialTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(tSerialTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Data Serial Detail By Id', () {
    final tId = 1;

    test('should return Serial Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSerialById(tId))
          .thenAnswer((_) async => tSerialMap);
      // act
      final result = await dataSource.getSerialById(tId);
      // assert
      expect(result, tSerialTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSerialById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSerialById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist serial', () {
    test('should return list of Serial Table from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSerial())
          .thenAnswer((_) async => [tSerialMap]);
      // act
      final result = await dataSource.getWatchlistSerial();
      // assert
      expect(result, [tSerialTable]);
    });
  });
}