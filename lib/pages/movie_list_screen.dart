import 'package:flutter/material.dart';
import 'package:flutter_firebase_curd/main.dart';
import 'package:flutter_firebase_curd/pages/movie_add_update_screen.dart';
import 'package:flutter_firebase_curd/router/app_router.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/movie_controller.dart';
import '../utilz/widgets_functions.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {

  final MovieController movieController = Get.put(MovieController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      movieController.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildTextFun(context,"Movie List Screen",fontSize : 20.0 , fontWeight : FontWeight.w800 , color : Colors.blue),),
      backgroundColor: Colors.white,



      body: Obx(() {

        return ListView.builder(
          itemCount: movieController.movieList.length,
          itemBuilder: (context, index) {

            final movie = movieController.movieList[index];

            print("Movie Name: ${movie.movieName}, Movie Director: ${movie.movieDirectorName}");

            return ListTile(


              title: Text(movie.movieName.toString()),
              subtitle: Text(movie.movieDirectorName.toString()),


              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => movieController.deleteMovie(movie.movieId.toString()),
              ),






              onTap: () => Get.to(() => MovieAddUpdateScreen(movieId: movie.movieId)),

              //onTap: () => Get.to(() => movieController(movieId: movie.id)),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Get.toNamed(AppRouter.MOVIE_ADD_UPDATE_SCREEN);
          }),
    );
  }
}





