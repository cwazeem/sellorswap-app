import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getUiWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/"),
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: getUiWidth(16), color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
