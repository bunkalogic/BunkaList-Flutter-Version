import 'dart:async';

import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:bunkalist/src/features/profile/domain/usescases/get_get_ouevre.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'getlists_event.dart';
part 'getlists_state.dart';

class GetListsBloc extends Bloc<GetListsEvent, GetListsState> {
  
  final GetAllOuevre getAllOuevre;
  StreamSubscription _listsSubscription;

  GetListsBloc({
    @required GetAllOuevre allOuevre,
  }) : 
  assert(allOuevre != null),
  getAllOuevre = allOuevre;
  
  
  @override
  GetListsState get initialState => GetListsInitial();

  @override
  Stream<GetListsState> mapEventToState(
    GetListsEvent event,
  ) async* {
    if(event is GetYourLists){

     yield GetListsLoading();

     final eitherFailureOrLists = await 
     getAllOuevre(Params(type: event.type, status: event.status));

    yield eitherFailureOrLists.fold(
       (failure) => GetlistsError(), 
       (lists){
         _listsSubscription?.cancel();

         List<OuevreEntity> listOuevre = new List();

         _listsSubscription = lists.listen(
            (ouevre) => listOuevre.addAll(ouevre),
         );

         return GetListsLoaded(listOuevre);

       }
    );

    }
  
  }

  @override
  Future<void> close() {
    _listsSubscription?.cancel();
    return super.close();
  }
}
