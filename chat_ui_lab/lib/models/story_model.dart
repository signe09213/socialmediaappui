import './post_model.dart';

class Story {
  final String userName;
  final String avatarUrl;
  final MediaType mediaType;
  final String mediaUrl;

  Story({
    required this.userName,
    required this.avatarUrl,
    required this.mediaType,
    required this.mediaUrl,
  });
}
