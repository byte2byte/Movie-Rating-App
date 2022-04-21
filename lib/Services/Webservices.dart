import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tmdb_testapp/Model/NowPlayingModel.dart';

class Webservices {
  var dio = Dio();

  Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'content-type': 'application/json',
  }; // Header declaration

  // Method to execute APIs
  Future? executeAPI(String url) async {
    dio.options.headers = header;
    Response<String> result = await dio.get(url);
    return result.data!;
  }

  Future<NowPlaying?> getNowPlaying() async {
    try {
      String? response = await executeAPI(
          "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed");
      if (response != null) {
        final nowPlaying = nowPlayingFromJson(response);
        return nowPlaying;
      }
    } catch (e) {
      log("Fatal Error in Get Now Playing API:- ${e.toString()}");
      return null;
    }
  }

  Future<NowPlaying?> getTopRated() async {
    try {
      String? response = await executeAPI(
          "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed");
      if (response != null) {
        final nowPlaying = nowPlayingFromJson(response);
        return nowPlaying;
      }
    } catch (e) {
      log("Fatal Error in Get Top Rated API:- ${e.toString()}");
      return null;
    }
  }
}
