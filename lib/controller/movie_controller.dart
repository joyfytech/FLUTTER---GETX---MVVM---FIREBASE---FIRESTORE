import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/movie.dart';


class MovieController extends GetxController {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Movie> movieList = <Movie>[].obs;

  // Text Controllers
  final movieNameController = TextEditingController();
  final movieDirectorNameController = TextEditingController();


  // Fetch movies from Firestore
  Future<void> fetchMovies() async {
    try {
      final snapshot = await firestore.collection('movies').get();


      movieList.value = snapshot.docs
          .map((doc) => Movie.fromMap(doc.data(), doc.id))
          .toList();

      print("Movies fetched successfully");
    } catch (e) {
      print("Error fetching movies: $e");
    }
  }

  // Add a new movie with doc ID in the fields
  Future<void> addMovie(BuildContext context) async {
    final docRef = firestore.collection('movies').doc();

    final movie = Movie(
      movieId: docRef.id,
      movieName: movieNameController.text,
      movieDirectorName: movieDirectorNameController.text
    );

    await docRef.set(movie.toMap());
    Get.snackbar("Success", "Movie Added Successfully");


    /*
    add - set
    update - update
    delete - delete
    read - get
     */

    fetchMovies();
    print("Movie added with ID: ${movie.movieId}");
  }

  // Update an existing movie
  Future<void> updateMovie(String id) async {

    final movie = Movie(
        movieId: id,
        movieName: movieNameController.text,
        movieDirectorName: movieDirectorNameController.text
    );

    await firestore.collection('movies').doc(id).update(movie.toMap());
    Get.snackbar("Success", "Movie Updated Successfully");

    fetchMovies();
    print("Movie updated with ID: $id");
  }

  // Delete a movie
  Future<void> deleteMovie(String id) async {
    // Show confirmation dialog
    Get.defaultDialog(
      title: "Confirm Deletion",
      middleText: "Are you sure you want to delete this movie?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        // Delete the movie if confirmed
        await firestore.collection('movies').doc(id).delete();
        Get.back(); // Close the dialog

        Get.snackbar("Success", "Movie Deleted Successfully");
        fetchMovies();
        print("Movie deleted with ID: $id");
      },
      onCancel: () {
        print("Movie deletion cancelled");
      },
    );
  }

  // Validate each field and print status
  bool validateFields() {
    if (movieNameController.text.isEmpty) {
      Get.snackbar("Validation failed", "Movie Name is required");
      print("Validation failed: Movie Name is required");
      return false;
    }
    if (movieDirectorNameController.text.isEmpty) {
      Get.snackbar("Validation failed", "Movie Director Name is required");
      print("Validation failed: Movie Director Name is required");
      return false;
    }

    print("All fields validated successfully");
    return true;
  }

  // Save movie (add or update based on movieId)
  Future<void> saveMovie(String? movieId, BuildContext context) async {
    if (validateFields()) {

      if (movieId == null) {
        await addMovie(context);
      } else {
        await updateMovie(movieId);
      }
      clearControllers();
    }

  }

  // Clear controllers after adding/updating
  void clearControllers() {
    movieNameController.clear();
    movieDirectorNameController.clear();
  }
}
