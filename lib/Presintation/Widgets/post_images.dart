import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PostImages extends StatelessWidget {
  final int maxImages;
  final List<String>? imageUrls;

  const PostImages({required this.imageUrls, this.maxImages = 4, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: (imageUrls!.length >= 3)
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.width / imageUrls!.length,
        crossAxisSpacing: .5,
        mainAxisSpacing: 2,
      ),
      children: buildImages(),
    );
  }

  buildImages() {
    int numImages = imageUrls!.length;
    return List<Widget>.generate(min(numImages, maxImages), (index) {
      String imageUrl = imageUrls![index];

      if (index == maxImages - 1) {
        int remaining = numImages - maxImages;

        if (remaining == 0) {
          return GestureDetector(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            onTap: () {},
          );
        } else {
          return GestureDetector(
            onTap: () {},
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: Text(
                      '+' + remaining.toString(),
                      style: TextStyle(fontSize: 32,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      } else {
        return GestureDetector(
          child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
          onTap: () {},
        );
      }
    });
  }
}
