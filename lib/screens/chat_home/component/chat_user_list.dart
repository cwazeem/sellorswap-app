import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sell_or_swap/constants.dart';
import 'package:sell_or_swap/models/user.dart';
import 'package:sell_or_swap/size_config.dart';

class ChatUserList extends StatelessWidget {
  final List<User> user;

  const ChatUserList({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: user.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: getUiWidth(45),
            height: getUiWidth(45),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.5),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    "https://randomuser.me/api/portraits/women/${index}.jpg"),
              ),
            ),
          ),
          title: Text("${user[index].name}"),
          subtitle: Text("${user[index].address.street}"),
          trailing: Container(
            width: getUiWidth(60),
            child: Column(
              children: [
                Text(
                  "07:05AM",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 12),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: kPrimaryGradientColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Center(
                        child: Text(
                      "NEW",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
