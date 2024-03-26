import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/serial/serial_table.dart';


abstract class SerialLocalDataSource {
  Future<SerialTable?> getSerialById(int id);
  Future<List<SerialTable>> getWatchlistSerial();
  Future<String> insertWatchlist(SerialTable serial);
  Future<String> removeWatchlist(SerialTable serial);
  
  
}

class SerialLocalDataSourceImpl implements SerialLocalDataSource {
  final DatabaseHelper databaseHelper;

  SerialLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(SerialTable serial) async {
    try {
      await databaseHelper.insertWatchlistSerial(serial);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(SerialTable serial) async {
    try {
      await databaseHelper.removeWatchlistSerial(serial);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SerialTable?> getSerialById(int id) async {
    final result = await databaseHelper.getSerialById(id);
    if (result != null) {
      return SerialTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SerialTable>> getWatchlistSerial() async {
    final result = await databaseHelper.getWatchlistSerial();
    return result.map((data) => SerialTable.fromMap(data)).toList();
  }
}