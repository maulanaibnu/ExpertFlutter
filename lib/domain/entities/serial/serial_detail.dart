
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/domain/entities/serial/season_serial.dart';
import 'package:equatable/equatable.dart';

class SerialDetail extends Equatable {
  SerialDetail({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.tagline,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.genres,
    required this.seasons,
    required this.voteAverage,
    required this.numberOfSeasons,
    required this.status,
    required this.numberOfEpisodes,
    required this.backdropPath,
    required this.voteCount,
    required this.type,
  });


  final int id;
  final String name;
  final String? posterPath;
  final String overview;
  final String tagline;
  final String firstAirDate;
  final String lastAirDate;
  final List<Genre> genres;
  final List<SeasonSerial> seasons;
  final double voteAverage;
  final int numberOfSeasons;
  final String status;
  final int numberOfEpisodes;
  final String? backdropPath;
  final int voteCount;
  final String type;

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
        tagline,
        firstAirDate,
        lastAirDate,
        genres,
        seasons,
        voteAverage,
        numberOfSeasons,
        status,
        numberOfEpisodes,
        backdropPath,
        voteCount,
        type,
      ];
}