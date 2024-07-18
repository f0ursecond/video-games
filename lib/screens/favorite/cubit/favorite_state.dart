part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

//get all favorites

class FavoritesLoading extends FavoriteState {}

class FavoritesLoaded extends FavoriteState {
  final List<ResFavorite> result;

  const FavoritesLoaded({required this.result});
}

class FavoritesFailure extends FavoriteState {
  final Failure failure;

  const FavoritesFailure({required this.failure});
}

//insert to favorite

class AddFavoritesLoading extends FavoriteState {}

class AddFavoritesSuccess extends FavoriteState {
  final int result;

  const AddFavoritesSuccess({required this.result});
}

class AddFavoritesFailure extends FavoriteState {
  final Failure failure;

  const AddFavoritesFailure({required this.failure});
}

//remove from favorite

class RemoveFavoritesLoading extends FavoriteState {}

class RemoveFavoritesSuccess extends FavoriteState {
  final int result;

  const RemoveFavoritesSuccess({required this.result});
}

class RemoveFavoritesFailure extends FavoriteState {
  final Failure failure;

  const RemoveFavoritesFailure({required this.failure});
}
