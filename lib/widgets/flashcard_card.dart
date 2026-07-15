import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardCard extends StatelessWidget {
  final Flashcard flashcard;
  final bool showAnswer;

  const FlashcardCard({
    super.key,
    required this.flashcard,
    required this.showAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 650,
          minHeight: 320,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: .95,
                  end: 1,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Card(
            key: ValueKey(
              '${flashcard.id}-$showAnswer',
            ),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: width > 600 ? 42 : 34,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Icon(
                      showAnswer ? Icons.lightbulb_rounded : Icons.quiz_rounded,
                      size: width > 600 ? 42 : 34,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    showAnswer ? 'Answer' : 'Question',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SelectableText(
                    showAnswer ? flashcard.answer : flashcard.question,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: width > 600 ? 24 : 20,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Chip(
                    avatar: const Icon(
                      Icons.swap_horiz_rounded,
                      size: 18,
                    ),
                    label: Text(
                      showAnswer ? 'Tap Hide Answer' : 'Tap Show Answer',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
