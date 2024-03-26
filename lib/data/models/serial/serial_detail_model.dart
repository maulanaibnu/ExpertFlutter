import 'package:ditonton/data/models/movie/genre_model.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/serial/season_serial_model.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';


class SerialDetailResponse extends Equatable {
  final int id;
  final String name;
  final String originalName;
  final List<String> originCountry;
  final List<String> languages;
  final String originalLanguage;
  final String overview;
  final String firstAirDate;
  final String lastAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final String type;
  final double voteAverage;
  final String? backdropPath;
  final bool inProduction;
  final int numberOfSeasons;
  final String status;
  final double popularity;
  final String tagline;
  final String? posterPath;
  final int voteCount;
  final int numberOfEpisodes;
  final List<SeasonSerialModel> seasons;


  SerialDetailResponse({
    required this.id,
    required this.name,
    required this.originalName,
    required this.originCountry,
    required this.languages,
    required this.originalLanguage,
    required this.overview,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.genres,
    required this.homepage,
    required this.type,
    required this.voteAverage,
    required this.backdropPath,
    required this.inProduction,
    required this.numberOfSeasons,
    required this.status,
    required this.popularity,
    required this.tagline,
    required this.posterPath,
    required this.voteCount,
    required this.numberOfEpisodes,
    required this.seasons,
  });

  factory SerialDetailResponse.fromJson(Map<String, dynamic> json) => SerialDetailResponse(
    id: json["id"],
    name: json["name"],
    originalName: json["original_name"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    languages: List<String>.from(json["languages"].map((x) => x)),
    originalLanguage: json["original_language"],
    overview: json["overview"],
    firstAirDate: json["first_air_date"],
    lastAirDate: json["last_air_date"],
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    homepage: json["homepage"],
    type: json["type"],
    voteAverage: json["vote_average"].toDouble(),
    backdropPath: json["backdrop_path"],
    inProduction: json["in_production"],
    numberOfSeasons: json["number_of_seasons"],
    status: json["status"],
    popularity: json["popularity"].toDouble(),
    tagline: json["tagline"],
    posterPath: json["poster_path"],
    voteCount: json["vote_count"],
    numberOfEpisodes: json["number_of_episodes"],
    seasons: List<SeasonSerialModel>.from(json["seasons"].map((x) => SeasonSerialModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "original_name": originalName,
    "origin_country": List<String>.from(originCountry.map((x) => x)),
    "languages": List<String>.from(languages.map((x) => x)),
    "original_language": originalLanguage,
    "overview": overview,
    "first_air_date": firstAirDate,
    "last_air_date": lastAirDate,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "type": type,
    "vote_average": voteAverage,
    "backdrop_path": backdropPath,
    "in_production": inProduction,
    "number_of_seasons": numberOfSeasons,
    "status": status,
    "popularity": popularity,
    "tagline": tagline,
    "poster_path": posterPath,
    "vote_count": voteCount,
    "number_of_episodes": numberOfEpisodes,
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
  };

  SerialDetail toEntity() {
    return SerialDetail(
      id: id,
      name: name,
      posterPath: posterPath,
      overview: overview,
      tagline: tagline,
      firstAirDate: firstAirDate,
      lastAirDate: lastAirDate,
      genres: genres.map((e) => e.toEntity()).toList(),
      seasons: seasons.map((e) => e.toEntity()).toList(),
      voteAverage: voteAverage,
      numberOfSeasons: numberOfSeasons,
      status: status,
      numberOfEpisodes: numberOfEpisodes,
      backdropPath: backdropPath,
      voteCount: voteCount,
      type: type,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    originalName,
    originCountry,
    languages,
    originalLanguage,
    overview,
    firstAirDate,
    lastAirDate,
    genres,
    homepage,
    type,
    voteAverage,
    backdropPath,
    inProduction,
    numberOfSeasons,
    status,
    popularity,
    tagline,
    posterPath,
    voteCount,
    numberOfEpisodes,
    seasons,
  ];
}
