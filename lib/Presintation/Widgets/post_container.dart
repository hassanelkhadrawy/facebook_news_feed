import 'package:flutter/material.dart';
import 'package:news_feed/Data/Models/post_model.dart';
import 'package:news_feed/Presintation/Widgets/Responsive.dart';
import 'package:news_feed/Presintation/Widgets/post_header.dart';
import 'package:news_feed/Presintation/Widgets/post_images.dart';
import 'package:news_feed/Presintation/Widgets/post_states.dart';

class PostContainer extends StatelessWidget {
  final Post? post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isWeb = Responsive.isWeb(context);

    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isWeb ? 5.0 : 0.0,
      ),
      elevation: isWeb ? 1.0 : 0.0,
      shape: isWeb
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PostHeader(post: post!),
                  const SizedBox(height: 4.0),
                  Text(post!.caption),
                  post!.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post!.imageUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PostImages(
                      imageUrls: post!.imageUrl,
                      maxImages: 4,
                    ))
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: PostStats(post: post),
            ),
          ],
        ),
      ),
    );
  }
}
