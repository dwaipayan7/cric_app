part of 'match_bloc.dart';

@immutable
sealed class MatchState {}

final class MatchInitial extends MatchState {}

class MatchLoadingState extends MatchState{}

class MatchLoadedState extends MatchState{
  final List<MatchModel> matchs;

  MatchLoadedState({required this.matchs});


}

class MatchErrorState extends MatchState{
  final String message;

  MatchErrorState({required this.message});
}
