class Answer {
  final int id;
  final String content;
  int upvotes;
  int downvotes;
  bool isUpvoted;
  bool isDownvoted;

  Answer({
    required this.id,
    required this.content,
    this.upvotes = 0,
    this.downvotes = 0,
    this.isUpvoted = false,
    this.isDownvoted = false,
  });
}
