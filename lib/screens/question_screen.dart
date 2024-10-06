import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/answer.dart';
import '../widgets/question_tile.dart';
import '../screens/comment_screen.dart';

class QuestionScreen extends StatefulWidget {
  final String subject;

  QuestionScreen({required this.subject});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    loadQuestionsBySubject(widget.subject);
  }

  void loadQuestionsBySubject(String subject) {
    // Load questions based on the subject
    if (subject == "Matematika") {
      questions = [
        Question(
          id: 1,
          title: "Apa hasil dari 2 + 2?",
          content: "Saya masih belum mengerti penjumlahan dasar.",
          subject: "Matematika",
          answers: [
            Answer(id: 1, content: "Jawabannya adalah 4", upvotes: 0, downvotes: 0),
            Answer(id: 2, content: "Gunakan kalkulator untuk membantumu!", upvotes: 0, downvotes: 0),
          ],
        ),
        Question(
          id: 2,
          title: "Bagaimana cara menghitung persentase?",
          content: "Tolong jelaskan bagaimana cara menghitung persentase dalam matematika.",
          subject: "Matematika",
          answers: [
            Answer(id: 3, content: "Persentase adalah bagian dari 100.", upvotes: 0, downvotes: 0),
            Answer(id: 4, content: "Anda perlu membagi angka dan mengalikannya dengan 100.", upvotes: 0, downvotes: 0),
          ],
        ),
      ];
    } else if (subject == "Sains") {
      questions = [
        Question(
          id: 3,
          title: "Apa itu fotosintesis?",
          content: "Bagaimana tanaman menghasilkan makanan?",
          subject: "Sains",
          answers: [
            Answer(id: 5, content: "Fotosintesis adalah proses di mana tanaman membuat makanannya.", upvotes: 0, downvotes: 0),
          ],
        ),
        Question(
          id: 4,
          title: "Apa itu gravitasi?",
          content: "Kenapa benda jatuh ke tanah?",
          subject: "Sains",
          answers: [
            Answer(id: 6, content: "Gravitasi adalah gaya yang menarik benda ke pusat bumi.", upvotes: 0, downvotes: 0),
          ],
        ),
      ];
    } else if (subject == "Bahasa") {
      questions = [
        Question(
          id: 5,
          title: "Apa perbedaan antara kata benda dan kata kerja?",
          content: "Saya bingung membedakan kata benda dan kata kerja.",
          subject: "Bahasa",
          answers: [
            Answer(id: 7, content: "Kata benda adalah nama benda, sementara kata kerja adalah tindakan.", upvotes: 0, downvotes: 0),
          ],
        ),
        Question(
          id: 6,
          title: "Bagaimana cara membuat kalimat yang benar?",
          content: "Saya ingin tahu aturan membuat kalimat.",
          subject: "Bahasa",
          answers: [
            Answer(id: 8, content: "Gunakan subjek, predikat, dan objek dalam kalimat.", upvotes: 0, downvotes: 0),
          ],
        ),
      ];
    } else if (subject == "Musik") {
      questions = [
        Question(
          id: 7,
          title: "Apa itu not balok?",
          content: "Saya ingin belajar membaca not balok.",
          subject: "Musik",
          answers: [
            Answer(id: 9, content: "Not balok adalah sistem penulisan nada dalam musik.", upvotes: 0, downvotes: 0),
          ],
        ),
        Question(
          id: 8,
          title: "Bagaimana cara memainkan gitar?",
          content: "Saya ingin belajar dasar-dasar bermain gitar.",
          subject: "Musik",
          answers: [
            Answer(id: 10, content: "Mulailah dengan mempelajari akord dasar seperti C, G, dan D.", upvotes: 0, downvotes: 0),
          ],
        ),
      ];
    }
    // Sort the questions initially
    sortQuestions();
  }

  void sortQuestions() {
    // Sort questions by upvotes in descending order
    questions.sort((a, b) => b.upvotes.compareTo(a.upvotes));
  }

  void sortAnswers(Question question) {
    // Sort answers by upvotes in descending order
    question.answers.sort((a, b) => b.upvotes.compareTo(a.upvotes));
  }

  void _addQuestion(Question newQuestion) {
    setState(() {
      questions.add(newQuestion);
      sortQuestions(); // Re-sort questions when a new one is added
    });
  }

  void _onAnswerUpvote(Answer answer, Question question) {
    setState(() {
      answer.isUpvoted = !answer.isUpvoted;
      if (answer.isUpvoted) {
        answer.upvotes++;
        if (answer.isDownvoted) {
          answer.isDownvoted = false;
          answer.downvotes--;
        }
      } else {
        answer.upvotes--;
      }
      sortAnswers(question); // Sort answers after an upvote
    });
  }

  void _onAnswerDownvote(Answer answer, Question question) {
    setState(() {
      answer.isDownvoted = !answer.isDownvoted;
      if (answer.isDownvoted) {
        answer.downvotes++;
        if (answer.isUpvoted) {
          answer.isUpvoted = false;
          answer.upvotes--;
        }
      } else {
        answer.downvotes--;
      }
      sortAnswers(question); // Sort answers after a downvote
    });
  }

  void _onQuestionUpvote(Question question) {
    setState(() {
      question.isUpvoted = !question.isUpvoted;
      if (question.isUpvoted) {
        question.upvotes++;
        if (question.isDownvoted) {
          question.isDownvoted = false;
          question.downvotes--;
        }
      } else {
        question.upvotes--;
      }
      sortQuestions(); // Re-sort questions after an upvote
    });
  }

  void _onQuestionDownvote(Question question) {
    setState(() {
      question.isDownvoted = !question.isDownvoted;
      if (question.isDownvoted) {
        question.downvotes++;
        if (question.isUpvoted) {
          question.isUpvoted = false;
          question.upvotes--;
        }
      } else {
        question.downvotes--;
      }
      sortQuestions(); // Re-sort questions after a downvote
    });
  }

  Future<void> _navigateToCommentScreen(Question question) async {
    final newAnswer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentScreen(question: question),
      ),
    );

    if (newAnswer != null) {
      setState(() {
        question.answers.add(newAnswer);
        sortAnswers(question); // Sort answers after a new answer is added
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Questions'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              TextEditingController titleController = TextEditingController();
              TextEditingController contentController = TextEditingController();

              await showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Add a New Question'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(hintText: 'Question Title'),
                        ),
                        TextField(
                          controller: contentController,
                          decoration: InputDecoration(hintText: 'Question Description'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          String title = titleController.text;
                          String content = contentController.text;

                          if (title.isNotEmpty && content.isNotEmpty) {
                            Question newQuestion = Question(
                              id: DateTime.now().millisecondsSinceEpoch,
                              title: title,
                              content: content,
                              subject: widget.subject,
                              answers: [],
                              upvotes: 0,
                              downvotes: 0,
                              isUpvoted: false,
                              isDownvoted: false,
                            );
                            _addQuestion(newQuestion);
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill in all fields.')),
                            );
                          }
                        },
                        child: Text('Add'),
                      ),
                    ],

                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return QuestionTile(
            question: questions[index],
            onAnswerUpvote: (answer) => _onAnswerUpvote(answer, questions[index]),
            onAnswerDownvote: (answer) => _onAnswerDownvote(answer, questions[index]),
            onQuestionUpvote: () => _onQuestionUpvote(questions[index]),
            onQuestionDownvote: () => _onQuestionDownvote(questions[index]),
            onAddAnswer: () => _navigateToCommentScreen(questions[index]),
          );
        },
      ),
    );
  }
}
