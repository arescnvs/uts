import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/answer.dart';

class CommentScreen extends StatefulWidget {
  final Question question;

  CommentScreen({required this.question});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _answerController = TextEditingController();

  void _submitAnswer() {
    String content = _answerController.text.trim();
    if (content.isNotEmpty) {
      Answer newAnswer = Answer(
        id: DateTime.now().millisecondsSinceEpoch,
        content: content,
        upvotes: 0,
        downvotes: 0,
        isUpvoted: false,
        isDownvoted: false,
      );
      Navigator.pop(context, newAnswer); // Kembalikan jawaban baru ke layar sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Answer cannot be empty!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.question.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Your Answer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAnswer,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
