import 'package:news_feed/Data/Models/user_model.dart';

class Post {
  final User user;
  final String caption;
  final String timeAgo;
  late final List<String>? imageUrl;
  final int likes;
  final int comments;
  final int shares;

   Post({
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
