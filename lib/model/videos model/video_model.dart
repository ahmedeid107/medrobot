class VideoModel {
  final int id;
  final String videoUrl;
  final String videoName;
  final String duration;
  final String thumbnailUrl;

  VideoModel({
    required this.thumbnailUrl,
    required this.id,
    required this.videoUrl,
    required this.videoName,
    required this.duration,
  });

  // Factory constructor to create a Video instance from a JSON object
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as int,
      videoUrl: json['video_url'] as String,
      videoName: json['video_name'] as String,
      duration: json['duration'] as String,
      thumbnailUrl: json["thumbnail_url"],
    );
  }

  // Method to convert a Video instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'video_url': videoUrl,
      'video_name': videoName,
      'duration': duration,
      'thumbnail_url': thumbnailUrl,
    };
  }
}
