import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieflix_flutter/models/nowplaying.dart';
import 'package:movieflix_flutter/services/api.dart';

class MovieController extends GetxController {
  RxList movielist = [].obs;
  RxList moviedetail = [].obs;
  RxBool isLoading = true.obs;
  RxBool isLoadingmore = false.obs;
  var currentPage = 1.obs;
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 5.0);
  @override
  void onInit() {
    fetchingmovie();
    scrollindecator();
    super.onInit();
  }

  void scrollindecator() {
    log("scrolle");
    scrollController.addListener(
      () {
        if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          try {
            currentPage++;
            // log(currentPage.toString());
          } finally {
            loadMore(currentPage.value);
          }
        }
      },
    );
  }

  void loadMore(int currentpage) async {
    try {
      isLoadingmore(true);
      var resp = await Services().fetchmovielist(currentpage);
      if (resp != null) {
        print(resp);
        movielist[0]['results'].addAll(resp['results']);
        // log(movielist.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      log(movielist[0]['results'].length.toString());
      isLoadingmore(false);
    }
  }

  fetchingmovie() async {
    try {
      isLoading(true);
      var resp = await Services().fetchmovielist(1);
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
