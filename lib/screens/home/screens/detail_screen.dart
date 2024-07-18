import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:video_games/screens/favorite/cubit/favorite_cubit.dart';
import 'package:video_games/screens/favorite/dao/favorites_dao.dart';
import 'package:video_games/screens/favorite/models/res_favorite.dart';
import 'package:video_games/screens/home/cubit/games_cubit.dart';
import 'package:video_games/shared_widgets/custom_loading.dart';
import 'package:video_games/utils/sqlite_helper.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.id});

  final int id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final favoriteCubit = FavoriteCubit();
  final gamesCubit = GamesCubit();
  bool? isFavorite;
  SqfliteHelper sqlHelper = SqfliteHelper.instance;
  Timer? _debounce;

  Future<void> getAllFavorite() async {
    final db = await sqlHelper.database;
    final dao = FavoritesDao(db);

    await dao.getAllFavorite().then((e) {
      isFavorite = false;
      for (var i = 0; i < e.length; i++) {
        final String listIdFromFavoritesMovie = e[i].id.toString();
        if (widget.id.toString().contains(listIdFromFavoritesMovie)) {
          isFavorite = true;
          break;
        }
      }
    });
  }

  @override
  void initState() {
    getAllFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPotrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detail Games'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GamesCubit, GamesState>(
          bloc: gamesCubit..getDetailGames(widget.id),
          builder: (context, state) {
            if (state is DetailGamesSuccess) {
              var data = state.result;
              var dateToString = DateTime.parse(data.released.toString());
              var formatedDate = DateFormat('dd-MM-yyyy').format(dateToString);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * (isPotrait ? 0.30 : 1),
                    child: CachedNetworkImage(
                      imageUrl: data.backgroundImage ?? "https://picsum.photos/200/300",
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error, color: Colors.red);
                      },
                      progressIndicatorBuilder: (context, url, progress) {
                        return SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: data.publishers!.map((e) => Text(e.name ?? "")).toList(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                data.nameOriginal ?? "",
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                            addToFavoriteWidget(
                              data.id ?? 0,
                              data.nameOriginal ?? "",
                              data.backgroundImage ?? "https://picsum.photos/200/300",
                              formatedDate,
                            )
                          ],
                        ),
                        Text('Release Date : $formatedDate '),
                        Row(
                          children: [
                            Text('Rating : '),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('${data.rating}'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          children: List.generate(data.tags!.length < 5 ? data.tags!.length : 5, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Chip(label: Text(data.tags![index].name ?? "")),
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data.descriptionRaw ?? "",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  )
                ],
              );
            } else if (state is DetailGamesFailure) {
              return Center(child: Text(state.failure.message));
            } else {
              return Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.43),
                child: const CustomLoadingIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Expanded addToFavoriteWidget(int id, String name, String photo, String releaseDate) {
    return Expanded(
      child: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          if (state is AddFavoritesSuccess) {
            isFavorite = true;
            toastification.show(
              context: context,
              type: ToastificationType.success,
              title: const Text('Success Add To Favorite'),
              autoCloseDuration: const Duration(seconds: 3),
            );
          } else if (state is AddFavoritesFailure) {
            print('1' + state.failure.message);
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: Text(state.failure.message),
              autoCloseDuration: const Duration(seconds: 3),
            );
          } else if (state is RemoveFavoritesSuccess) {
            isFavorite = false;
            toastification.show(
              context: context,
              type: ToastificationType.success,
              title: const Text('Success Remove From Favorite'),
              autoCloseDuration: const Duration(seconds: 3),
            );
          } else if (state is RemoveFavoritesFailure) {
            print('2' + state.failure.message);
            toastification.show(
              context: context,
              type: ToastificationType.error,
              title: Text(state.failure.message),
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
        },
        bloc: favoriteCubit,
        builder: (context, state) {
          return IconButton(
            onPressed: () {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 300), () {
                (isFavorite ?? false)
                    ? favoriteCubit.removeFavorite(id)
                    : favoriteCubit.addFavorite(
                        ResFavorite(id: id, name: name, photo: photo, releaseDate: releaseDate),
                      );
              });
            },
            icon: Icon(
              Icons.favorite,
              color: (isFavorite ?? false) ? Colors.red : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
