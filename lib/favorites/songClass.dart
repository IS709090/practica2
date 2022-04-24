class Song {
  Song(
      {required this.artist,
      required this.name,
      required this.listnLink,
      required this.image});

  Song.fromJson(Map<String, Object?> json)
      : this(
            artist: json['artista']! as String,
            name: json['titulo']! as String,
            listnLink: json['link']! as String,
            image: json['imagen']! as String);

  final String artist;
  final String name;

  final String listnLink;
  final String image;

  Map<String, Object?> toJson() {
    return {
      'artista': artist,
      'titulo': name,
      'link': listnLink,
      'imagen': image,
    };
  }
}
