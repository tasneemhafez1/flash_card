import 'dart:convert';

class Flashcard {
  final String id;
  final String question;
  final String answer;
  final DateTime createdAt;

  const Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  Flashcard copyWith({
    String? id,
    String? question,
    String? answer,
    DateTime? createdAt,
  }) {
    return Flashcard(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      id: map['id'] as String,
      question: map['question'] as String,
      answer: map['answer'] as String,
      createdAt: DateTime.parse(
        map['createdAt'] as String,
      ),
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory Flashcard.fromJson(String source) {
    return Flashcard.fromMap(
      jsonDecode(source),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Flashcard && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
