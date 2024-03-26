

import 'package:ditonton/data/models/serial/serial_model.dart';
import 'package:ditonton/domain/entities/serial/serial.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSerialModel = SerialModel(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalNameSerial: 'originalName',
  );

  final tSerial = Serial(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  test('should be a subclass of Serial entity', () {
    final result = tSerialModel.toEntity();
    expect(result, tSerial);
  });
}