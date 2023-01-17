import 'package:flutter/material.dart';
import 'package:transisi/src/core/widgets/other/other_widget.dart';

import '../texts/sub_title_text.dart';

class ListTileCard extends OtherWidget {
  final Function()? onTap;
  final String title;
  final Widget leading;
  final String subtitle;
  final Widget? trailing;

  ListTileCard({
    required this.title,
    required this.leading,
    this.onTap,
    required this.subtitle,
    this.trailing,
  });
  @override
  Widget get child => GestureDetector(
        onTap: onTap,
        child: ListTile(
          title: Text(title),
          leading: leading,
          subtitle: SubTitleText(text: subtitle).child,
          trailing: trailing,
        ),
      );
}
