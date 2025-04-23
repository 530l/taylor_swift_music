import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/song_model.dart';

class HomeController extends GetxController {
  final songs = <Song>[].obs;
  final filteredSongs = <Song>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;
  final sortBy = 'releaseDate'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await http.get(
        Uri.parse(
          'https://itunes.apple.com/search?term=taylor+swift&entity=song&limit=50',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        songs.value = results.map((json) => Song.fromJson(json)).toList();
        _filterAndSortSongs();
      } else {
        error.value = '获取数据失败';
      }
    } catch (e) {
      error.value = '发生错误: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void searchSongs(String query) {
    searchQuery.value = query;
    _filterAndSortSongs();
  }

  void sortSongs(String? method) {
    if (method != null) {
      sortBy.value = method;
      _filterAndSortSongs();
    }
  }

  void _filterAndSortSongs() {
    List<Song> result = List.from(songs);

    // 搜索过滤
    if (searchQuery.isNotEmpty) {
      result = result.where((song) {
        return song.trackName
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            song.collectionName
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
      }).toList();
    }

    // 排序
    switch (sortBy.value) {
      case 'songName':
        result.sort((a, b) => a.trackName.compareTo(b.trackName));
        break;
      case 'albumName':
        result.sort((a, b) => a.collectionName.compareTo(b.collectionName));
        break;
      case 'releaseDate':
        result.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
        break;
    }

    filteredSongs.value = result;
  }
}
