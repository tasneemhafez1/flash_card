import 'package:shared_preferences/shared_preferences.dart';
import '../data/default_flashcards.dart';
import '../models/flashcard.dart';

class StorageService {
  StorageService._();

  static const String _storageKey = 'flashcards';

  static Future<List<Flashcard>> loadCards() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_storageKey);

    if (data == null || data.isEmpty) {
      await saveCards(DefaultFlashcards.cards);
      return List<Flashcard>.from(DefaultFlashcards.cards);
    }

    try {
      return data.map((item) => Flashcard.fromJson(item)).toList();
    } catch (_) {
      await saveCards(DefaultFlashcards.cards);
      return List<Flashcard>.from(DefaultFlashcards.cards);
    }
  }

  static Future<void> saveCards(List<Flashcard> flashcards) async {
    final prefs = await SharedPreferences.getInstance();
    final data = flashcards.map((card) => card.toJson()).toList();
    await prefs.setStringList(_storageKey, data);
  }
}
