import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/serial_local_data_source.dart';
import 'package:ditonton/data/datasources/serial_remote_data_source.dart';

import 'package:ditonton/data/models/serial/serial_table.dart';

import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';

import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/serial_repository.dart';


class SerialRepositoryImpl extends SerialRepository {
  final SerialRemoteDataSource remoteDataSource;
  final SerialLocalDataSource localDataSource;

  SerialRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Serial>>> getNowPlayingSerial() async {
    try {
      final result = await remoteDataSource.getNowPlayingSerial();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getPopularSerial() async {
    try {
      final result = await remoteDataSource.getPopularSerial();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getTopRatedSerial() async {
    try {
      final result = await remoteDataSource.getTopRatedSerial();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> searchSerial(String query) async {
    try {
      final result = await remoteDataSource.searchSerial(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SerialDetail>> getSerialDetail(int id) async {
    try {
      final result = await remoteDataSource.getSerialDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getSerialRecommendations(
    int id,
  ) async {
    try {
      final result = await remoteDataSource.getSerialRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Serial>>> getWatchlistSerial() async {
    final result = await localDataSource.getWatchlistSerial();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getSerialById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(SerialDetail movie) async {
    try {
      final result = await localDataSource
          .removeWatchlist(SerialTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(SerialDetail serial) async {
    try {
      final result = await localDataSource
          .insertWatchlist(SerialTable.fromEntity(serial));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}