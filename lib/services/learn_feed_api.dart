import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/feed_model.dart';
import '../models/filter_model.dart';
import 'config.dart';

/// The LearnFeed api houses the methods to fetch filters and feeds.
class LearnFeedApi {
  /// The dio provider.
  static final Dio _dio = Dio();

  /// Fetches the filters.
  Future<dynamic> fetchFilters() async {
    try {
      // Call the api.
      Response response = await _dio.get(
        Config.filterBaseURL,
      );

      // Check response code and convert to model, if success.
      if (response.statusCode == 200) {
        return FilterModel.fromJson(response.data);
      } else {
        throw 'Unknown error';
      }
    } on DioError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  /// Fetches the feeds.
  Future<FeedModel>? fetchFeeds() async {
    try {
      // Call the api.
      Response response = await _dio.get(Config.feedBastURL);

      // Check response code and convert to model, if success.
      if (response.statusCode == 200) {
        return FeedModel.fromJson(response.data);
      } else {
        throw 'Unknown error';
      }
    } on DioError catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}
