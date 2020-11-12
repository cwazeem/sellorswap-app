import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:loading_animations/loading_animations.dart';

class LoadingModal extends StatelessWidget {
  final Widget child;
  final bool loading;
  const LoadingModal({Key key, this.child, this.loading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      dismissible: false,
      color: Colors.black,
      opacity: .5,
      inAsyncCall: loading,
      progressIndicator: LoadingBouncingGrid.circle(
        borderColor: Colors.cyan,
        backgroundColor: Colors.cyan,
        size: 50.0,
      ),
      child: child,
    );
  }
}
