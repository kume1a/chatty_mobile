import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';

import '../../../core/values/assets.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _Item(),
        childCount: 20,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      color: theme.scaffoldBackgroundColor,
      child: Row(
        children: <Widget>[
          const SafeImage.withAssetPlaceholder(
            url: null,
            placeholderAssetPath: Assets.imageDefaultProfile,
            width: 46,
            height: 46,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'User name',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '8m',
                      style: TextStyle(fontSize: 13, color: theme.secondaryHeaderColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: theme.colorScheme.secondary,
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
