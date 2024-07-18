import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:video_games/screens/home/cubit/games_cubit.dart';
import 'package:video_games/screens/home/models/res_games.dart';
import 'package:video_games/screens/home/repositories/game_repository.dart';
import 'package:video_games/shared_widgets/custom_loading.dart';
import 'package:video_games/shared_widgets/games_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, ResGames> _pagingController = PagingController(firstPageKey: 1);
  final searchController = TextEditingController();
  final gamesCubit = GamesCubit();
  final repo = GameRepository();

  Future<void> _fetchPage(int pageKey, [String? query]) async {
    try {
      final result = await repo.getAllGames(page: pageKey, query: query);
      result.fold((l) {
        _pagingController.error = l.message;
      }, (r) {
        final games = r;
        final isLastPage = r.isEmpty;
        if (isLastPage) {
          _pagingController.appendLastPage(games);
        } else {
          final nextKey = pageKey + 1;
          _pagingController.appendPage(games, nextKey);
        }
      });
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Games For You'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: searchController,
                  builder: (context, value, child) {
                    return Visibility(
                      visible: searchController.text.isNotEmpty,
                      child: IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    );
                  },
                ),
              ),
              onFieldSubmitted: (value) {
                _fetchPage(1, value);
                _pagingController.refresh();

                // TODO:IF YOU DON'T USE PAGINATION USE THIS
                /* 
                gamesCubit.getAllGames(page: 1, query: value);
                */
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PagedListView(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  firstPageErrorIndicatorBuilder: (context) {
                    return const Text('Error');
                  },
                  newPageErrorIndicatorBuilder: (context) {
                    return const Text('Error');
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return const CustomLoadingIndicator();
                  },
                  firstPageProgressIndicatorBuilder: (context) {
                    return const CustomLoadingIndicator();
                  },
                  noMoreItemsIndicatorBuilder: (context) {
                    return const Text('No Items More');
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return const Center(child: Text('Not Found'));
                  },
                  itemBuilder: (BuildContext context, ResGames data, int index) {
                    var dateToString = DateTime.parse(
                      data.released != null ? data.released.toString() : DateTime.now().toString(),
                    );
                    var formatedDate = DateFormat('dd-MM-yyyy').format(dateToString);
                    return GamesItemWidget(data: data, formatedDate: formatedDate);
                  },
                ),
              ),
            )

            //TODO : IF U DON'T USE PAGINATION YOU CAN USE THIS CODE

            // Expanded(
            //   child: BlocBuilder<GamesCubit, GamesState>(
            //     bloc: gamesCubit..getAllGames(),
            //     builder: (context, state) {
            //       if (state is GamesLoaded) {
            //         if (state.result.isEmpty) {
            //           return const Center(child: Text('Empty'));
            //         } else {
            //           return ListView.builder(
            //             itemCount: state.result.length,
            //             itemBuilder: (context, index) {
            //               var data = state.result[index];
            //               var dateToString = DateTime.parse(
            //                 data.released != null ? data.released.toString() : DateTime.now().toString(),
            //               );
            //               var formatedDate = DateFormat('dd-MM-yyyy').format(dateToString);
            //               return GamesItemWidget(data: data, formatedDate: formatedDate);
            //             },
            //           );
            //         }
            //       } else if (state is GamesFailure) {
            //         return Center(child: Text(state.failure.message));
            //       } else {
            //         return CustomLoadingIndicator();
            //       }
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
