class Movie {
  final int id;
  final String url;
  final String title;
  final double rating;
  final String imageUrl;
  final int year;

  Movie({this.id, this.url, this.title, this.rating, this.imageUrl, this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        url: json['url'],
        title: json['title'],
        rating: json['rating'].toDouble(),
        imageUrl: json['small_cover_image'],
        year: json['year']);
  }
}
