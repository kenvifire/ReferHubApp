import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:ref_hub_app/components/widgets/text_field_tags.dart';
import 'package:ref_hub_app/models/referItem.dart';
import 'package:ref_hub_app/services/referral_service.dart';
import 'package:ref_hub_app/services/user_service.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ReferItemForm extends StatefulWidget {
  final ReferItem? item;
  ReferItemForm({this.item, Key? key}) : super(key: key);

  @override
  State<ReferItemForm> createState() => _ReferItemFormState();
}

class _ReferItemFormState extends State<ReferItemForm> {
  final _sl = GetIt.instance;
  final _formKey = GlobalKey<FormBuilderState>();
  String? codeLinkError;
  late String errMsg = "";
  bool showSpinner = false;
  bool enableEdit = false;
  late TextfieldTagsController _tagController;
  late double _distanceToField;

  @override
  void initState() {
    super.initState();
    enableEdit = widget.item == null;
    _tagController = TextfieldTagsController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _tagController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: FormBuilder(
        key: _formKey,
        child: ListView(
          children: [
            FormBuilderTextField(name: 'name',
              initialValue: widget.item?.title,
              enabled: enableEdit,
              decoration: InputDecoration(labelText: 'Enter name',

              errorText: codeLinkError ?? "", ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 6,
                  child: FormBuilderTextField(
                    enabled: enableEdit,
                    initialValue: widget.item?.link,
                    name: 'link',
                    decoration: InputDecoration(labelText: 'Enter link',
                      errorText: codeLinkError ?? ""
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.url(errorText: "Please enter valid url")
                    ]),
                  ),
                ),
                Flexible(
                  flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.copy),
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: widget.item!.code?? ""));
                      } ,
                    )
                )
              ],
            ),
            FormBuilderTextField(
              enabled: enableEdit,
              initialValue: widget.item?.code,
              name: 'code',
              decoration: const InputDecoration(labelText: "Enter code"),
            ),
            TagInput(initialTags: widget.item?.tags, tagController: _tagController, enabled: enableEdit, distanceToField: _distanceToField,),
            FormBuilderRadioGroup<String>(name: 'category',
                enabled: enableEdit,
                initialValue: widget.item?.category,
                decoration: const InputDecoration(labelText: 'Category for this referral'),
                options: const [
                  FormBuilderFieldOption(value: 'software'),
                  FormBuilderFieldOption(value: 'website'),
                  FormBuilderFieldOption(value: 'food'),
                  FormBuilderFieldOption(value: 'courses'),
                  FormBuilderFieldOption(value: 'others'),
                ]),
            FormBuilderTextField(name: 'description',
              enabled: enableEdit,
              initialValue: widget.item?.desc,
              decoration: const InputDecoration(labelText: 'Description for this referral'),
            ),
            FormBuilderSwitch(
              enabled: enableEdit,
              initialValue: widget.item?.enabled,
              decoration: const InputDecoration(labelText: 'Enable this referral'),
              name: 'enabled', title: Text('enabled'),

            ),
            Text(errMsg, style: const TextStyle(
                color: Colors.red
            ),
              textAlign: TextAlign.center,
            ),
            !enableEdit ? Container(): ElevatedButton(
                onPressed: () async {
              if(_formKey.currentState!.validate()) {

              } else {
                final link = _formKey.currentState!.fields['link']?.value;
                final code = _formKey.currentState!.fields['code']?.value;
                final name = _formKey.currentState!.fields['name']?.value;
                final desc = _formKey.currentState!.fields['description']?.value;
                final tags = _tagController.getTags;
                final category = _formKey.currentState!.fields['category']?.value;
                final uid = _sl.get<UserService>().getUser()!.uid;
                ReferItem item = ReferItem(id: widget.item?.id ?? null, uid: uid, title: name, tags: tags as List<String>, enabled: true,
                    category: category,
                    link: link, code: code, desc: desc);
                setState(() {
                  showSpinner = true;
                });
                try {
                  if(item.id == null) {
                    await _sl.get<ReferralService>().addReferral(item);
                  } else {
                    await _sl.get<ReferralService>().updateReferral(item);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch(e) {
                  setState(() {
                    showSpinner = false;
                  });
                }

              }

            },
                child: const Text('Submit')
            ),
            enableEdit? Container()
                :
                FloatingActionButton(
                  child: const Text('Edit'),
                    onPressed: () {
                    setState(() {
                      enableEdit = true;
                    });
                })

          ],
        ),
      ),
    );
  }
}
