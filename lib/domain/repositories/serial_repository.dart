import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';


abstract class SerialRepository {
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Serial>>> getPopularSerial();
  Future<Either<Failure, SerialDetail>> getSerialDetail(int id);
  Future<Either<Failure, List<Serial>>> getTopRatedSerial();
  Future<Either<Failure, List<Serial>>> getSerialRecommendations(int id);
  Future<Either<Failure, List<Serial>>> searchSerial(String query);
  Future<Either<Failure, String>> removeWatchlist(SerialDetail movie);
  Future<Either<Failure, List<Serial>>> getWatchlistSerial();
  Future<Either<Failure, List<Serial>>> getNowPlayingSerial();
  Future<Either<Failure, String>> saveWatchlist(SerialDetail serial);
  
  
  
  
  
  
  
  
  
}
