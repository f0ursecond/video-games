class ResFavorite {
  int? id;
  String? name;
  String? photo;
  String? releaseDate;

  ResFavorite({
    required this.id,
    required this.name,
    required this.photo,
    required this.releaseDate,
  });

  factory ResFavorite.fromMap(Map<String, dynamic> map) {
    return ResFavorite(
      id: map['id'],
      name: map['name'],
      photo: map['photo'],
      releaseDate: map['release_date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'release_date': releaseDate,
    };
  }
}
