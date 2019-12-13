

import 'package:bunkalist/src/features/ouevre_details/domain/contracts/anime_details_contract.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/entities/anime_details_entity.dart';
import 'package:bunkalist/src/features/ouevre_details/domain/usescases/get_anime_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetAnimeDetails extends Mock 
  implements AnimeDetailsContract {}

  void main(){

    GetAnimeDetails usecase;
    MockGetAnimeDetails mockGetAnimeDetails;

    setUp((){

      mockGetAnimeDetails = MockGetAnimeDetails();

      usecase = GetAnimeDetails(mockGetAnimeDetails);

    });

    final tAnimeDetailsEntity = AnimeDetailsEntity(
      backdropPath:  '/null',
      episodeRunTime: [16, 18] ,
      firstAirDate: '2/10/2010' ,
      genres: List<GenreAnime>(),
      homepage: 'null',
      id: 3245,
      inProduction: false,
      languages: ['ja', 'en'],
      lastAirDate: '2/10/2010' ,
      name: 'Name',
      networks: List<NetworkAnime>(),
      numberOfEpisodes: 40,
      numberOfSeasons: 3,
      originCountry: ['ja'],
      originalLanguage: 'ja',
      originalName: 'Original Name',
      overview: 'lorem inpsum',
      popularity: 3290.90,
      posterPath: '/null',
      status: 'finish',
      voteAverage: 8.5,
      voteCount: 34,
      type: 'anime',
      seasonAnime: List<SeasonAnime>()
    );

    final int tAnimeId =  3245;

    test('Get All details of Anime from de Contract', () async {

      when( mockGetAnimeDetails.getDetailsAnime(any))
        .thenAnswer((_) async => Right(tAnimeDetailsEntity));

      final result = await usecase(Params(animeId: tAnimeId ));

      expect(result, Right(tAnimeDetailsEntity));

      verify(mockGetAnimeDetails.getDetailsAnime(tAnimeId));   

      verifyNoMoreInteractions(mockGetAnimeDetails);

    });

  }