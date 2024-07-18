import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_games/screens/home/models/res_detail_games.dart';
import 'package:video_games/screens/home/models/res_games.dart';
import 'package:video_games/screens/home/repositories/game_repository.dart';
import 'package:video_games/utils/failure.dart';

part 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  GamesCubit() : super(GamesInitial());

  final repo = GameRepository();

  Future<void> getAllGames({int page = 1, String? query}) async {
    emit(GamesLoading());
    try {
      final result = await repo.getAllGames(page: page, query: query);

      result.fold(
        (l) => emit(GamesFailure(failure: l)),
        (r) => emit(GamesLoaded(result: r)),
      );
    } catch (e) {
      emit(
        GamesFailure(failure: ServerFailure(message: e.toString())),
      );
    }
  }

  Future<void> getDetailGames(int id) async {
    emit(DetailGamesLoading());
    try {
      final result = await repo.getGamesDetail(id);

      result.fold(
        (l) => emit(DetailGamesFailure(failure: l)),
        (r) => emit(DetailGamesSuccess(result: r)),
      );
    } catch (e) {
      emit(
        GamesFailure(failure: ServerFailure(message: e.toString())),
      );
    }
  }
}
