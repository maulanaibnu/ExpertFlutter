import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/serial_remote_data_source.dart';
import 'package:ditonton/data/models/serial/serial_detail_model.dart';
import 'package:ditonton/data/models/serial/serial_response.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=8a7c091f0f39105720358522f34b0029';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SerialRemoteDataSourceImpl dataSource;
  late MockSSLPinningClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockSSLPinningClient();
    dataSource = SerialRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Serial', () {
    final tSerialList = SerialResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_serial.json')))
        .serialList;

    test('should return list of Serial Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/now_playing_serial.json'), 200));
      // act
      final result = await dataSource.getNowPlayingSerial();
      // assert
      expect(result, equals(tSerialList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingSerial();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Serial', () {
    final tSerialList = SerialResponse.fromJson(
            json.decode(readJson('dummy_data/popular_serial.json')))
        .serialList;

    test('should return list of data Serial Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/popular_serial.json'), 200));
      // act
      final result = await dataSource.getPopularSerial();
      // assert
      expect(result, equals(tSerialList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSerial();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Serial', () {
    final tSerialList = SerialResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_serial.json')))
        .serialList;

    test('should return list of data Serial Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/top_rated_serial.json'), 200));
      // act
      final result = await dataSource.getTopRatedSerial();
      // assert
      expect(result, equals(tSerialList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSerial();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
  group('search Serial', () {
    final tSearchResult = SerialResponse.fromJson(json.decode(
      readJson('dummy_data/search_example_serial.json'),
    )).serialList;
    final tQuery = 'Game of Thrones';

    test('should return list of data serial when response code is 200', () async {
      // arrange
      when(
        mockHttpClient.get(
          Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/search_example_serial.json'),
          200,
        ),
      );
      // act
      final result = await dataSource.searchSerial(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSerial(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get serial detail', () {
    final tId = 1;
    final tSerialDetail = SerialDetailResponse.fromJson(
        json.decode(readJson('dummy_data/serial_detail.json')));

    test('should return serial detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/serial_detail.json'), 200));
      // act
      final result = await dataSource.getSerialDetail(tId);
      // assert
      expect(result, equals(tSerialDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSerialDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get data serial recommendations', () {
    final tMovieList = SerialResponse.fromJson(json.decode(
            readJson('dummy_data/serial_recomendations.json')))
        .serialList;
    final tId = 1;

    test('should return list of Serial Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/serial_recomendations.json'),
              200));
      // act
      final result = await dataSource.getSerialRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSerialRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
