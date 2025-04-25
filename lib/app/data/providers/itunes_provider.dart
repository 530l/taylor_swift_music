import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../models/song_model.dart';

class ItunesProvider {
  final Dio _dio = Dio()
    ..options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    );

  final String _baseUrl = 'https://itunes.apple.com';

  // 检查网络状态
  Future<bool> checkNetworkStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // 搜索歌曲
  Future<List<Song>> searchSongs(String term) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/search',
        queryParameters: {
          'term': term,
          'entity': 'song',
          'limit': '50',
        },
      );

      if (response.statusCode == 200) {
        // 确保响应数据是字符串类型，然后解码为Map
        final String responseString = response.data is String
            ? response.data
            : json.encode(response.data);
        final Map<String, dynamic> responseData = json.decode(responseString);

        if (responseData.containsKey('results')) {
          final List<dynamic> results =
              List<dynamic>.from(responseData['results']);
          final parsedSongs = <Song>[];

          for (var item in results) {
            try {
              if (item is Map<String, dynamic>) {
                final song = Song.fromJson(item);
                parsedSongs.add(song);
              }
            } catch (e) {
              print('单首歌曲解析失败: $e');
            }
          }

          return parsedSongs;
        } else {
          throw '返回数据格式错误：缺少 results 字段';
        }
      } else {
        throw '服务器响应错误: ${response.statusCode}';
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw '网络请求超时，请检查网络后重试';
        case DioExceptionType.connectionError:
          throw '网络连接失败，请检查网络设置';
        case DioExceptionType.badResponse:
          throw '服务器响应错误(${e.response?.statusCode})';
        default:
          throw '发生错误: ${e.message}';
      }
    } catch (e) {
      throw '未知错误: $e';
    }
  }
}
