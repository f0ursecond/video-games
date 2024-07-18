class ResGames {
  int? id;
  String? slug;
  String? name;
  DateTime? released;
  bool? tba;
  String? backgroundImage;
  double? rating;
  int? ratingTop;
  List<Rating>? ratings;
  int? ratingsCount;
  int? reviewsTextCount;
  int? added;
  AddedByStatus? addedByStatus;
  int? metacritic;
  int? playtime;
  int? suggestionsCount;
  DateTime? updated;
  String? userGame;
  int? reviewsCount;
  String? saturatedColor;
  String? dominantColor;
  List<PlatformElement>? platforms;
  List<ParentPlatform>? parentPlatforms;
  List<Genre>? genres;
  List<Store>? stores;
  String? clip;
  List<Genre>? tags;
  EsrbRating? esrbRating;
  List<ShortScreenshot>? shortScreenshots;

  ResGames({
    this.id,
    this.slug,
    this.name,
    this.released,
    this.tba,
    this.backgroundImage,
    this.rating,
    this.ratingTop,
    this.ratings,
    this.ratingsCount,
    this.reviewsTextCount,
    this.added,
    this.addedByStatus,
    this.metacritic,
    this.playtime,
    this.suggestionsCount,
    this.updated,
    this.userGame,
    this.reviewsCount,
    this.saturatedColor,
    this.dominantColor,
    this.platforms,
    this.parentPlatforms,
    this.genres,
    this.stores,
    this.clip,
    this.tags,
    this.esrbRating,
    this.shortScreenshots,
  });

  factory ResGames.fromJson(Map<String, dynamic> json) => ResGames(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        released: json["released"] != null ? DateTime.parse(json["released"]) : null,
        tba: json["tba"],
        backgroundImage: json["background_image"],
        rating: json["rating"]?.toDouble(),
        ratingTop: json["rating_top"],
        ratings: json["ratings"] != null ? List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))) : null,
        ratingsCount: json["ratings_count"],
        reviewsTextCount: json["reviews_text_count"],
        added: json["added"],
        addedByStatus: json["added_by_status"] != null ? AddedByStatus.fromJson(json["added_by_status"]) : null,
        metacritic: json["metacritic"],
        playtime: json["playtime"],
        suggestionsCount: json["suggestions_count"],
        updated: json["updated"] != null ? DateTime.parse(json["updated"]) : null,
        userGame: json["user_game"],
        reviewsCount: json["reviews_count"],
        saturatedColor: json["saturated_color"],
        dominantColor: json["dominant_color"],
        platforms: json["platforms"] != null
            ? List<PlatformElement>.from(json["platforms"].map((x) => PlatformElement.fromJson(x)))
            : null,
        parentPlatforms: json["parent_platforms"] != null
            ? List<ParentPlatform>.from(json["parent_platforms"].map((x) => ParentPlatform.fromJson(x)))
            : null,
        genres: json["genres"] != null ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))) : null,
        stores: json["stores"] != null ? List<Store>.from(json["stores"].map((x) => Store.fromJson(x))) : null,
        clip: json["clip"],
        tags: json["tags"] != null ? List<Genre>.from(json["tags"].map((x) => Genre.fromJson(x))) : null,
        esrbRating: json["esrb_rating"] != null ? EsrbRating.fromJson(json["esrb_rating"]) : null,
        shortScreenshots: json["short_screenshots"] != null
            ? List<ShortScreenshot>.from(json["short_screenshots"].map((x) => ShortScreenshot.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "released": released?.toIso8601String(),
        "tba": tba,
        "background_image": backgroundImage,
        "rating": rating,
        "rating_top": ratingTop,
        "ratings": ratings != null ? List<dynamic>.from(ratings!.map((x) => x.toJson())) : null,
        "ratings_count": ratingsCount,
        "reviews_text_count": reviewsTextCount,
        "added": added,
        "added_by_status": addedByStatus?.toJson(),
        "metacritic": metacritic,
        "playtime": playtime,
        "suggestions_count": suggestionsCount,
        "updated": updated?.toIso8601String(),
        "user_game": userGame,
        "reviews_count": reviewsCount,
        "saturated_color": saturatedColor,
        "dominant_color": dominantColor,
        "platforms": platforms != null ? List<dynamic>.from(platforms!.map((x) => x.toJson())) : null,
        "parent_platforms":
            parentPlatforms != null ? List<dynamic>.from(parentPlatforms!.map((x) => x.toJson())) : null,
        "genres": genres != null ? List<dynamic>.from(genres!.map((x) => x.toJson())) : null,
        "stores": stores != null ? List<dynamic>.from(stores!.map((x) => x.toJson())) : null,
        "clip": clip,
        "tags": tags != null ? List<dynamic>.from(tags!.map((x) => x.toJson())) : null,
        "esrb_rating": esrbRating?.toJson(),
        "short_screenshots":
            shortScreenshots != null ? List<dynamic>.from(shortScreenshots!.map((x) => x.toJson())) : null,
      };
}

