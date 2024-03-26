import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';
import 'package:ditonton/domain/repositories/serial_repository.dart';


class RemoveWatchlistSerial {
  final SerialRepository repository;

  RemoveWatchlistSerial(this.repository);

  Future<Either<Failure, String>> execute(SerialDetail serial) {
    return repository.removeWatchlist(serial);
  }
}