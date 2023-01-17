import 'package:flutter/material.dart';
import 'package:transisi/src/core/widgets/buttons/general_button.dart';

import '../../constants/constants.dart';

class DefaultButton extends GeneralButton {
  DefaultButton({String? text = "SUBMIT", Function()? onPressed})
      : super(
          text: text,
          onPressed: onPressed,
        );
  @override
  Widget get child => ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding / 1.5)),
      onPressed: onPressed,
      child: Text(
        text!,
        style: const TextStyle(
          fontSize: 18,
        ),
      ));
}
