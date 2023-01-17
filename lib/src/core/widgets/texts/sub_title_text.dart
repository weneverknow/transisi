import 'package:flutter/material.dart';
import 'package:transisi/src/core/widgets/texts/general_text.dart';

class SubTitleText extends GeneralText {
  SubTitleText(
      {String? text = "",
      double? fontSize = 12,
      FontWeight? fontWeight = FontWeight.w300,
      TextAlign? textAlign,
      Color? color = Colors.grey})
      : super(
            text: text,
            textAlign: textAlign,
            style: TextStyle(
                fontSize: fontSize, fontWeight: fontWeight, color: color));

  @override
  Widget get child => Text(
        text!,
        style: style,
        textAlign: textAlign,
        maxLines: 2,
        overflow: TextOverflow.clip,
      );
}
