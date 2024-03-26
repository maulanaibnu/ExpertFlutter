import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:ditonton/domain/entities/serial/serial_detail.dart';


class SerialTable extends Equatable {
  final int id;
  final String? posterPath;
  final String? name;
  final String? overview;


  SerialTable({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  factory SerialTable.fromEntity(SerialDetail tvSeries) => SerialTable(
        name: tvSeries.name,
        id: tvSeries.id,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
        
        
        
      );

  factory SerialTable.fromMap(Map<String, dynamic> map) => SerialTable(
        name: map['name'],
        id: map['id'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        
        
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Serial toEntity() => Serial.watchlist(
        name: name,
        id: id,
        posterPath: posterPath,
        
        overview: overview,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
      ];
}