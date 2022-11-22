import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class TagInput extends StatefulWidget {
  const TagInput({Key? key, required this.initialTags,
    required this.tagController,
    required this.distanceToField,
    required this.enabled,
    }) : super(key: key);

  final TextfieldTagsController tagController;
  final List<String>? initialTags;
  final bool enabled;
  final double distanceToField;

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  // late final double _distanceToField;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      textfieldTagsController: widget.tagController,
      initialTags: widget.initialTags,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (widget.tagController.getTags!.contains(tag)) {
          return 'you already entered that';
        }
        return null;
      },
      inputfieldBuilder:
          (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              enabled: widget.enabled,
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 3.0,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 74, 137, 92),
                    width: 3.0,
                  ),
                ),
                helperText: 'Enter tag...',
                helperStyle: const TextStyle(
                  color: Color.fromARGB(255, 74, 137, 92),
                ),
                hintText: widget.tagController.hasTags ? '' : "Enter tag...",
                errorText: error,
                prefixIconConstraints:
                BoxConstraints(maxWidth: widget.distanceToField * 0.74),
                prefixIcon: tags.isNotEmpty
                    ? SingleChildScrollView(
                  controller: sc,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: tags.map((String tag) {
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color: Color.fromARGB(255, 74, 137, 92),
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Text(
                                  '#$tag',
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                                onTap: () {
                                  print("$tag selected");
                                },
                              ),
                              const SizedBox(width: 4.0),
                              InkWell(
                                child: const Icon(
                                  Icons.cancel,
                                  size: 14.0,
                                  color: Color.fromARGB(
                                      255, 233, 233, 233),
                                ),
                                onTap: () {
                                  onTagDelete(tag);
                                },
                              )
                            ],
                          ),
                        );
                      }).toList()),
                )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          );
        });
      },
    );

  }
}
