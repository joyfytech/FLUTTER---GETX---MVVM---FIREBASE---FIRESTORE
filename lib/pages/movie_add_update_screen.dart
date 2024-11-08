import 'package:flutter/material.dart';
import 'package:flutter_firebase_curd/controller/movie_controller.dart';
import 'package:flutter_firebase_curd/model/movie.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utilz/widgets_functions.dart';

class MovieAddUpdateScreen extends StatelessWidget {

  final String? movieId;

   MovieAddUpdateScreen({super.key, this.movieId});


   final MovieController movieController = Get.put(MovieController());



  @override
  Widget build(BuildContext context) {



    if(movieId !=null)
      {
        final movie = movieController.movieList.firstWhere((movieData) => movieData.movieId == movieId);


        movieController.movieNameController.text = movie.movieName.toString();
        movieController.movieDirectorNameController.text = movie.movieDirectorName.toString();


      }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: buildTextFun(context, movieId != null ? " Movie Update Screen" :"Movie Add Screen",fontSize : 20.0 , fontWeight : FontWeight.w800 , color : Colors.blue),),
        backgroundColor: Colors.white,

      body: Padding(padding: EdgeInsets.symmetric(horizontal: 400,vertical: 20),

          child: Column(

          children: [

            buildTextFormField(controller: movieController.movieNameController, labelText: "Movie Name"),

            buildSizedBoxHeightFun(context, height: 10),

            buildTextFormField(controller: movieController.movieDirectorNameController, labelText: "Movie Director Name"),

            buildSizedBoxHeightFun(context, height: 20),

            ElevatedButton(

                onPressed: () => movieController.saveMovie(movieId,context),

                child: buildTextFun(context, movieId==null ? "Add" : "Update" , fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.blueGrey))

                  ],
                ),
      ),

    );
  }
}
