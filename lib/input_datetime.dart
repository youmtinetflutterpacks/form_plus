import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_plus/form_plus.dart';
import 'package:get/get.dart';

class FormPlusDateTimeField extends StatelessWidget {
  final DateTime? initialValue;

  final FocusNode focusNode = FocusNode();
  //   //
  final String name;
  final String label;
  final String hintText;
  final TextInputAction textInputAction;
  final String? Function(DateTime?)? validator;
  final Widget? suffixIcon;
  final void Function(DateTime? value)? onChanged;
  final void Function()? onEditingComplete;
  final void Function()? onReset;
  final void Function(DateTime? value)? onSaved;
  final void Function(DateTime? value)? onSubmitted;
  //
  final bool formEdition;
  final bool optional;

  final bool readOnly;
  final DateTime? firstDate;
  final DateTime? lastDate;
//
  final bool enabled;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? style;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool expands;
  final bool Function(DateTime)? selectableDayPredicate;
  final dynamic Function(DateTime?) valueTransformer;
  final String? restorationId;
//
  final TextEditingController? controller;

  final InputType inputType;

  static final TimeOfDay? Function(DateTime? v) _timeOnlyTransformer = (DateTime? v) {
    if (v != null) {
      var timeOfDay = TimeOfDay.fromDateTime(v);
      return timeOfDay;
    } else {
      return null;
    }
  };
  static final DateTime? Function(DateTime? v) _datetimeTransformer = (DateTime? v) => v;

  final String? labelText;

  FormPlusDateTimeField({
    Key? key,
    this.inputType = InputType.both,
    required this.name,
    required this.label,
    required this.hintText,
    required this.optional,
    this.formEdition = false,
    this.labelText,
    this.firstDate,
    this.selectableDayPredicate,
    this.restorationId,
    this.lastDate,
    this.validator,
    this.initialValue,
    this.onChanged,
    this.onEditingComplete,
    this.onReset,
    this.onSaved,
    this.suffixIcon,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.readOnly = false,
    this.enabled = true,
    this.style,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.expands = false,
    this.controller,
  })  : valueTransformer = inputType == InputType.time ? _timeOnlyTransformer : _datetimeTransformer,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReusableBorderRadius(
      formEdition: formEdition,
      builder: (context, r, d) {
        return FormBuilderDateTimePicker(
          name: name,
          initialValue: initialValue is TimeOfDay
              ? DateTime.now().copyWith(
                  hour: initialValue?.hour,
                  minute: initialValue?.minute,
                )
              : initialValue,
          //   initialValue: initialValue,
          validator: FormBuilderValidators.compose(
            [
              if (!optional) FormBuilderValidators.required(),
              if (validator != null) (val) => validator?.call(valueTransformer.call(val)),
            ],
          ),
          focusNode: focusNode,
          keyboardType: TextInputType.datetime,
          textInputAction: textInputAction,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDatePickerMode: DatePickerMode.day,
          initialDate: DateTime.now(),
          currentDate: DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,

          restorationId: restorationId,
          selectableDayPredicate: selectableDayPredicate,
          valueTransformer: valueTransformer,
          locale: Get.locale,
          resetIcon: Icon(Icons.restart_alt_rounded),

          inputType: inputType,
          timePickerInitialEntryMode: TimePickerEntryMode.dialOnly,
          initialTime: TimeOfDay.now(),
          //
          anchorPoint: Offset.zero,
          helpText: hintText,
          onEditingComplete: onEditingComplete,
          onReset: onReset,
          onChanged: (val) => onSubmitted?.call(valueTransformer.call(val)),
          onSaved: (value) => onChanged?.call(valueTransformer.call(value)),
          onFieldSubmitted: (value) => onSubmitted?.call(valueTransformer.call(value)),
          enabled: enabled,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          textCapitalization: textCapitalization,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          expands: expands,
          style: style,
          controller: controller,
          fieldHintText: hintText,
          fieldLabelText: labelText,
          cursorRadius: Radius.circular(10),
          textAlignVertical: TextAlignVertical.center,
          decoration: d.copyFrom(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            //

            suffixIcon: suffixIcon,
            label: FormPlusLabel(text: label, required: !optional),
            hintText: hintText,
          ),
          //   mouseCursor: MouseCursor,
        );
      },
    );
  }
}
