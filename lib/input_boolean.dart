import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_plus/form_plus.dart';

class FormPlusCheckbox<T> extends StatelessWidget {
  final bool? initialValue;

  final FocusNode focusNode = FocusNode();
  //   //
  final String name;
  final String label;
  final String hintText;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(bool? value)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onReset;
  final void Function(bool? value)? onSaved;
  //
  final bool formEdition;
  final bool optional;

  final bool readOnly;
//
  final bool enabled;
  final AutovalidateMode? autovalidateMode;
  final T Function(bool?)? valueTransformer;
  final Color? activeColor;

//
  final bool autofocus;

  FormPlusCheckbox({
    Key? key,
    required this.name,
    required this.label,
    required this.hintText,
    required this.optional,
    this.formEdition = false,
    String? Function(String?)? addValidator,
    this.initialValue,
    this.valueTransformer,
    this.activeColor,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onReset,
    this.onSaved,
    this.suffixIcon,
    this.readOnly = false,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReusableBorderRadius(
      formEdition: formEdition,
      builder: (context, r, d) {
        return FormBuilderCheckbox(
          name: name,
          focusNode: focusNode,
          title: FormPlusLabel(text: label, required: !optional),
          initialValue: initialValue,
          tristate: optional,
          validator: FormBuilderValidators.compose(
            [
              if (!optional) FormBuilderValidators.required(),
            ],
          ),
          subtitle: Text(hintText),
          onChanged: onChanged,
          onReset: onReset,
          onSaved: onSaved,
          secondary: suffixIcon,
          valueTransformer: valueTransformer,
          controlAffinity: ListTileControlAffinity.platform,
          decoration: d.copyFrom(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            suffixIcon: suffixIcon,
            label: FormPlusLabel(text: label, required: !optional),
            hintText: hintText,
          ),
          enabled: enabled,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          autofocus: autofocus,
          activeColor: activeColor,
        );
      },
    );
  }
}
