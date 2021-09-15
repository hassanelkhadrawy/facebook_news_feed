import 'package:flutter/material.dart';
import 'package:news_feed/Data/Models/user_model.dart';
import 'package:news_feed/Presintation/Widgets/Responsive.dart';
import 'package:news_feed/Presintation/Widgets/profile_avatar.dart';

import 'create_room_button.dart';
class Rooms extends StatelessWidget {
  final List<User>? onlineUsers;

  const Rooms({
    Key? key,
    required this.onlineUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isWeb = Responsive.isWeb(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: isWeb ? 5.0 : 0.0),
      elevation: isWeb ? 1.0 : 0.0,
      shape: isWeb
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
          : null,
      child: Container(
        height: 60.0,
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 4.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + onlineUsers!.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CreateRoomButton(),
              );
            }
            final User user = onlineUsers![index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProfileAvatar(
                imageUrl: user.imageUrl,
                isActive: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
