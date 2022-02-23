import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bl/search/search_page_cubit.dart';
import '../../../core/values/assets.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (_, index) => const _Item(),
      itemCount: 10,
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: context.read<SearchPageCubit>().onUserPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Row(
          children: const <Widget>[
            SafeImage.withAssetPlaceholder(
              url: null,
              placeholderAssetPath: Assets.imageDefaultProfile,
              width: 42,
              height: 42,
            ),
            SizedBox(width: 10),
            Text(
              'name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
