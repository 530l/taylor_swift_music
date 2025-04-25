import 'package:get/get.dart';
import '../../../data/models/song_model.dart';
import '../../../data/providers/itunes_provider.dart';

class HomeController extends GetxController {
  final _provider = ItunesProvider();

  final songs = <Song>[].obs;
  final filteredSongs = <Song>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;
  final sortBy = 'releaseDate'.obs;
  final hasNetwork = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeAndFetch();
  }

  Future<void> _initializeAndFetch() async {
    await checkAndUpdateNetworkStatus();
    if (hasNetwork.value) {
      await fetchSongs();
    }
  }

  Future<void> checkAndUpdateNetworkStatus() async {
    try {
      hasNetwork.value = await _provider.checkNetworkStatus();
      if (!hasNetwork.value) {
        error.value = '网络连接失败，请检查网络设置后重试';
      }
    } catch (e) {
      hasNetwork.value = false;
      error.value = '网络状态检查失败: $e';
    }
  }

  Future<void> fetchSongs() async {
    if (!hasNetwork.value) {
      error.value = '网络连接失败，请检查网络设置后重试';
      return;
    }

    try {
      isLoading.value = true;
      error.value = '';

      final fetchedSongs = await _provider.searchSongs('taylor+swift');
      songs.value = fetchedSongs;
      _filterAndSortSongs();
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> retryFetch() async {
    isLoading.value = true;
    await checkAndUpdateNetworkStatus();

    if (hasNetwork.value) {
      error.value = '';
      await fetchSongs();
    } else {
      error.value = '网络连接失败，请检查网络设置后重试';
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
