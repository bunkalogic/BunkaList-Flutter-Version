import 'dart:async';

import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_get_ouevre.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_total_by_status.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getlists_event.dart';
part 'getlists_state.dart';

class GetListsBloc extends Bloc<GetListsEvent, GetListsState> {
  
  final GetTotalByStatus getTotalByStatus;
  final GetAllOuevre getAllOuevre;
  StreamSubscription _listsSubscription;

  GetListsBloc({
    @required GetAllOuevre allOuevre,
    @required GetTotalByStatus totalByStatus
  }) : 
  assert(allOuevre != null),
  assert(totalByStatus != null),
  getAllOuevre = allOuevre,
  getTotalByStatus = totalByStatus;
  
  
  @override
  GetListsState get initialState => GetListsLoading();

  @override
  Stream<GetListsState> mapEventToState(
    GetListsEvent event,
  ) async* {
    if(event is GetYourLists){

     final eitherFailureOrLists = await 
     getAllOuevre(Params(type: event.type, status: event.status));

     //yield* _eitherLoadedOuevresOrErrorState(eitherFailureOrLists);

     eitherFailureOrLists.fold(
       (failure) => GetlistsError(), 
       (lists){
         _listsSubscription?.cancel();

         _listsSubscription = lists.listen(
            (ouevres) => add(GetYourListsUpdated(ouevres)),
         );

       }
    );

    }else if (event is GetYourListsUpdated){
      yield* _getListUpdated(event);
    }else if(event is GetTotalByStatusEvent){
      
      final either = await getTotalByStatus(ParamsTotal(type: event.type));

      yield either.fold(
        (failure) => GetlistsError(), 
        (listByStatus) => GetTotalByStatusLoaded(listByStatus) 
      );
    }
    // else if(event is GetYourListsComplStatus){
      
    //   yield GetNewListsLoading();

    //   final eitherFailureOrLists = await 
    //     getAllOuevre(Params(type: event.type, status: event.status));

    //  //yield* _eitherLoadedOuevresOrErrorState(eitherFailureOrLists);

    //  eitherFailureOrLists.fold(
    //    (failure) => GetlistsError(), 
    //    (lists){
    //      _listsSubscription?.cancel();

    //      _listsSubscription = lists.listen(
    //         (ouevres) => add(GetYourListsUpdated(ouevres)),
    //      );

    //    }
    // );
    // }
  
  }


   Stream<GetListsState> _getListUpdated(GetYourListsUpdated event) async*{
    /// Motivo por el que no paso directamente la lista desde el bloc ver en el enlace:
    /// https://github.com/felangel/bloc/issues/253
    /// y el ejemplo:
    /// https://github.com/felangel/bloc/tree/master/examples/flutter_bloc_with_stream
     
    yield GetListsLoaded(event.ouevreList);

   }


  @override
  Future<void> close() {
    _listsSubscription?.cancel();
    return super.close();
  }
}
