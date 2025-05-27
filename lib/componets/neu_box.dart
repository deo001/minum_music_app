import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({
    required this.child,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
      // height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(3, 3)
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: const Offset(-3, -3)
          ),
        ]
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}