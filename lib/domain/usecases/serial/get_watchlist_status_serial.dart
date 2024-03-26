


import 'package:ditonton/domain/repositories/serial_repository.dart';

class GetWatchListStatusSerial {
  final SerialRepository repository;

  GetWatchListStatusSerial(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}