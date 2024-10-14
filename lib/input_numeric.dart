import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;
import 'package:flutter/gestures.dart' show DragStartBehavior, PointerDownEvent;
import 'package:flutter/material.dart' show AutovalidateMode, BuildContext, EdgeInsets, FocusNode, FormFieldValidator, Icon, Icons, Key, StatelessWidget, TextInputAction, TextInputType, Widget;
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart' show FormBuilderValidators;
import 'package:form_plus/form_plus.dart' show FormPlusTextField;

class FormPlusNumericField<T> extends StatelessWidget {
  final String? initialValue;

  final FocusNode focusNode = FocusNode();
  //   //
  final String name;
  final String label;
  final String hintText;
  final TextInputAction textInputAction;
  final FormFieldValidator<num>? validator;
  final void Function()? onTap;
  final void Function()? onReset;
  final void Function()? onEditingComplete;
  final void Function(num? value)? onSaved;
  final void Function(num? value)? onChanged;
  final void Function(num? value)? onSubmitted;
  //
  final bool formEdition;
  final bool optional;

  final bool readOnly;
//
  final bool enabled;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool autofocus;
  final bool expands;
  final DragStartBehavior dragStartBehavior;
  final BoxWidthStyle selectionWidthStyle;
  final BoxHeightStyle selectionHeightStyle;
  final num? Function(String? value) valueTransformer;

//
  final Widget? Function(
    BuildContext, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  })? buildCounter;
  final void Function(PointerDownEvent)? onTapOutside;

  static final int? Function(String? v) _intTryParse = (String? v) => v != null ? int.tryParse(v) : null;
  static final double? Function(String? v) _doubleTryParse = (String? v) => v != null ? double.tryParse(v) : null;

  FormPlusNumericField({
    Key? key,
    required this.name,
    required this.hintText,
    required this.optional,
    required this.label,
    this.formEdition = false,
    FormFieldValidator<num>? addValidator,
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
    this.autofocus = false,
    this.expands = false,
    this.dragStartBehavior = DragStartBehavior.start,
    this.selectionWidthStyle = BoxWidthStyle.tight,
    this.selectionHeightStyle = BoxHeightStyle.tight,
    this.buildCounter,
    this.onTapOutside,
  })  : validator = addValidator,
        valueTransformer = T is int
            ? _intTryParse
            : T is double
                ? _doubleTryParse
                : _intTryParse,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormPlusTextField<num?>(
      name: name,
      initialValue: initialValue,
      addValidator: FormBuilderValidators.compose(
        [
          FormBuilderValidators.numeric(),
          if (validator != null) (val) => validator?.call(valueTransformer.call(val)),
        ],
      ),
      onChanged: (val) {
        onSubmitted?.call(valueTransformer.call(val));
      },
      valueTransformer: valueTransformer,
      onSaved: (value) {
        onChanged?.call(valueTransformer.call(value));
      },
      enabled: enabled,
      onReset: () {
        onReset?.call();
      },
      autovalidateMode: autovalidateMode,
      keyboardType: T is int
          ? TextInputType.numberWithOptions(
              decimal: false,
              signed: true,
            )
          : TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textInputAction: textInputAction,
      suffixIcon: Icon(Icons.numbers),
      optional: optional,
      label: label,
      hintText: hintText,
      formEdition: formEdition,
      password: false,
      readOnly: readOnly,
      onEditingComplete: onEditingComplete,
      onTapOutside: (PointerDownEvent va) {
        onTapOutside?.call(va);
        focusNode.unfocus();
      },
      scrollPadding: scrollPadding,
      enableInteractiveSelection: enableInteractiveSelection,
      autofocus: autofocus,
      expands: expands,
      dragStartBehavior: dragStartBehavior,
      selectionWidthStyle: selectionWidthStyle,
      selectionHeightStyle: selectionHeightStyle,
      buildCounter: buildCounter,
      //   mouseCursor: MouseCursor,
      onTap: () {
        if (focusNode.hasFocus) {
          //   FocusManager.instance.primaryFocus?.unfocus();
          focusNode.unfocus();
        } else {
          focusNode.requestFocus();
        }
        onTap?.call();
      },
    );
  }
}


/* 
import 'package:http/http.dart' show get;
import 'dart:async' show Stream,StreamController;
import 'dart:convert' show json;
class ApiStream {
  final StreamController<List<dynamic>> _controller = StreamController<List<dynamic>>();

  Stream<List<dynamic>> get stream => _controller.stream;

  void fetchData() async {
    final response = await get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _controller.add(data);
    } else {
      _controller.addError('Failed to load data');
    }
  }

  void dispose() {
    _controller.close();
  }
}
 */