import 'package:flutter/material.dart';
import 'package:transisi/src/core/widgets/texts/general_text.dart';

class TitleText extends GeneralText {
  TitleText({
    String? text = "",
    double? fontSize = 18,
    FontWeight? fontWeight = FontWeight.w700,
    TextAlign? textAlign,
    Color? color,
  }) : super(
            text: text,
            textAlign: textAlign,
            style: TextStyle(
                fontSize: fontSize, fontWeight: fontWeight, color: color));

  @override
  Widget get child => Text(
        text!,
        style: style,
        textAlign: textAlign,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}
