import 'package:flutter/material.dart';
import 'package:static_i18n/static_i18n.dart';

class UnknownErrorRefreshIndicator extends StatelessWidget {
  const UnknownErrorRefreshIndicator({
    super.key,
    required this.onRefreshPressed,
  });

  final VoidCallback onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('unknown error'.i18n),
        const SizedBox(width: 12),
        IconButton(
          onPressed: onRefreshPressed,
          icon: const Icon(Icons.refresh),
          splashRadius: 24,
        ),
      ],
    );
  }
}
