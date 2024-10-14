import 'package:flutter/material.dart';
import 'package:get/get.dart';

int _maxCharacters = 20;

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
        text: text.length > _maxCharacters ? '${text.substring(0, _maxCharacters)}...' : text,
        style: Get.theme.primaryTextTheme.labelLarge?.copyWith(),
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
      overflow: TextOverflow.ellipsis,

      textAlign: TextAlign.center,
      textScaleFactor: 1.0,
      maxLines: null,
      strutStyle: StrutStyle(fontWeight: FontWeight.bold),
      // textAlign: TextAlign.start,
    );
  }
}
