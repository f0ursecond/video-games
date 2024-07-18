import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:video_games/screens/home/models/res_detail_games.dart';
import 'package:video_games/screens/home/models/res_games.dart';
import 'package:video_games/utils/failure.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GameRepository {
  Future<Either<Failure, List<ResGames>>> getAllGames({int page = 1, String? query}) async {
    final apiKey = dotenv.env['API_KEY'];
    var url = 'https://api.rawg.io/api/games?search=${query ?? ""}&page=$page&page_size=10&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final body = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          List<dynamic> data = body['results'];
          final result = data.map((e) => ResGames.fromJson(e)).toList();
          return Right(result);
        case 400:
          return const Left(BadRequestFailure(message: '400 | Bad Request'));
        case 401:
          return const Left(UnauthorizedFailure(message: '401 | Unauthorized'));
        default:
          return const Left(ServerFailure(message: '500 | Server Error'));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, ResDetailGame>> getGamesDetail(int id) async {
    final apiKey = dotenv.env['API_KEY'];
    var url = 'https://api.rawg.io/api/games/$id?key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      final body = jsonDecode(response.body);

      //print(body);

      switch (response.statusCode) {
        case 200:
          final data = ResDetailGame.fromJson(body ?? {});
          return Right(data);
        case 400:
          return const Left(BadRequestFailure(message: '400 | Bad Request'));
        case 401:
          return const Left(UnauthorizedFailure(message: '401 | Unauthorized'));
        default:
          return const Left(ServerFailure(message: '500 | Server Error'));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
