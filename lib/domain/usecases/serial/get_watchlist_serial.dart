import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';

import 'package:ditonton/domain/repositories/serial_repository.dart';


class GetWatchlistSerial {
  final SerialRepository _repository;

  GetWatchlistSerial(this._repository);

  Future<Either<Failure, List<Serial>>> execute() {
    return _repository.getWatchlistSerial();
  }
}