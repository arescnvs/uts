import 'package:flutter/material.dart';
import '../models/question.dart';

class AskQuestionScreen extends StatefulWidget {
  final String subject;

  AskQuestionScreen({required this.subject});

  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask a Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Question Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Question Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logika untuk mengirim pertanyaan baru
                Navigator.pop(context);
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
