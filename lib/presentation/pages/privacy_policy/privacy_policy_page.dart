import 'package:flutter/material.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../core/widgets/common/simple_app_bar.dart';
import '../../i18n/translation_keys.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    const TextStyle headerStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
    const TextStyle paragraphStyle = TextStyle(fontSize: 15, height: 1.1);

    return Scaffold(
      appBar: SimpleAppBar(
        title: TkPagePrivacyPolicy.header.i18n,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          children: <Widget>[
            const SizedBox(height: 12),
            Text(
              'Last updated at September 29, 2021',
              style: TextStyle(fontSize: 13, color: theme.secondaryHeaderColor),
            ),
            const SizedBox(height: 24),
            const Text(
              'AGREEMENT TO TERMS',
              style: headerStyle,
            ),
            const SizedBox(height: 12),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel pellentesque quisque suspendisse risus sit ultrices sit. Habitant bibendum non tellus et id. Sed adipiscing sit ornare scelerisque vestibulum mi. In porttitor scelerisque tempus aliquet feugiat. Ultrices eget venenatis sagittis mattis. Massa egestas at varius interdum a vel vestibulum, leo, a. Phasellus elit, consectetur quis est congue purus. Amet vel nulla viverra gravida rhoncus. Velit, at venenatis, ipsum, eu. Libero congue odio mi, consectetur tellus. Bibendum egestas aliquam mauris aenean. Mi sed sollicitudin magna dignissim eros feugiat. Leo, iaculis massa scelerisque turpis purus posuere sollicitudin ornare mattis. Neque eget imperdiet pulvinar lobortis tincidunt. turpis purus posuere sollicitudin ornare mattis. Neque eget imperdiet.',
              style: paragraphStyle,
            ),
            const SizedBox(height: 12),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel pellentesque quisque suspendisse risus sit ultrices sit. Habitant bibendum non tellus et id. Sed adipiscing sit ornare scelerisque vestibulum mi. In porttitor scelerisque tempus aliquet feugiat. Ultrices eget venenatis sagittis mattis. Massa egestas at varius interdum a vel vestibulum, leo, a. Phasellus elit, consectetur quis est congue purus. Amet vel nulla viverra gravida rhoncus. Velit, at venenatis, ipsum, eu. Libero congue odio mi, consectetur tellus. Bibendum egestas aliquam mauris aenean. Mi sed sollicitudin magna dignissim eros feugiat. Leo, iaculis massa scelerisque turpis purus posuere sollicitudin ornare mattis. Neque eget imperdiet pulvinar lobortis tincidunt. turpis purus posuere sollicitudin ornare mattis. Neque eget imperdiet.',
              style: paragraphStyle,
            ),
            const SizedBox(height: 24),
            const Text(
              'INTELLECTUAL PROPERTY RIGHTS',
              style: headerStyle,
            ),
            const SizedBox(height: 12),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel pellentesque quisque suspendisse risus sit ultrices sit. Habitant bibendum non tellus et id. Sed adipiscing sit ornare scelerisque vestibulum mi. In porttitor scelerisque tempus aliquet feugiat. Ultrices eget venenatis sagittis mattis. Massa egestas at varius interdum a vel vestibulum, leo, a. Phasellus elit, consectetur quis est congue purus. Amet vel nulla viverra gravida rhoncus. Velit, at venenatis, ipsum, eu. Libero congue odio mi, consectetur tellus. Bibendum egestas aliquam mauris aenean. Mi sed sollicitudin magna dignissim eros feugiat. Leo, iaculis massa scelerisque turpis purus posuere sollicitudin ornare mattis. Neque eget imperdiet pulvinar lobortis tincidunt. turpis purus posuere sollicitudin ornare mattis. Neque eget imperdiet.',
              style: paragraphStyle,
            ),
          ],
        ),
      ),
    );
  }
}
