import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormPlusLabel extends StatelessWidget {
  const FormPlusLabel({
    super.key,
    this.required = true,
    required this.text,
  });
  final bool required;
  final String text;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: Get.theme.primaryTextTheme.labelLarge,
        children: [
          if (required)
            TextSpan(
              locale: Get.locale,
              text: '•',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
        ],
      ),
      textScaleFactor: 1.0,
      maxLines: null,
      strutStyle: StrutStyle(fontWeight: FontWeight.w400),
      overflow: TextOverflow.fade,
      // textAlign: TextAlign.start,
    );
  }
}
