import 'package:dio/dio.dart';
import '../models/song_model.dart';

class ItunesProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://itunes.apple.com';

  Future<List<Song>> searchSongs(String term) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/search',
        queryParameters: {'term': term, 'limit': 200, 'media': 'music'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => Song.fromJson(json)).toList();
      }
      throw Exception('Failed to load songs');
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
