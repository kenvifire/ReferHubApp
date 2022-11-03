import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ReferItemForm extends StatefulWidget {
  const ReferItemForm({Key? key}) : super(key: key);

  @override
  State<ReferItemForm> createState() => _ReferItemFormState();
}

class _ReferItemFormState extends State<ReferItemForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _referLinkFieldKey = GlobalKey<FormBuilderFieldState>();
  final _codeFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderTextField(name: 'name',
            decoration: const InputDecoration(labelText: 'Enter name'),
          ),
          FormBuilderTextField(
            key: _referLinkFieldKey,
            name: 'refer link',
            decoration: const InputDecoration(labelText: 'Enter link'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.url()
            ]),
          ),
          FormBuilderTextField(
            key: _codeFieldKey,
            name: 'code',
            decoration: const InputDecoration(labelText: "Enter code"),
          ),
          FormBuilderCheckboxGroup<String>(name: 'tags',
              decoration: const InputDecoration(labelText: 'Tags for this referral'),
              options: const [
                FormBuilderFieldOption(value: 'software'),
                FormBuilderFieldOption(value: 'website'),
                FormBuilderFieldOption(value: 'food'),
                FormBuilderFieldOption(value: 'courses'),
                FormBuilderFieldOption(value: 'others'),
              ]),
          FormBuilderTextField(name: 'description',
            decoration: const InputDecoration(labelText: 'Description for this referral'),
          ),
          ElevatedButton(onPressed: () {
            if(_formKey.currentState!.validate()) {

            }

          },
              child: const Text('Submit')
          ),

        ],
      ),
    );
  }
}
