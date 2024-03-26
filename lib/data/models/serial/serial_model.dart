import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:equatable/equatable.dart';

class SerialModel extends Equatable {
  final int id;
  final String name;
  final String originalNameSerial;
  final String originalLanguage;
  final List<String> originCountry;
  final double voteAverage;
  final double popularity;
  final String firstAirDate;
  final String? backdropPath;
  final int voteCount;
  final String overview;
  final String? posterPath;
  final List<int> genreIds;


  SerialModel({
    required this.id,
    required this.name,
    required this.originalNameSerial,
    required this.originalLanguage,
    required this.originCountry,
    required this.voteAverage,
    required this.popularity,
    required this.firstAirDate,
    required this.backdropPath,
    required this.voteCount,
    required this.overview,
    required this.posterPath,
    required this.genreIds,
  });

  factory SerialModel.fromJson(Map<String, dynamic> json) => SerialModel(
        id: json["id"],
        name: json["name"],
        originalNameSerial: json["original_name"],
        originalLanguage: json["original_language"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        voteAverage: json["vote_average"].toDouble(),
        popularity: json["popularity"].toDouble(),
        firstAirDate: json["first_air_date"],
        backdropPath: json["backdrop_path"],
        voteCount: json["vote_count"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "original_name": originalNameSerial,
        "original_language": originalLanguage,
        "origin_country": List<String>.from(originCountry.map((x) => x)),
        "vote_average": voteAverage,
        "popularity": popularity,
        "first_air_date": firstAirDate,
        "backdrop_path": backdropPath,
        "vote_count": voteCount,
        "overview": overview,
        "poster_path": posterPath,
        "genre_ids": List<int>.from(genreIds.map((x) => x)),
      };

  Serial toEntity() {
    return Serial(
      id: id,
      name: name,
      originalName: originalNameSerial,
      genreIds: genreIds,
      posterPath: posterPath,
      originCountry: originCountry,
      firstAirDate: firstAirDate,
      originalLanguage: originalLanguage,
      popularity: popularity,
      voteAverage: voteAverage,
      backdropPath: backdropPath,
      voteCount: voteCount,
      overview: overview,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        originalNameSerial,
        originalLanguage,
        originCountry,
        voteAverage,
        popularity,
        firstAirDate,
        backdropPath,
        voteCount,
        overview,
        posterPath,
        genreIds,
      ];
}
