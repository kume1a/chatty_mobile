import 'package:flutter/material.dart';

class OverlayLoadingDialog extends StatelessWidget {
  const OverlayLoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
