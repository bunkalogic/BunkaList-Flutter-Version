
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bunkalist/src/features/home_tops/domain/entities/movie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/movie_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_movies.dart';


class MockMoviesTopsRepository extends Mock 
implements MovieTopsRepository{}

void main() {
    
    GetTopsMovies usecase;
    MockMoviesTopsRepository mockMoviesTopsRepository;

    setUp((){
      mockMoviesTopsRepository = MockMoviesTopsRepository();
      usecase = GetTopsMovies(mockMoviesTopsRepository);
    });

    final tMovieEntity = List<MovieEntity>();

    final int tTopTypeId = 1;  

    test(
      'Get List of Tops Movie from repository', 
      () async{
        // Implementación "sobre la marcha" del repositorio utilizando el paquete Mockito.
        // Cuando se llama a getMoviesTops con cualquier argumento, siempre responda con
        // el "lado" derecho de O que contiene una lista de objetos de prueba MovieEntity's .
        when(mockMoviesTopsRepository.getTopsMovies(any))
            .thenAnswer((_) async => Right(tMovieEntity));
        // La fase de "acto" de la prueba. Llame al método aún no existente.
        final result = await usecase(Params(topTypeId: tTopTypeId ));    
        // UseCase simplemente debería devolver lo que se devolvió del Repositorio
        expect(result, Right(tMovieEntity));
        // Verifique que el método haya sido llamado en el Repositorio
        verify(mockMoviesTopsRepository.getTopsMovies( tTopTypeId ));
        // Solo se debe llamar al método anterior y nada más.
        verifyNoMoreInteractions(mockMoviesTopsRepository);
      }
    );
  }