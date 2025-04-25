class Song {
  final String trackName;
  final String artistName;
  final String collectionName;
  final String artworkUrl100;
  final double trackPrice;
  final DateTime releaseDate;
  final String? previewUrl;
  final String? trackViewUrl;
  final bool isStreamable;
  final String primaryGenreName;
  final String currency;

  Song({
    required this.trackName,
    required this.artistName,
    required this.collectionName,
    required this.artworkUrl100,
    required this.trackPrice,
    required this.releaseDate,
    this.previewUrl,
    this.trackViewUrl,
    required this.isStreamable,
    required this.primaryGenreName,
    required this.currency,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    // 处理价格
    double parsePrice(dynamic value) {
      if (value == null) return 0.0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    // 处理布尔值
    bool parseBool(dynamic value) {
      if (value == null) return false;
      if (value is bool) return value;
      if (value is int) return value != 0;
      if (value is String) return value.toLowerCase() == 'true';
      return false;
    }

    try {
      return Song(
        trackName: json['trackName']?.toString() ?? '',
        artistName: json['artistName']?.toString() ?? '',
        collectionName: json['collectionName']?.toString() ?? '',
        artworkUrl100:
            (json['artworkUrl100'] ?? json['artworkUrl60'])?.toString() ?? '',
        trackPrice: parsePrice(json['trackPrice']),
        releaseDate: DateTime.parse(
          json['releaseDate']?.toString() ?? DateTime.now().toIso8601String(),
        ),
        previewUrl: json['previewUrl']?.toString(),
        trackViewUrl: json['trackViewUrl']?.toString(),
        isStreamable: parseBool(json['isStreamable']),
        primaryGenreName: json['primaryGenreName']?.toString() ?? 'Unknown',
        currency: json['currency']?.toString() ?? 'USD',
      );
    } catch (e) {
      print('Song解析错误: $e');
      print('原始数据: $json');
      rethrow;
    }
  }

  @override
  String toString() {
    return 'Song{trackName: $trackName, artistName: $artistName, price: $trackPrice}';
  }
}
