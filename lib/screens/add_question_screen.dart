// add_question_screen.dart
import 'package:flutter/material.dart';
import '../models/question.dart';

class AddQuestionScreen extends StatefulWidget {
  final String subject;

  AddQuestionScreen({required this.subject});

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _submitQuestion() {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      Question newQuestion = Question(
        id: DateTime.now().millisecondsSinceEpoch,  // Pastikan id dibuat di sini
        title: _titleController.text,
        content: _contentController.text,
        subject: widget.subject,  // Sertakan subject
      );

      Navigator.pop(context, newQuestion);  // Kembali dengan objek Question
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Question for ${widget.subject}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Question Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Question Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitQuestion,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
