import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../services/storage_service.dart';
import '../widgets/add_edit_dialog.dart';
import '../widgets/empty_state.dart';
import '../widgets/flashcard_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flashcard> _cards = [];
  bool _isLoading = true;
  bool _showAnswer = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    _cards = await StorageService.loadCards();
    if (_cards.isNotEmpty) {
      _currentIndex = 0;
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveCards() async {
    await StorageService.saveCards(_cards);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _addCard() async {
    final Flashcard? card = await showDialog<Flashcard>(
      context: context,
      builder: (_) => AddEditDialog(existingCards: _cards),
    );

    if (card == null) return;

    setState(() {
      _cards.add(card);
      _currentIndex = _cards.length - 1;
      _showAnswer = false;
    });

    await _saveCards();
    if (!mounted) return;
    _showSnackBar('Flashcard added successfully.');
  }

  Future<void> _editCard() async {
    if (_cards.isEmpty) return;

    final Flashcard? card = await showDialog<Flashcard>(
      context: context,
      builder: (_) => AddEditDialog(
        flashcard: _cards[_currentIndex],
        existingCards: _cards,
      ),
    );

    if (card == null) return;

    setState(() {
      _cards[_currentIndex] = card;
      _showAnswer = false;
    });

    await _saveCards();
    if (!mounted) return;
    _showSnackBar('Flashcard updated successfully.');
  }

  Future<void> _deleteCard() async {
    if (_cards.isEmpty) return;

    final bool? result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete')),
        ],
      ),
    );

    if (result != true) return;

    setState(() {
      _cards.removeAt(_currentIndex);
      if (_cards.isEmpty) {
        _currentIndex = 0;
      } else if (_currentIndex >= _cards.length) {
        _currentIndex = _cards.length - 1;
      }
      _showAnswer = false;
    });

    await _saveCards();
    if (!mounted) return;
    _showSnackBar('Flashcard deleted.');
  }

  void _nextCard() {
    if (_currentIndex >= _cards.length - 1) return;
    setState(() {
      _currentIndex++;
      _showAnswer = false;
    });
  }

  void _previousCard() {
    if (_currentIndex == 0) return;
    setState(() {
      _currentIndex--;
      _showAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flashcard Quiz')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addCard,
          icon: const Icon(Icons.add),
          label: const Text('Add'),
        ),
        body: EmptyState(onAdd: _addCard),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz'),
        actions: [
          IconButton(
            onPressed: _editCard,
            tooltip: 'Edit',
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: _deleteCard,
            tooltip: 'Delete',
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCard,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: FlashcardCard(
                  flashcard: _cards[_currentIndex],
                  showAnswer: _showAnswer,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => setState(() => _showAnswer = !_showAnswer),
                icon:
                    Icon(_showAnswer ? Icons.visibility_off : Icons.visibility),
                label: Text(_showAnswer ? 'Hide Answer' : 'Show Answer'),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _currentIndex == 0 ? null : _previousCard,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed:
                          _currentIndex == _cards.length - 1 ? null : _nextCard,
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Next'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Card ${_currentIndex + 1} of ${_cards.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
