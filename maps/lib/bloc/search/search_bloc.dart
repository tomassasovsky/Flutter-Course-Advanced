import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is ShowManualMarkerEvent) {
      yield state.copyWith(manualSelection: true);
    }
    if (event is HideManualMarkerEvent) {
      yield state.copyWith(manualSelection: false);
    }
    if (event is ToggleManualMarkerEvent) {
      yield state.copyWith(manualSelection: !state.manualSelection);
    }
  }
}
