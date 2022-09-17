import 'package:flutter/material.dart';

class OverlayLoadingDialog extends StatelessWidget {
  const OverlayLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
