import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_feed/Data/Models/post_model.dart';
import 'package:news_feed/Data/Models/story_model.dart';
import 'package:news_feed/Data/Models/user_model.dart';
import 'package:news_feed/Data/WebServicrs/news_feed_web_services.dart';

part 'news_feed_state.dart';

class NewsFeedCubit extends Cubit<NewsFeedState> {
   NewsFeedWebSrevice _newsFeedWebSrevice;
   User? currentUser;
   List<User>? onlineUsers;
   List<Story>? usersStories;
   List<Post>? usersPosts;



   NewsFeedCubit(this._newsFeedWebSrevice) : super(NewsFeedInitial());

  static NewsFeedCubit get(context)=> BlocProvider.of(context);

   getCurentUser() {
    _newsFeedWebSrevice.getCurentUser().then((curent_user) {
      emit(LoadingCurentUserProfileState());
      this.currentUser=curent_user;
    }).catchError((onError){
      print("currentUser error  $onError");
    });
    return currentUser;
  }
   getOnlineUsets(){
     _newsFeedWebSrevice.getOnlineUsers().then((online_users){
       emit(LoadingOnlineUsersState());
       this.onlineUsers=online_users;
     }).catchError((onError){
       print("onlineUsers error  $onError");
     });
     return onlineUsers;
  }
  getUsersStories(){
     _newsFeedWebSrevice.getStories().then((stories){
       emit(LoadingStoriesUsersState());
       this.usersStories=stories;
     }).catchError((onError){
       print("stories error $onError");

     });
     return usersStories;
  }
   getUsersPosts(){
     _newsFeedWebSrevice.getPosts().then((posts){
       emit(LoadingStoriesUsersState());
       this.usersPosts=posts;
     }).catchError((onError){
       print("stories error $onError");

     });
     return usersPosts;
   }
}
