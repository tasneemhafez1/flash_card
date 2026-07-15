import '../models/flashcard.dart';

class DefaultFlashcards {
  static final List<Flashcard> cards = [
    Flashcard(
      id: '1',
      question: 'What is Flutter?',
      answer: 'Flutter is an open-source UI toolkit developed by Google.',
      createdAt: DateTime(2026, 1, 1),
    ),
    Flashcard(
      id: '2',
      question: 'Which language is used by Flutter?',
      answer: 'Flutter applications are written using Dart.',
      createdAt: DateTime(2026, 1, 2),
    ),
    Flashcard(
      id: '3',
      question: 'What is a StatefulWidget?',
      answer: 'A widget that can rebuild whenever its state changes.',
      createdAt: DateTime(2026, 1, 3),
    ),
    Flashcard(
      id: '4',
      question: 'What is a StatelessWidget?',
      answer: 'A widget that never changes after it is built.',
      createdAt: DateTime(2026, 1, 4),
    ),
    Flashcard(
      id: '5',
      question: 'What is Hot Reload?',
      answer:
          'A feature that updates the UI instantly without restarting the app.',
      createdAt: DateTime(2026, 1, 5),
    ),
    Flashcard(
      id: '6',
      question: 'What is Material Design?',
      answer:
          'A design system created by Google for building beautiful applications.',
      createdAt: DateTime(2026, 1, 6),
    ),
    Flashcard(
      id: '7',
      question: 'What is a BuildContext?',
      answer:
          'An object that provides information about the widget location in the widget tree.',
      createdAt: DateTime(2026, 1, 7),
    ),
    Flashcard(
      id: '8',
      question: 'What is SharedPreferences?',
      answer: 'A local storage solution used to save small amounts of data.',
      createdAt: DateTime(2026, 1, 8),
    ),
  ];
}
