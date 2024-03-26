import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';
import 'package:ditonton/domain/repositories/serial_repository.dart';


class SaveWatchlistSerial {
  final SerialRepository repository;

  SaveWatchlistSerial(this.repository);

  Future<Either<Failure, String>> execute(SerialDetail serial) {
    return repository.saveWatchlist(serial);
  }
}