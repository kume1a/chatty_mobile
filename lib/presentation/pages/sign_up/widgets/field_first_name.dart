import 'package:common_models/common_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../bl/sign_up/sign_up_page_cubit.dart';
import '../../../i18n/translation_keys.dart';

class FieldFirstName extends StatelessWidget {
  const FieldFirstName({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 255,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: TkCommon.firstName.i18n,
        counterText: '',
      ),
      onChanged: context.read<SignUpPageCubit>().onFirstNameChanged,
      validator: (_) => context.read<SignUpPageCubit>().state.firstName.value.fold(
            (NameFailure l) => l.when(
              empty: () => TkValidationError.fieldIsRequired.i18n,
              tooShort: () => TkValidationError.shortName.i18n,
            ),
            (_) => null,
          ),
    );
  }
}
