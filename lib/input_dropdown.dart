import 'package:flutter/material.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_plus/form_plus.dart';

class FormPlusSearchableDropdown<T, V> extends StatelessWidget {
  final FocusNode focusNode = FocusNode();
  final String hintText;
  final String label;
  final List<T> items;
  final String name;
  final bool enabled;
  final bool optional;
  final bool formEdition;

  final bool Function(T item1, T item2)? compareFn;
  final Widget Function(BuildContext context, T? item) dropdownBuilder;
  final void Function()? onTap;
  final void Function()? onReset;
  final String Function(T item) itemAsString;
  final void Function(T? value)? onSaved;
  final void Function(T? value)? onChanged;
  final String? Function(T?) addValidator;
  final V Function(T?)? valueTransformer;

  final Widget? suffixIcon;
  FormPlusSearchableDropdown({
    Key? key,
    required this.name,
    required this.items,
    required this.hintText,
    required this.label,
    required this.itemAsString,
    required this.dropdownBuilder,
    this.onTap,
    this.valueTransformer,
    this.onSaved,
    this.onReset,
    this.compareFn,
    this.onChanged,
    this.suffixIcon,
    this.formEdition = false,
    this.enabled = true,
    this.optional = false,
    String? Function(T?)? addValidator,
  })  : addValidator = addValidator ?? FormBuilderValidators.compose<T>([]),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ReusableBorderRadius(
      formEdition: formEdition,
      builder: (context, r, d) {
        return FormBuilderSearchableDropdown<T>(
          name: name,
          enabled: enabled,
          items: items,
          onReset: onReset,
          onSaved: onSaved,
          itemAsString: itemAsString,
          valueTransformer: valueTransformer,
          dropdownBuilder: dropdownBuilder,
          onChanged: onChanged,
          focusNode: focusNode,
          compareFn: compareFn,
          decoration: d.copyFrom(
            suffixIcon: suffixIcon,
            label: FormPlusLabel(text: label, required: !optional),
            hintText: hintText,
          ),
          validator: FormBuilderValidators.compose<T>(
            [
              if (!optional) FormBuilderValidators.required<T>(),
              addValidator,
            ],
          ),
          // elevation: 16,
        );
      },
    );
  }
}