class AddedByStatus {
  int? yet;
  int? owned;
  int? beaten;
  int? toplay;
  int? dropped;
  int? playing;

  AddedByStatus({
    this.yet,
    this.owned,
    this.beaten,
    this.toplay,
    this.dropped,
    this.playing,
  });

  factory AddedByStatus.fromJson(Map<String, dynamic> json) => AddedByStatus(
        yet: json["yet"],
        owned: json["owned"],
        beaten: json["beaten"],
        toplay: json["toplay"],
        dropped: json["dropped"],
        playing: json["playing"],
      );

  Map<String, dynamic> toJson() => {
        "yet": yet,
        "owned": owned,
        "beaten": beaten,
        "toplay": toplay,
        "dropped": dropped,
        "playing": playing,
      };
}

class EsrbRating {
  int? id;
  String? name;
  String? slug;

  EsrbRating({
    this.id,
    this.name,
    this.slug,
  });

  factory EsrbRating.fromJson(Map<String, dynamic> json) => EsrbRating(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class Genre {
  int? id;
  String? name;
  String? slug;
  int? gamesCount;
  String? imageBackground;
  String? domain;
  String? language;

  Genre({
    this.id,
    this.name,
    this.slug,
    this.gamesCount,
    this.imageBackground,
    this.domain,
    this.language,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
        domain: json["domain"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "games_count": gamesCount,
        "image_background": imageBackground,
        "domain": domain,
        "language": language,
      };
}

class ParentPlatform {
  EsrbRating? platform;

  ParentPlatform({
    this.platform,
  });

  factory ParentPlatform.fromJson(Map<String, dynamic> json) => ParentPlatform(
        platform: json["platform"] != null ? EsrbRating.fromJson(json["platform"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "platform": platform?.toJson(),
      };
}

class PlatformElement {
  PlatformPlatform? platform;
  DateTime? releasedAt;
  RequirementsEn? requirementsEn;
  dynamic requirementsRu;

  PlatformElement({
    this.platform,
    this.releasedAt,
    this.requirementsEn,
    this.requirementsRu,
  });

  factory PlatformElement.fromJson(Map<String, dynamic> json) => PlatformElement(
        platform: json["platform"] != null ? PlatformPlatform.fromJson(json["platform"]) : null,
        releasedAt: json["released_at"] != null ? DateTime.parse(json["released_at"]) : null,
        requirementsEn: json["requirements_en"] != null ? RequirementsEn.fromJson(json["requirements_en"]) : null,
        requirementsRu: json["requirements_ru"],
      );

  Map<String, dynamic> toJson() => {
        "platform": platform?.toJson(),
        "released_at": releasedAt != null
            ? "${releasedAt!.year.toString().padLeft(4, '0')}-${releasedAt!.month.toString().padLeft(2, '0')}-${releasedAt!.day.toString().padLeft(2, '0')}"
            : null,
        "requirements_en": requirementsEn?.toJson(),
        "requirements_ru": requirementsRu,
      };
}

class PlatformPlatform {
  int? id;
  String? name;
  String? slug;
  dynamic image;
  dynamic yearEnd;
  int? yearStart;
  int? gamesCount;
  String? imageBackground;

  PlatformPlatform({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.yearEnd,
    this.yearStart,
    this.gamesCount,
    this.imageBackground,
  });

  factory PlatformPlatform.fromJson(Map<String, dynamic> json) => PlatformPlatform(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        yearEnd: json["year_end"],
        yearStart: json["year_start"],
        gamesCount: json["games_count"],
        imageBackground: json["image_background"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "year_end": yearEnd,
        "year_start": yearStart,
        "games_count": gamesCount,
        "image_background": imageBackground,
      };
}

class RequirementsEn {
  String? minimum;
  String? recommended;

  RequirementsEn({
    this.minimum,
    this.recommended,
  });

  factory RequirementsEn.fromJson(Map<String, dynamic> json) => RequirementsEn(
        minimum: json["minimum"],
        recommended: json["recommended"],
      );

  Map<String, dynamic> toJson() => {
        "minimum": minimum,
        "recommended": recommended,
      };
}

class Rating {
  int? id;
  String? title;
  int? count;
  double? percent;

  Rating({
    this.id,
    this.title,
    this.count,
    this.percent,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        title: json["title"],
        count: json["count"],
        percent: json["percent"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "count": count,
        "percent": percent,
      };
}

class ShortScreenshot {
  int? id;
  String? image;

  ShortScreenshot({
    this.id,
    this.image,
  });

  factory ShortScreenshot.fromJson(Map<String, dynamic> json) => ShortScreenshot(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Store {
  int? id;
  Genre? store;

  Store({
    this.id,
    this.store,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        store: json["store"] != null ? Genre.fromJson(json["store"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store": store?.toJson(),
      };
}
