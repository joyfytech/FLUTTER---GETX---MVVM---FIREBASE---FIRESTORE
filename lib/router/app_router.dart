import 'package:flutter_firebase_curd/pages/movie_add_update_screen.dart';
import 'package:flutter_firebase_curd/pages/movie_list_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


class AppRouter
{

  static const MOVIE_LIST_SCREEN = "/movie-list-screen";
  static const MOVIE_ADD_UPDATE_SCREEN = "/movie-add-update-screen";

  static final routes = [
    GetPage(name: MOVIE_LIST_SCREEN, page:()=> MovieListScreen()),
    GetPage(name: MOVIE_ADD_UPDATE_SCREEN, page: ()=> MovieAddUpdateScreen()),
  ];


}