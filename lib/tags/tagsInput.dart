import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../services/models.dart';

class TagInput extends StatefulWidget {
  final Function(List<String>) onSubmit;

  TagInput({
    required this.onSubmit,
  });

  @override
  _TagInputState createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final _tagController = TextEditingController();
  final List<String> tags = [];
  ButtonStyle lalpiwla = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black26),
    elevation: MaterialStatePropertyAll<double>(10),
  );

  void _addTag(String tag) {
    if (tag.isNotEmpty) {
      setState(() {
        tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: tags
              .map((tag) => InputChip(
                    label: Text(tag),
                    onDeleted: () => _removeTag(tag),
                  ))
              .toList(),
        ),
        Row(
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
              style: lalpiwla,
              onPressed: () {
                widget.onSubmit(tags);
                tags.clear();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}
