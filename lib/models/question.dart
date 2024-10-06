import '../models/answer.dart';

class Question {
  final int id;
  final String title;
  final String content;
  final String subject;
  int upvotes;
  int downvotes;
  bool isUpvoted;
  bool isDownvoted;
  List<Answer> answers;

  Question({
    required this.id,
    required this.title,
    required this.content,
    required this.subject,
    this.answers = const [],
    this.upvotes = 0,
    this.downvotes = 0,
    this.isUpvoted = false,
    this.isDownvoted = false,
  });
}
