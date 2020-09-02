import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class HaveAccountText extends StatelessWidget {
  const HaveAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Have an account? ",
          style: TextStyle(fontSize: getUiWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/signin"),
          child: Text(
            "Sign in",
            style: TextStyle(fontSize: getUiWidth(16), color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
