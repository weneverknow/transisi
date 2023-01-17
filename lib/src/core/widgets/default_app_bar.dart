import 'package:flutter/material.dart';

import 'texts/title_text.dart';

class DefaultAppBar {
  final String label;
  final List<Widget>? actions;
  DefaultAppBar({required this.label, this.actions});

  PreferredSizeWidget get appBar => AppBar(
        centerTitle: false,
        elevation: 0,
        title: TitleText(text: label).child,
        actions: actions,
      );
}
