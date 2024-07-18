part of 'games_cubit.dart';

sealed class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object?> get props => [];
}

final class GamesInitial extends GamesState {}

//get all games
final class GamesLoading extends GamesState {}

final class GamesLoaded extends GamesState {
  final List<ResGames> result;

  const GamesLoaded({required this.result});
}

final class GamesFailure extends GamesState {
  final Failure failure;

  const GamesFailure({required this.failure});
}

//get detail games

final class DetailGamesLoading extends GamesState {}

final class DetailGamesSuccess extends GamesState {
  final ResDetailGame result;

  const DetailGamesSuccess({required this.result});
}

final class DetailGamesFailure extends GamesState {
  final Failure failure;

  const DetailGamesFailure({required this.failure});
}

enum GamesLoadStatus { initial, success, failure, loading, loadingMore }
