part of 'games_cubit.dart';

class GamesState extends Equatable {
  final int page;
  final GamesLoadStatus status;
  final List<ResGames> games;
  final bool hasReachedMax;

  const GamesState({
    this.status = GamesLoadStatus.initial,
    this.games = const <ResGames>[],
    this.page = 1,
    this.hasReachedMax = false,
  });

  GamesState copyWith({
    GamesLoadStatus? status,
    List<ResGames>? games,
    int? page,
    bool? hasReachedMax,
  }) {
    return GamesState(
      status: status ?? this.status,
      games: games ?? this.games,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, games, page, hasReachedMax];
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
