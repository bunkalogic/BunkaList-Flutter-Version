import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bunkalist/src/features/home_tops/domain/entities/anime_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/anime_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_Anime.dart';


class MockAnimeTopsRepository extends Mock 
  implements AnimeTopsRepository {}

  void main() {
    
    GetTopsAnime usecase;
    MockAnimeTopsRepository mockAnimeTopsRepository;

    setUp((){
      mockAnimeTopsRepository = MockAnimeTopsRepository();
      usecase = GetTopsAnime(mockAnimeTopsRepository);
    });

    final tAnimeEntity = List<AnimeEntity>(); 

    final int tTopTypeId = 1; 

    test(
      'Get List of Tops Anime from repository', 
      () async{
        // Implementación "sobre la marcha" del repositorio utilizando el paquete Mockito.
        // Cuando se llama a getAnimeTops con cualquier argumento, siempre responda con
        // el "lado" derecho de O que contiene una lista de objetos de prueba MovieEntity's .
        when(mockAnimeTopsRepository.getTopsAnime(any))
            .thenAnswer((_) async => Right(tAnimeEntity));
        // La fase de "acto" de la prueba. Llame al método aún no existente.
        final result = await usecase(Params( topTypeId: tTopTypeId ));    
        // UseCase simplemente debería devolver lo que se devolvió del Repositorio
        expect(result, Right(tAnimeEntity));
        // Verifique que el método haya sido llamado en el Repositorio
        verify(mockAnimeTopsRepository.getTopsAnime( tTopTypeId ));
        // Solo se debe llamar al método anterior y nada más.
        verifyNoMoreInteractions(mockAnimeTopsRepository);
      }
    );
  }