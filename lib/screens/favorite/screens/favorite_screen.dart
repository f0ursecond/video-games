import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_games/screens/favorite/cubit/favorite_cubit.dart';
import 'package:video_games/screens/home/screens/detail_screen.dart';
import 'package:video_games/shared_widgets/custom_loading.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final favoriteCubit = FavoriteCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Favorite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          bloc: favoriteCubit..getAllFavorite(),
          builder: (context, state) {
            if (state is FavoritesLoaded) {
              if (state.result.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.result.length,
                  itemBuilder: (context, index) {
                    var data = state.result[index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailScreen(id: data.id ?? 0)),
                          ).then((e) {
                            favoriteCubit.getAllFavorite();
                          });
                        },
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: data.photo ?? "https://picsum.photos/200/300",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                        ),
                        title: Text(data.name ?? "null"),
                        subtitle: Text(data.releaseDate ?? ""),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('Empty'));
              }
            } else if (state is FavoritesFailure) {
              return Center(child: Text(state.failure.message));
            } else {
              return const CustomLoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
