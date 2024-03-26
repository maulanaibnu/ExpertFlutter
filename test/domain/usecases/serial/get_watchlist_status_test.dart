
import 'package:ditonton/domain/usecases/serial/get_watchlist_status_serial.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusSerial usecase;
  late MockSerialRepository mockSerialRepository;

  setUp(() {
    mockSerialRepository = MockSerialRepository();
    usecase = GetWatchListStatusSerial(mockSerialRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockSerialRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}