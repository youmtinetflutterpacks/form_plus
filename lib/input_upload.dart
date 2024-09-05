import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_plus/form_plus.dart';

class EPWFileUploads extends StatelessWidget {
  final bool optional;
  final bool formEdition;

  final String name;

  final String label;
  final String hintText;
  final bool allowMultiple;
  EPWFileUploads({
    super.key,
    required this.name,
    this.optional = false,
    this.formEdition = false,
    this.initialValue,
    required this.hintText,
    required this.label,
    this.allowMultiple = false,
  });
  final List<PlatformFile>? initialValue;
  @override
  Widget build(BuildContext context) {
    return ReusableBorderRadius(
        formEdition: formEdition,
        builder: (context, r, InputDecoration d) {
          return FormBuilderFilePicker(
            name: name,
            allowMultiple: allowMultiple,
            allowedExtensions: const ['png', 'jpg', 'pdf'],
            previewImages: true,
            withData: true,
            initialValue: initialValue,
            typeSelectors: [
              TypeSelector(
                type: FileType.custom,
                selector: Icon(
                  Icons.image_rounded,
                ),
              ),
            ],
            validator: FormBuilderValidators.compose(
              [
                if (!optional) FormBuilderValidators.required(),
              ],
            ),
            decoration: d.copyFrom(
              label: FormPlusLabel(text: label, required: !optional),
              hintText: hintText,
            ),
          );
        });
  }
}
