import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movieflix_flutter/models/nowplaying.dart';

class Services {
  static var client = http.Client();
  Future fetchmovielist(var currentpage) async {
    try {
      var response = await http
          .get(
            Uri.https("api.themoviedb.org", "/3/movie/now_playing", {
              'api_key': '6f17afa1982d03bb41c2ae52a3d35b6d',
              'pages': '$currentpage'
            }),
          )
          .timeout(Duration(seconds: 15));
      // log(response.toString());
      // print(response.body);
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        return jsonString;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future fetchmoviedetail(var movieid) async {
    try {
      // https://api.themoviedb.org/3/movie/76600?api_key=6f17afa1982d03bb41c2ae52a3d35b6d&page=1&language=en-US
      var response = await http
          .get(
            Uri.https("api.themoviedb.org", "/3/movie/$movieid",
                {'api_key': '6f17afa1982d03bb41c2ae52a3d35b6d'}),
          )
          .timeout(Duration(seconds: 15));
      // log(response.toString());
      print(response.body);
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        return jsonString;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future searchmovie(var moviename) async {
    try {
      //https://api.themoviedb.org/3/search/movie?api_key=6f17afa1982d03bb41c2ae52a3d35b6d&page=1&query=Thor
      var response = await http
          .get(
            Uri.https("api.themoviedb.org", "/3/search/movie/", {
              'api_key': '6f17afa1982d03bb41c2ae52a3d35b6d',
              'query': '$moviename'
            }),
          )
          .timeout(Duration(seconds: 15));
      // log(response.toString());
      print(response.body);
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        return jsonString;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future topratedmovie() async {
    try {
      //https://api.themoviedb.org/3/search/movie?api_key=6f17afa1982d03bb41c2ae52a3d35b6d&page=1&query=Thor
      var response = await http
          .get(
            Uri.https("api.themoviedb.org", "/3/movie/top_rated", {
              'api_key': '6f17afa1982d03bb41c2ae52a3d35b6d',
            }),
          )
          .timeout(Duration(seconds: 15));
      // log(response.toString());
      print(response.body);
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        return jsonString;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
