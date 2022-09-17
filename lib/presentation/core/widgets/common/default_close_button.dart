import 'package:flutter/material.dart';

class DefaultCloseButton extends StatelessWidget {
  const DefaultCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).maybePop(),
      icon: const Icon(Icons.close, size: 20),
      splashRadius: 24,
    );
  }
}
