import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../data/models/song_model.dart';
import '../../../data/providers/itunes_provider.dart';

class HomeController extends GetxController {
  final _provider = ItunesProvider();
  final refreshController = RefreshController();

  final songs = <Song>[].obs;
  final filteredSongs = <Song>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;
  final sortBy = 'releaseDate'.obs;
  final hasNetwork = true.obs;

  // 分页相关
  final currentPage = 1.obs;
  final hasMore = true.obs;
  final isLoadingMore = false.obs;
  static const int pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    _initializeAndFetch();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> _initializeAndFetch() async {
    await checkAndUpdateNetworkStatus();
    if (hasNetwork.value) {
      await fetchSongs(isRefresh: true);
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

  Future<void> fetchSongs({bool isRefresh = false}) async {
    if (!hasNetwork.value) {
      error.value = '网络连接失败，请检查网络设置后重试';
      refreshController.refreshFailed();
      return;
    }

    try {
      if (isRefresh) {
        isLoading.value = true;
        currentPage.value = 1;
        hasMore.value = true;
      } else {
        isLoadingMore.value = true;
      }
      error.value = '';

      final fetchedSongs = await _provider.searchSongs(
        'taylor+swift',
        page: currentPage.value,
        pageSize: pageSize,
      );

      if (isRefresh) {
        songs.value = fetchedSongs;
        refreshController.refreshCompleted();
      } else {
        songs.addAll(fetchedSongs);
        refreshController.loadComplete();
      }

      hasMore.value = fetchedSongs.length >= pageSize;
      if (hasMore.value) {
        currentPage.value++;
      }

      _filterAndSortSongs();
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      if (isRefresh) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!isLoadingMore.value && hasMore.value && !isLoading.value) {
      await fetchSongs();
    }
  }

  Future<void> retryFetch() async {
    isLoading.value = true;
    await checkAndUpdateNetworkStatus();

    if (hasNetwork.value) {
      error.value = '';
      await fetchSongs(isRefresh: true);
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
