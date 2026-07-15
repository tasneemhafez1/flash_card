import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onDelete;

  const ActionButtons(
      {required this.onPrev, required this.onNext, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(onPressed: onPrev, icon: const Icon(Icons.arrow_back)),
      IconButton(onPressed: onNext, icon: const Icon(Icons.arrow_forward)),
      IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete, color: Colors.red)),
    ]);
  }
}
