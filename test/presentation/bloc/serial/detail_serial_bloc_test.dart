
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_detail.dart';
import 'package:ditonton/domain/usecases/serial/get_serial_recomendations.dart';
import 'package:ditonton/presentation/bloc/serial/detail/serial_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_serial.dart';
import 'detail_serial_bloc_test.mocks.dart';

@GenerateMocks([  
  GetSerialDetail,
  GetSerialRecommendations,
])    
void main() {
  late MockGetSerialDetail mockGetSerialDetail;
  late SerialDetailBloc serialBloc;

  const tId = 1;

  setUp(() {
    mockGetSerialDetail = MockGetSerialDetail();
    serialBloc = SerialDetailBloc(mockGetSerialDetail);
  });

  test('initial state should be empty', () {
    expect(serialBloc.state, SerialDetailEmpty());
  });

    blocTest<SerialDetailBloc, SerialDetailState>(
    'when data success emit loading and hasData state',
    build: () {
      when(mockGetSerialDetail.execute(tId))
          .thenAnswer((_) async =>  Right(tSerialDetail));
      return serialBloc;
    },
    act: (blocAct) => blocAct.add(OnSerialDetailEvent(tId)),
    expect: () => [
      SerialDetailLoading(),
      SerialDetailHasData(tSerialDetail),
    ],
    verify: (bloc) {
      verify(mockGetSerialDetail.execute(tId));
      return OnSerialDetailEvent(tId).props;
    },
  );

  blocTest<SerialDetailBloc, SerialDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetSerialDetail.execute(tId))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return serialBloc;
    },
    act: (blocAct) => blocAct.add(OnSerialDetailEvent(tId)),
    expect: () => [
      SerialDetailLoading(),
      SerialDetailError('Server Failure'),
    ],
    verify: (blocAct) => SerialDetailLoading(),
  );
}