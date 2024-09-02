import "package:flutter/material.dart";

class ReusableBorderRadius extends StatelessWidget {
  ReusableBorderRadius({
    super.key,
    required this.builder,
    this.formEdition = false,
  });

  final bool formEdition;
  final Widget Function(BuildContext context, BorderRadius borderRadius, InputDecoration inputDecoration) builder;

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(formEdition ? 10 : 24);

    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
        strokeAlign: 10,
        style: BorderStyle.solid,
      ),
      gapPadding: 10,
    );
    return builder(
      context,
      borderRadius,
      InputDecoration(
        filled: true,
        disabledBorder: InputBorder.none,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.background,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 32,
        ),
      ),
    );
  }
}
