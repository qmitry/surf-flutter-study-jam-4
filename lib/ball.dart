class Ball {
  final String answer;

  const Ball({
    required this.answer,
  });

  factory Ball.fromJson(Map<String, dynamic> json) {
    return Ball(
      answer: json['reading'],
    );
  }
}