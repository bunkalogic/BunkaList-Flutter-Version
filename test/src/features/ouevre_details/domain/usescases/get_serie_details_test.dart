import 'package:bunkalist/src/features/ouevre_details/domain/contracts/serie_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/serie_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_series_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetSerieDetails extends Mock 
  implements SerieDetailsContract {}

  void main(){

    GetSerieDetails usecase;
    MockGetSerieDetails mockGetSerieDetails;

    setUp((){

      mockGetSerieDetails = MockGetSerieDetails();

      usecase = GetSerieDetails(mockGetSerieDetails);

    });

    final tSerieDetailsEntity = SerieDetailsEntity(
      backdropPath:  '/null',
      episodeRunTime: [18] ,
      firstAirDate: '2/10/2010' ,
      genres: [18],
      homepage: 'null',
      id: 3245,
      inProduction: false,
      languages: ['en'],
      lastAirDate: '2/10/2010' ,
      name: 'Name',
      networks: List<Network>(),
      numberOfEpisodes: 40,
      numberOfSeasons: 3,
      originCountry: ['us'],
      originalLanguage: 'us',
      originalName: 'Original Name',
      overview: 'lorem inpsum',
      popularity: 3290.90,
      posterPath: '/null',
      status: 'finish',
      voteAverage: 8.5,
      voteCount: 34,
      type: 'tv',
    );

    final int tSerieId =  3245;

    test('Get All details of Serie from de Contract', () async {

      when( mockGetSerieDetails.getDetailsSerie(any))
        .thenAnswer((_) async => Right(tSerieDetailsEntity));

      final result = await usecase(Params(serieId: tSerieId ));

      expect(result, Right(tSerieDetailsEntity));

      verify(mockGetSerieDetails.getDetailsSerie(tSerieId));   

      verifyNoMoreInteractions(mockGetSerieDetails);

    });

  }