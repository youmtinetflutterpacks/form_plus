import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_plus/lib.dart';

class FormPlusTextField<T> extends StatelessWidget {
  final String? initialValue;
  final FocusNode focusNode = FocusNode();
  final String name;
  final Widget label;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?) addValidator;
  final List<String> addAutoFillHints;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function()? onReset;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onSubmitted;
  final T Function(String?)? valueTransformer;
  //
  final bool formEdition;
  final bool optional;
  final bool multiLine;
  final bool password;

  final bool readOnly;
//
  final bool enabled;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool autofocus;
  final bool autocorrect;
  final bool expands;
  final bool enableSuggestions;
  final DragStartBehavior dragStartBehavior;
  final BoxWidthStyle selectionWidthStyle;
  final BoxHeightStyle selectionHeightStyle;

//
  final TextEditingController? controller;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;
  final void Function(PointerDownEvent)? onTapOutside;
  final ScrollController? scrollController;

  final TextStyle? style;
  FormPlusTextField({
    Key? key,
    required this.name,
    required this.hintText,
    required this.optional,
    required this.label,
    this.formEdition = false,
    this.onTap,
    this.onReset,
    this.onSaved,
    this.onChanged,
    this.style,
    this.suffixIcon,
    this.controller,
    this.onSubmitted,
    this.initialValue,
    this.valueTransformer,
    this.scrollController,
    this.onEditingComplete,
    this.maxLength,
    this.inputFormatters,
    this.buildCounter,
    this.onTapOutside,
    this.multiLine = false,
    this.password = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.expands = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableSuggestions = false,
    this.enableInteractiveSelection = true,
    String? Function(String?)? addValidator,
    this.addAutoFillHints = const [],
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.selectionHeightStyle = BoxHeightStyle.tight,
  })  : addValidator = addValidator ?? FormBuilderValidators.compose([]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    if (password) {
      keyboardType = TextInputType.text;
    } else {
      if (multiLine) {
        keyboardType = TextInputType.multiline;
      } else {
        keyboardType = this.keyboardType;
      }
    }
    return ReusableBorderRadius(
      formEdition: formEdition,
      builder: (context, r, d) {
        return FormBuilderTextField(
          name: name,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,

          obscureText: password,
          valueTransformer: valueTransformer,
          obscuringCharacter: '•',
          minLines: null,
          maxLines: multiLine ? 5 : 1,
          // expands: multiLine,
          initialValue: initialValue,
          validator: FormBuilderValidators.compose(
            [
              if (!optional && !password) FormBuilderValidators.required(),
              if (password) ...[
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
              ],
              addValidator,
            ],
          ),
          readOnly: readOnly,
          onTap: () {
            if (focusNode.hasFocus) {
              //   FocusManager.instance.primaryFocus?.unfocus();
              focusNode.unfocus();
            } else {
              focusNode.requestFocus();
            }
            onTap?.call();
          },
          inputFormatters: [
            ...(inputFormatters ?? []),
            FilteringTextInputFormatter.deny(RegExp('[${['"', "'"].join()}]')),
          ],
          onChanged: onChanged,
          cursorWidth: 5,
          autofillHints: addAutoFillHints,
          onEditingComplete: onEditingComplete,
          onReset: onReset,
          onSaved: onSaved,
          onSubmitted: onSubmitted,
          onTapOutside: (PointerDownEvent va) {
            onTapOutside?.call(va);
            focusNode.unfocus();
          },
          decoration: d.copyFrom(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            suffixIcon: suffixIcon,
            label: label,
            hintText: hintText,
          ),
          enabled: enabled,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          textCapitalization: textCapitalization,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          autofocus: autofocus,
          autocorrect: autocorrect,
          expands: expands,
          enableSuggestions: enableSuggestions,
          dragStartBehavior: dragStartBehavior,
          selectionWidthStyle: selectionWidthStyle,
          selectionHeightStyle: selectionHeightStyle,
          style: style,
          controller: controller,
          strutStyle: StrutStyle(),
          maxLength: maxLength,
          cursorRadius: Radius.circular(10),
          keyboardAppearance: Theme.of(context).brightness,
          buildCounter: buildCounter,
          showCursor: true,
          textAlignVertical: TextAlignVertical.center,
          scrollController: scrollController,
          scrollPhysics: BouncingScrollPhysics(),
          smartDashesType: SmartDashesType.enabled,
          smartQuotesType: SmartQuotesType.enabled,
          //   mouseCursor: MouseCursor,
        );
      },
    );
  }
}
