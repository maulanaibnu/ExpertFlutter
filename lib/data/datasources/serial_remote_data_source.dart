import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/movie/movie_remote_data_source.dart';
import 'package:ditonton/data/models/serial/serial_detail_model.dart';
import 'package:ditonton/data/models/serial/serial_model.dart';
import 'package:ditonton/data/models/serial/serial_response.dart';

abstract class SerialRemoteDataSource {
  Future<SerialDetailResponse> getSerialDetail(int id);
  Future<List<SerialModel>> getPopularSerial();
  Future<List<SerialModel>> getNowPlayingSerial();
  Future<List<SerialModel>> getSerialRecommendations(int id);
  Future<List<SerialModel>> getTopRatedSerial();
  Future<List<SerialModel>> searchSerial(String query);  
}

class SerialRemoteDataSourceImpl implements SerialRemoteDataSource {
  static const API_KEY = 'api_key=8a7c091f0f39105720358522f34b0029';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final SSLPinningClient client;

  SerialRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SerialModel>> getNowPlayingSerial() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return SerialResponse.fromJson(json.decode(response.body)).serialList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialModel>> getPopularSerial() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return SerialResponse.fromJson(json.decode(response.body)).serialList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialModel>> getTopRatedSerial() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return SerialResponse.fromJson(json.decode(response.body)).serialList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SerialDetailResponse> getSerialDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return SerialDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialModel>> getSerialRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return SerialResponse.fromJson(json.decode(response.body)).serialList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SerialModel>> searchSerial(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return SerialResponse.fromJson(json.decode(response.body)).serialList;
    } else {
      throw ServerException();
    }
  }
}
