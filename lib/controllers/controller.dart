import 'dart:developer';
import 'package:get/get.dart';
import 'package:movieflix_flutter/models/nowplaying.dart';
import 'package:movieflix_flutter/services/api.dart';

class MovieController extends GetxController {
  RxList movielist = [].obs;
  RxList moviedetail = [].obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    fetchingmovie();
    super.onInit();
  }

  fetchingmovie() async {
    try {
      isLoading(true);
      var resp = await Services().fetchmovielist();
      if (resp != null) {
        movielist.assign(resp);
        // log(movielist.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  fetchintopratedgmovie() async {
    try {
      isLoading(true);
      var resp = await Services().topratedmovie();
      if (resp != null) {
        movielist.assign(resp);
        // log(movielist.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  fetchingmoviedetail(var movieID) async {
    try {
      isLoading(true);
      var resp = await Services().fetchmoviedetail(movieID);
      if (resp != null) {
        moviedetail.assign(resp);
        // log(movielist.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }

  searchMovie(var moviename) async {
    try {
      isLoading(true);
      var resp = await Services().searchmovie(moviename);
      if (resp != null) {
        movielist.assign(resp);
        // log(movielist.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
