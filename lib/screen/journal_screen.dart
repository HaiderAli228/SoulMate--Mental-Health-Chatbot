import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  final TextEditingController _entryController = TextEditingController();

  void _saveEntry(BuildContext context) {
    if (_entryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please write something before saving!'),
      ));
      return;
    }

    // Save journal entry logic goes here
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Journal entry saved!'),
    ));
    _entryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Write your thoughts:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _entryController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Type your journal entry here...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _saveEntry(context),
              child: Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}
