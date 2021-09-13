import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_feed/Data/Models/post_model.dart';
import 'package:news_feed/Data/WebServicrs/news_feed_web_services.dart';
import 'package:news_feed/Logic/news_feed_cubit.dart';
import 'package:news_feed/Presintation/Widgets/circle_button.dart';
import 'package:news_feed/Presintation/Widgets/post_container.dart';
import 'package:news_feed/Presintation/Widgets/upload_post_container.dart';
import 'package:news_feed/Presintation/Widgets/rooms.dart';
import 'package:news_feed/Presintation/Widgets/stories.dart';
import 'package:news_feed/Shared/styles.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
   List<Post>? post;
  Widget buildWidgets() {
    return BlocProvider(
      create: (BuildContext context) => NewsFeedCubit(NewsFeedWebSrevice()),
      child: BlocConsumer<NewsFeedCubit, NewsFeedState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                title: Text(
                  'facebook',
                  style: const TextStyle(
                    color: MainColors.facebookBlue,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2,
                  ),
                ),
                centerTitle: false,
                floating: true,
                actions: [
                  CircleButton(
                    icon: Icons.search,
                    iconSize: 30.0,
                    onPressed: () => print('Search'),
                  ),
                  CircleButton(
                    icon: MdiIcons.facebookMessenger,
                    iconSize: 30.0,
                    onPressed: () => print('Messenger'),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: CreatePostContainer(
                    currentUser: NewsFeedCubit.get(context).getCurentUser()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(
                  child: Rooms(onlineUsers: NewsFeedCubit.get(context).getOnlineUsets()),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(
                  child: Stories(
                    currentUser: NewsFeedCubit.get(context).getCurentUser(),
                    stories: NewsFeedCubit.get(context).getUsersStories(),
                  ),
                ),
              ),
              SliverList(

                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                       post = NewsFeedCubit.get(context).getUsersPosts();
                    return PostContainer(post: post![index]);
                  },
                  childCount: post?.length,
                ),
              ),

            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:buildWidgets()
    ) ;
  }
}
