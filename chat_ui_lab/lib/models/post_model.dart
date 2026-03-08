enum MediaType { image, video }

class Post {
  final String userName;
  final String userAvatarUrl;
  final String mediaUrl;
  final MediaType mediaType;
  final String caption;
  int likes;
  final String comments;
  final String timestamp;
  bool isLiked;

  Post({
    required this.userName,
    required this.userAvatarUrl,
    required this.mediaUrl,
    required this.mediaType,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.timestamp,
    this.isLiked = false,
  });
}
