import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news_feed/Data/Models/post_model.dart';
import 'package:news_feed/Data/WebServicrs/news_feed_web_services.dart';
import 'package:news_feed/Logic/news_feed_cubit.dart';
import 'package:news_feed/Presintation/Widgets/Responsive.dart';
import 'package:news_feed/Presintation/Widgets/circle_button.dart';
import 'package:news_feed/Presintation/Widgets/contacts_list.dart';
import 'package:news_feed/Presintation/Widgets/more_options_list.dart';
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
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  Widget buildMobileWidgets() {
    return BlocProvider(
      create: (BuildContext context) => NewsFeedCubit(NewsFeedWebSrevice()),
      child: BlocConsumer<NewsFeedCubit, NewsFeedState>(
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScrollView(
            controller: _trackingScrollController,
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
                  child: Rooms(
                      onlineUsers: NewsFeedCubit.get(context).getOnlineUsets()),
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

  Widget build_Web_Widgets() {
    return BlocProvider(
      create: (BuildContext context) => NewsFeedCubit(NewsFeedWebSrevice()),
      child: BlocConsumer<NewsFeedCubit, NewsFeedState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MoreOptionsList(
                      currentUser:
                          NewsFeedCubit.get(context).getCurentUser()),
                ),
              ),
              const Spacer(),
              Container(
                width: 600.0,
                child: CustomScrollView(
                  controller: _trackingScrollController,

                  slivers: [

                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                      sliver: SliverToBoxAdapter(
                        child: Stories(
                          currentUser:
                              NewsFeedCubit.get(context).getCurentUser(),
                          stories: NewsFeedCubit.get(context).getUsersStories(),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CreatePostContainer(
                          currentUser:
                              NewsFeedCubit.get(context).getCurentUser()),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                      sliver: SliverToBoxAdapter(
                        child: Rooms(
                            onlineUsers:
                                NewsFeedCubit.get(context).getOnlineUsets()),
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
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ContactsList(
                        users: NewsFeedCubit.get(context).getOnlineUsets()),
                  ),
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: buildMobileWidgets(),
          web: build_Web_Widgets(),
        ),
      ),
    );
  }
}
