import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/repositories/serial_repository.dart';


class GetNowPlayingSerial {
  final SerialRepository repository;

  GetNowPlayingSerial(this.repository);

  Future<Either<Failure, List<Serial>>> execute() {
    return repository.getNowPlayingSerial();
  }
}