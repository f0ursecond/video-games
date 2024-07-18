import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_games/screens/favorite/dao/favorites_dao.dart';
import 'package:video_games/screens/favorite/models/res_favorite.dart';
import 'package:video_games/utils/failure.dart';
import 'package:video_games/utils/sqlite_helper.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final SqfliteHelper sqlHelper = SqfliteHelper.instance;

  Future<void> getAllFavorite() async {
    final db = await sqlHelper.database;
    final dao = FavoritesDao(db);

    emit(FavoritesLoading());
    try {
      await dao.getAllFavorite().then((e) {
        emit(FavoritesLoaded(result: e));
      }).catchError((e) {
        emit(
          FavoritesFailure(failure: BadRequestFailure(message: e.toString())),
        );
      });
    } catch (e) {
      emit(
        FavoritesFailure(failure: BadRequestFailure(message: e.toString())),
      );
    }
  }

  Future<void> addFavorite(ResFavorite favorite) async {
    final db = await sqlHelper.database;
    final dao = FavoritesDao(db);

    emit(AddFavoritesLoading());
    try {
      await dao.addFavorites(favorite).then((e) {
        emit(AddFavoritesSuccess(result: e));
      }).catchError((e) {
        emit(
          AddFavoritesFailure(failure: BadRequestFailure(message: e.toString())),
        );
      });
    } catch (e) {
      emit(
        AddFavoritesFailure(failure: BadRequestFailure(message: e.toString())),
      );
    }
  }

  Future<void> removeFavorite(int id) async {
    final db = await sqlHelper.database;
    final dao = FavoritesDao(db);

    emit(RemoveFavoritesLoading());
    try {
      await dao.removeFavorite(id).then((e) {
        emit(RemoveFavoritesSuccess(result: e));
      }).catchError((e) {
        emit(
          RemoveFavoritesFailure(failure: BadRequestFailure(message: e.toString())),
        );
      });
    } catch (e) {
      emit(
        RemoveFavoritesFailure(failure: BadRequestFailure(message: e.toString())),
      );
    }
  }
}
