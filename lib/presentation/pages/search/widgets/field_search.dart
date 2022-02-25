import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/search/search_page_cubit.dart';
import '../../../i18n/translation_keys.dart';

class FieldSearch extends StatelessWidget {
  const FieldSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final UnderlineInputBorder inactiveBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: theme.secondaryHeaderColor),
    );
    const UnderlineInputBorder activeBorder = UnderlineInputBorder();

    return TextField(
      autofocus: true,
      maxLength: 255,
      decoration: InputDecoration(
        border: inactiveBorder,
        enabledBorder: inactiveBorder,
        disabledBorder: inactiveBorder,
        errorBorder: inactiveBorder,
        focusedBorder: activeBorder,
        focusedErrorBorder: activeBorder,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        filled: false,
        counterText: '',
        hintText: TkCommon.search.i18n,
      ),
      onChanged: context.read<SearchPageCubit>().onSearchQueryChanged,
    );
  }
}
