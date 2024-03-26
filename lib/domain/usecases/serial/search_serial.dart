import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';

import 'package:ditonton/domain/repositories/serial_repository.dart';


class SearchSerial {
  final SerialRepository repository;

  SearchSerial(this.repository);

  Future<Either<Failure, List<Serial>>> execute(String query) {
    return repository.searchSerial(query);
  }
}