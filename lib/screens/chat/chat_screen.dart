import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/models/chat_message.dart';
import 'package:sell_or_swap/models/user.dart';
import 'package:sell_or_swap/size_config.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({Key key, this.user}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List _messages = jsonDecode(messages);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.name}"),
        actions: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                  imageUrl: "https://randomuser.me/api/portraits/women/2.jpg"),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: _messages[index]['id'].toString().isEmpty
                        ? EdgeInsets.only(
                            bottom: 10,
                            right: SizeConfig.screenWidth * .25,
                          )
                        : EdgeInsets.only(
                            bottom: 10,
                            left: SizeConfig.screenWidth * .25,
                          ),
                    child: Column(
                      crossAxisAlignment:
                          _messages[index]['id'].toString().isEmpty
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _messages[index]['id'].toString().isEmpty
                                ? Colors.green.shade100
                                : Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _messages[index]['message'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.black),
                              ),
                              Text(
                                "${parse(_messages[index]['date']).toString().substring(11)}",
                                style: TextStyle(fontSize: 8),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  DateTime parse(int time) {
    return DateTime.fromMillisecondsSinceEpoch(time);
  }
}
