import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bunkalist/src/features/home_tops/domain/entities/serie_entity.dart';
import 'package:bunkalist/src/features/home_tops/domain/repository/serie_tops_repository.dart';
import 'package:bunkalist/src/features/home_tops/domain/usescases/get_tops_series.dart';


class MockSeriesTopsRepository extends Mock 
  implements SeriesTopsRepository {}

  void main() {
    
    GetTopsSeries usecase;
    MockSeriesTopsRepository mockSeriesTopsRepository;

    setUp((){
      mockSeriesTopsRepository = MockSeriesTopsRepository();
      usecase = GetTopsSeries(mockSeriesTopsRepository);
    });

    final tSeriesEntity = List<SeriesEntity>(); 

    final int tTopTypeId = 1; 

    test(
      'Get List of Tops Series from repository', 
      () async{
        // Implementación "sobre la marcha" del repositorio utilizando el paquete Mockito.
        // Cuando se llama a getSeriesTops con cualquier argumento, siempre responda con
        // el "lado" derecho de O que contiene una lista de objetos de prueba MovieEntity's .
        when(mockSeriesTopsRepository.getTopsSeries(any))
            .thenAnswer((_) async => Right(tSeriesEntity));
        // La fase de "acto" de la prueba. Llame al método aún no existente.
        final result = await usecase(Params( topTypeId: tTopTypeId ));    
        // UseCase simplemente debería devolver lo que se devolvió del Repositorio
        expect(result, Right(tSeriesEntity));
        // Verifique que el método haya sido llamado en el Repositorio
        verify(mockSeriesTopsRepository.getTopsSeries( tTopTypeId ));
        // Solo se debe llamar al método anterior y nada más.
        verifyNoMoreInteractions(mockSeriesTopsRepository);
      }
    );
  }