import 'package:equatable/equatable.dart';

class Serial extends Equatable {
  final int id;
  final String? name;
  final String? originalName;
  final List<int>? genreIds;
  final String? posterPath;
  final List<String>? originCountry;
  final String? firstAirDate;
  final String? originalLanguage;
  final double? popularity;
  final double? voteAverage;
  final String? backdropPath;
  final int? voteCount;
  final String? overview;

  
  Serial({
    required this.id,
    required this.name,
    required this.originalName,
    required this.genreIds,
    required this.posterPath,
    required this.originCountry,
    required this.firstAirDate,
    required this.originalLanguage,
    required this.popularity,
    required this.voteAverage,
    required this.backdropPath,
    required this.voteCount,
    required this.overview,
  });

  Serial.watchlist({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    this.genreIds,
    this.popularity,
    this.originCountry,
    this.originalName,
    this.firstAirDate,
    this.originalLanguage,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    
  });

  @override
  List<Object?> get props => [
        id,
        name,
        originalName,
        genreIds,
        posterPath,
        originCountry,
        firstAirDate,
        originalLanguage,
        popularity,
        voteAverage,
        backdropPath,
        voteCount,
        overview,
      ];
}
