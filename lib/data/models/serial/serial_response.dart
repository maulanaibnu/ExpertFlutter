
import 'package:equatable/equatable.dart';
import 'package:ditonton/data/models/serial/serial_model.dart';

class SerialResponse extends Equatable {
  final List<SerialModel> serialList;

  SerialResponse({required this.serialList});

  factory SerialResponse.fromJson(Map<String, dynamic> json) =>
      SerialResponse(
        serialList: List<SerialModel>.from((json['results'] as List)
            .map((x) => SerialModel.fromJson(x))
            .where((element) =>
                element.posterPath != null && element.overview != '')),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(serialList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [serialList];
}