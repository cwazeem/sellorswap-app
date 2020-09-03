import 'package:flutter/material.dart';
import 'package:sell_or_swap/bloc/chat_home_bloc.dart';
import 'package:sell_or_swap/models/user.dart';
import 'package:sell_or_swap/networking/api_response.dart';
import 'package:sell_or_swap/screens/chat_home/component/chat_user_list.dart';

class ChatHomeScreen extends StatefulWidget {
  @override
  _ChatHomeScreenState createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  ChatHomeBloc _chatHomeBloc;
  @override
  void initState() {
    super.initState();
    _chatHomeBloc = ChatHomeBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Chats",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: StreamBuilder<Response<List<User>>>(
        stream: _chatHomeBloc.shopListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
                break;
              case Status.EMPTY:
                return Center(child: Text("Empty"));
                break;
              case Status.COMPLETED:
                return ChatUserList(user: snapshot.data.data);
                break;
              case Status.ERROR:
                return Center(
                  child: Text("Error " + snapshot.data.message),
                );
                break;
              default:
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text("Starting.."),
          );
        },
      ),
    );
  }
}
