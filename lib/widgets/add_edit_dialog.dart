import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class AddEditDialog extends StatefulWidget {
  final Flashcard? flashcard;
  final List<Flashcard> existingCards;

  const AddEditDialog({
    super.key,
    this.flashcard,
    required this.existingCards,
  });

  @override
  State<AddEditDialog> createState() => _AddEditDialogState();
}

class _AddEditDialogState extends State<AddEditDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _questionController;
  late final TextEditingController _answerController;

  bool get _isEdit => widget.flashcard != null;

  @override
  void initState() {
    super.initState();
    _questionController =
        TextEditingController(text: widget.flashcard?.question ?? '');
    _answerController =
        TextEditingController(text: widget.flashcard?.answer ?? '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  String? _validateQuestion(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Question is required';
    if (text.length < 5) return 'Question must be at least 5 characters';
    if (text.length > 150) return 'Question must not exceed 150 characters';

    final exists = widget.existingCards.any((card) {
      if (_isEdit && card.id == widget.flashcard!.id) return false;
      return card.question.toLowerCase().trim() == text.toLowerCase();
    });

    if (exists) return 'This question already exists';
    return null;
  }

  String? _validateAnswer(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Answer is required';
    if (text.length < 2) return 'Answer must be at least 2 characters';
    if (text.length > 500) return 'Answer must not exceed 500 characters';
    return null;
  }

  void _save() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final card = Flashcard(
      id: widget.flashcard?.id ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      question: _questionController.text.trim(),
      answer: _answerController.text.trim(),
      createdAt: widget.flashcard?.createdAt ?? DateTime.now(),
    );

    Navigator.pop(context, card);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return AlertDialog(
      title: Text(_isEdit ? 'Edit Flashcard' : 'Add Flashcard'),
      content: SizedBox(
        width: width > 600 ? 450 : double.maxFinite,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _questionController,
                  textInputAction: TextInputAction.next,
                  maxLength: 150,
                  decoration: const InputDecoration(
                      labelText: 'Question',
                      prefixIcon: Icon(Icons.help_outline)),
                  validator: _validateQuestion,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _answerController,
                  maxLines: 5,
                  minLines: 3,
                  maxLength: 500,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      labelText: 'Answer',
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.lightbulb_outline)),
                  validator: _validateAnswer,
                  onFieldSubmitted: (_) => _save(),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        FilledButton.icon(
          onPressed: _save,
          icon: Icon(_isEdit ? Icons.save : Icons.add),
          label: Text(_isEdit ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}
