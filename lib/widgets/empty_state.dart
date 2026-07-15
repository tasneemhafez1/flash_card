import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onAdd;
  const EmptyState({super.key, required this.onAdd});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("No cards yet. Add one!"));
}
