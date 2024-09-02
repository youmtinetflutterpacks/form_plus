import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget labelRichText({required bool required, required String text, TextStyle? textStyle}) {
  return Builder(
    builder: (BuildContext context) {
      return RichText(
        locale: Get.locale,
        text: TextSpan(
          locale: Get.locale,
          text: text,
          style: textStyle,
          children: [
            if (required)
              TextSpan(
                locale: Get.locale,
                text: ' *',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
          ],
        ),
        textScaleFactor: 1.0,
        maxLines: null,
        strutStyle: StrutStyle(fontWeight: FontWeight.w100),
        overflow: TextOverflow.fade,
        // textAlign: TextAlign.start,
      );
    },
  );
}

Widget textRiche(String value, String label) {
  return Builder(builder: (context) {
    return RichText(
      locale: Get.locale,
      text: TextSpan(
        locale: Get.locale,
        children: [
          TextSpan(
            locale: Get.locale,
            text: label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          TextSpan(
            locale: Get.locale,
            text: value,
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.start,
      softWrap: true,
    );
  });
}
