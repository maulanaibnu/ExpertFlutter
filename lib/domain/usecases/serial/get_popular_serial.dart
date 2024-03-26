import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/repositories/serial_repository.dart';


class GetPopularSerial {
  final SerialRepository repository;

  GetPopularSerial(this.repository);

  Future<Either<Failure, List<Serial>>> execute() {
    return repository.getPopularSerial();
  }
}