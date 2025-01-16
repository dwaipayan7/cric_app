import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cric_app/features/repository/repository.dart';
import 'package:meta/meta.dart';

import '../../models/match_model.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {

  final MatchRepository matchRepository;

  MatchBloc(this.matchRepository) : super(MatchInitial()) {
    on<FetchMatchDetails>(_fetchMatchDetails);
  }

  FutureOr<void> _fetchMatchDetails(FetchMatchDetails event, Emitter<MatchState> emit) async {
    emit(MatchLoadingState());

    try {
      final matches = await matchRepository.fetchMatchDetails();

      if (matches.isNotEmpty) {
        emit(MatchLoadedState(matchs: matches));
      } else {
        emit(MatchErrorState(message: "No matches found."));
      }
    } catch (e) {
      emit(MatchErrorState(message: e.toString()));
    }
  }
}
