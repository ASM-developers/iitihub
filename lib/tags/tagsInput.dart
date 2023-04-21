import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../services/models.dart';

class TagInput extends StatefulWidget {
  final Function(List<String>) onSubmit;
  User someone = User();
  TagInput({required this.onSubmit, required this.someone});

  @override
  _TagInputState createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final _tagController = TextEditingController();
  final List<String> tags = [];

  void _addTag(String tag) {
    if (tag.isNotEmpty) {
      setState(() {
        tags.add(tag);
        _tagController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _tagController,
            decoration: InputDecoration(
              hintText: 'Add tags',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (tag) {
              _addTag(tag.trim());
            },
            onChanged: (tag) {
              if (tag.endsWith(' ')) {
                _addTag(tag.trim());
              }
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(tags);
            tags.clear();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
