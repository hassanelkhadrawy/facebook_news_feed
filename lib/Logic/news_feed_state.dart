part of 'news_feed_cubit.dart';

@immutable
abstract class NewsFeedState {}

class NewsFeedInitial extends NewsFeedState {}

class LoadingCurentUserProfileState extends NewsFeedState{}

class LoadingOnlineUsersState extends NewsFeedState{}
class LoadingStoriesUsersState extends NewsFeedState{}
class LoadingPostsState extends NewsFeedState{}



