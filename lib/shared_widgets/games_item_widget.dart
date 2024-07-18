import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_games/screens/home/models/res_games.dart';
import 'package:video_games/screens/home/screens/detail_screen.dart';

class GamesItemWidget extends StatelessWidget {
  const GamesItemWidget({
    super.key,
    required this.data,
    required this.formatedDate,
  });

  final ResGames data;
  final String formatedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailScreen(id: data.id ?? 0)),
          );
        },
        leading: SizedBox(
          width: 50,
          height: 50,
          child: CachedNetworkImage(
            imageUrl: data.backgroundImage ?? "https://picsum.photos/200/300",
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return const Icon(Icons.error, color: Colors.red);
            },
          ),
        ),
        title: Text(data.name ?? "null"),
        subtitle: Text(formatedDate),
      ),
    );
  }
}
