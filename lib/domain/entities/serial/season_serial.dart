import 'package:equatable/equatable.dart';

class SeasonSerial extends Equatable {
  final int id;
  final String name;
  final int episodeCount;
  final int seasonNumber;
  final String? posterPath;
  final String? airDate;
  final String overview;
  
  

  SeasonSerial({
    required this.id,
    required this.name,
    required this.seasonNumber,
    required this.episodeCount,
    required this.posterPath,
    required this.airDate,
    required this.overview,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        seasonNumber,
        episodeCount,
        posterPath,
        airDate,
        overview,
      ];
}
