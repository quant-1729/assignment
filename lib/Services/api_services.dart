// post_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment/DTO/post_dto.dart';

class PostService {
  static const String url = "https://post-api-omega.vercel.app/api/posts?page=1";

  Future<List<PostDTO>> fetchPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => PostDTO.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load posts');
    }
  }
}
