import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart' show AutovalidateMode, BuildContext, Colors, Container, EdgeInsets, FormFieldState, FormFieldValidator, Key, StatelessWidget, TextInputAction, Widget;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart' show FormBuilderValidators;
import 'package:get/get.dart';
import 'package:form_plus/form_plus.dart' show FormPlusLabel, InputDexoration, ReusableBorderRadius;

class FormPlusGeneralField<T> extends StatelessWidget {
  final T? initialValue;

  //   //
  final String name;
  final String label;
  final String hintText;
  final TextInputAction textInputAction;
  final FormFieldValidator<T>? validator;
  final void Function()? onTap;
  final void Function(T? value)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onReset;
  final void Function(T? value)? onSaved;
  final void Function(T? value)? onSubmitted;
  //
  final bool formEdition;
  final bool optional;

  final bool readOnly;
//
  final bool enabled;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;
  final BoxWidthStyle selectionWidthStyle;
  final BoxHeightStyle selectionHeightStyle;
  final T? Function(T? value) valueTransformer;

//

  FormPlusGeneralField({
    Key? key,
    required this.name,
    required this.label,
    required this.hintText,
    required this.optional,
    this.formEdition = false,
    required this.valueTransformer,
    FormFieldValidator<T>? addValidator,
    this.initialValue,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onReset,
    this.onSaved,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.selectionHeightStyle = BoxHeightStyle.tight,
  })  : validator = addValidator,
        super(key: key);

  /*
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      
      optional: optional,
      readOnly: (formEdition != null && !codeMatch) || readOnly,
      onEditingComplete: onEditingComplete,
      onSubmitted: (val) => onSubmitted?.call(value Transformer(val)),
      labelText: labelText,
      hintText: hintText,
      scrollPadding: scrollPadding,
      enableInteractiveSelection: enableInteractiveSelection,
      dragStartBehavior: dragStartBehavior,
      selectionWidthStyle: selectionWidthStyle,
      selectionHeightStyle: selectionHeightStyle, */
  @override
  Widget build(BuildContext context) {
    return ReusableBorderRadius(
      formEdition: formEdition,
      builder: (context, borderRadius, inputDecoration) => FormBuilderFieldDecoration<T>(
        name: name,
        builder: (FormFieldState<T> field) {
          return Container(
            color: Colors.grey,
            width: Get.width,
            height: 50,
          );
        },
        initialValue: initialValue,
        validator: FormBuilderValidators.compose(
          [
            if (!optional) FormBuilderValidators.required(),
            if (validator != null) (val) => validator?.call(valueTransformer(val)),
          ],
        ),
        decoration: inputDecoration.copyFrom(
          label: FormPlusLabel(text: label, required: !optional),
          hintText: hintText,
          //
        ),
        onChanged: (val) => onChanged?.call(valueTransformer(val)),
        onReset: onReset,
        onSaved: (val) => onSaved?.call(valueTransformer(val)),
        enabled: enabled,
        autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
      ),
    );
  }
}
