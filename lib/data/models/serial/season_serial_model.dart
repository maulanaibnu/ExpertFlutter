import 'package:ditonton/domain/entities/serial/season_serial.dart';
import 'package:equatable/equatable.dart';

class SeasonSerialModel extends Equatable {
  final int id;
  final String name;
  final int seasonNumber;
  final int episodeCount;
  final String? posterPath;
  final String? airDate;
  final String overview;
  

  SeasonSerialModel({
    required this.id,
    required this.name,
    required this.seasonNumber,
    required this.episodeCount,
    required this.posterPath,
    required this.airDate,
    required this.overview,
  });

  factory SeasonSerialModel.fromJson(Map<String, dynamic> json) => SeasonSerialModel(
        id: json["id"],
        name: json["name"],
        seasonNumber: json["season_number"],
        episodeCount: json["episode_count"],
        posterPath: json["poster_path"],
        overview: json["overview"],
        airDate: json["air_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "season_number": seasonNumber,
        "episode_count": episodeCount,
        "poster_path": posterPath,
        "overview": overview,
        "air_date": airDate,
      };

  SeasonSerial toEntity() {
    return SeasonSerial(
      id: id,
      name: name,
      seasonNumber: seasonNumber,
      episodeCount: episodeCount,
      posterPath: posterPath,
      overview: overview,
      airDate: airDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        seasonNumber,
        episodeCount,
        posterPath,
        overview,
        airDate,
      ];
}
