import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:maps/models/search_result.dart';
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
    if (event is AddToHistoryEvent) {
      yield* addToHistory(event);
    }
  }

  Stream<SearchState> addToHistory(AddToHistoryEvent event) async* {
    final exists = state.history.where((result) => event.result == result).length;
    if (exists == 0) {
      final history = [event.result, ...state.history];
      yield state.copyWith(history: history);
    } else {
      final history = state.history;
      history..remove(event.result);
      yield state.copyWith(history: [event.result, ...history]);
    }
  }
}
