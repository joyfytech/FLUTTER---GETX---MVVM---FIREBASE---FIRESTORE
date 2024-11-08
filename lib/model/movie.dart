class Movie
{
  String? movieId;
  String? movieName;
  String? movieDirectorName;

  Movie({required this.movieId,required this.movieName,required this.movieDirectorName});


  Map<String,dynamic> toMap(){
    return {
      'movieId' : movieId,
      'movieName' : movieName,
      'movieDirectorName' : movieDirectorName,
    };
  }


  // Create a Movie object from Firestore data
  factory Movie.fromMap(Map<String, dynamic> data, String id) {
    return Movie(
      movieId: id,
      movieName: data['movieName'] ?? '',
      movieDirectorName: data['movieDirectorName'] ?? '',
    );
  }

}