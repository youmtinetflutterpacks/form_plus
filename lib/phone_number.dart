import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_plus/lib.dart';

class FormPlusPhoneField<T> extends StatelessWidget {
  final String? initialValue;
  final FocusNode focusNode = FocusNode();
  final String name;
  final Widget label;
  final String hintText;
  final TextInputAction textInputAction;
  final String? Function(String?) addValidator;
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

//
  final bool enabled;
  final TextStyle? style;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final bool autofocus;
  final bool autocorrect;
  final bool expands;
  final List<String>? priorityListByIsoCode;
  final List<String>? countryFilterByIsoCode;
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

  FormPlusPhoneField({
    Key? key,
    required this.name,
    required this.hintText,
    required this.label,
    required this.optional,
    this.formEdition = false,
    this.onTap,
    this.style,
    this.priorityListByIsoCode,
    this.onReset,
    this.countryFilterByIsoCode,
    this.onSaved,
    this.onChanged,
    this.suffixIcon,
    this.controller,
    this.onSubmitted,
    this.initialValue,
    this.valueTransformer,
    this.onEditingComplete,
    this.maxLength,
    this.inputFormatters,
    this.buildCounter,
    this.onTapOutside,
    this.autofocus = false,
    this.autocorrect = true,
    this.expands = false,
    this.enabled = true,
    this.enableInteractiveSelection = true,
    String? Function(String?)? addValidator,
    this.textInputAction = TextInputAction.next,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20.0),
  })  : addValidator = addValidator ?? FormBuilderValidators.compose([]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReusableBorderRadius(
      formEdition: formEdition,
      builder: (context, r, d) {
        return FormBuilderPhoneField(
          name: name,
          focusNode: focusNode,
          keyboardType: TextInputType.phone,
          textInputAction: textInputAction,
          priorityListByIsoCode: priorityListByIsoCode,
          countryFilterByIsoCode: countryFilterByIsoCode,
          backgroundColor: Theme.of(context).colorScheme.background,
          itemBuilder: (country) => Text(country.phoneCode),
          defaultSelectedCountryIsoCode: 'MA',
          isCupertinoPicker: true,
          initialCountry: Country(
            isoCode: 'MA',
            phoneCode: '212',
            name: 'Morocco',
            iso3Code: 'MAR',
          ),
          valueTransformer: valueTransformer,
          // expands: multiLine,
          initialValue: initialValue,
          validator: FormBuilderValidators.compose(
            [
              if (!optional) FormBuilderValidators.required(),
              addValidator,
            ],
          ),
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
          onEditingComplete: onEditingComplete,
          onReset: onReset,
          onSaved: onSaved,
          onFieldSubmitted: onSubmitted,
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
          style: style,
          controller: controller,
          strutStyle: StrutStyle(),
          maxLength: maxLength,
          cursorRadius: Radius.circular(10),
          keyboardAppearance: Theme.of(context).brightness,
          buildCounter: buildCounter,
          showCursor: true,
          textAlignVertical: TextAlignVertical.center,
          //   mouseCursor: MouseCursor,
        );
      },
    );
  }
}
