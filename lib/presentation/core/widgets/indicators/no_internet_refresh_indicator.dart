import 'package:flutter/material.dart';
import 'package:static_i18n/static_i18n.dart';

class NoInternetRefreshIndicator extends StatelessWidget {
  const NoInternetRefreshIndicator({
    Key? key,
    required this.onRefreshPressed,
  }) : super(key: key);

  final VoidCallback onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('no network'.i18n),
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
