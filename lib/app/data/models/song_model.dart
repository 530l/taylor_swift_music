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
    return Song(
      trackName: json['trackName'] ?? '',
      artistName: json['artistName'] ?? '',
      collectionName: json['collectionName'] ?? '',
      artworkUrl100: json['artworkUrl100'] ?? '',
      trackPrice: (json['trackPrice'] ?? 0.0).toDouble(),
      releaseDate: DateTime.parse(
        json['releaseDate'] ?? DateTime.now().toIso8601String(),
      ),
      previewUrl: json['previewUrl']?.toString(),
      trackViewUrl: json['trackViewUrl']?.toString(),
      isStreamable: json['isStreamable'] ?? false,
      primaryGenreName: json['primaryGenreName']?.toString() ?? 'Unknown',
      currency: json['currency']?.toString() ?? 'USD',
    );
  }
}
