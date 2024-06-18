// post_service.dart
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:assignment/DTO/post_dto.dart';
import 'package:assignment/Services/Dbservices/database_services.dart';
class PostService {

  Future<List<PostDTO>> fetchPostsfromapi(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => PostDTO.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<PostDTO>> fetchPosts(BuildContext context ) async {
    DBservice dbservice= DBservice.db;
    try {
      // Check internet connection
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult
      .contains(ConnectivityResult.wifi)) {
        // Fetch posts from API
        print("Fetching from API");
        String apiUrl = 'https://post-api-omega.vercel.app/api/posts?page=1';
        List<PostDTO> posts = await fetchPostsfromapi(apiUrl);
        // Storing post in database
        if (posts.isNotEmpty) {
          // Store posts in the database

          await storePostsInDatabase(posts);
          print("Stored post in the database");
        }
        return posts;
      }
      else {
        print("No innernet connection");
        // If no internet, fetch posts from the database
        List<PostDTO> posts = await dbservice.getPosts();
        return posts;
      }
    }
    catch (e) {
      print("Unable to fetch the post");
      // Returning empty post
      return [];
    }
  }


  // Adding the post from the API to the database
  Future<void> storePostsInDatabase(List<PostDTO> posts) async {
    DBservice dbHelper = DBservice.db;
    for (var post in posts) {
      await dbHelper.insertPost(post);
    }
  }



}
