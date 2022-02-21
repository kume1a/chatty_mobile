import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../di/di_config.dart';
import '../../bl/sign_up/sign_up_page_cubit.dart';
import '../../core/widgets/common/simple_app_bar.dart';
import '../../i18n/translation_keys.dart';
import 'widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpPageCubit>(
      create: (_) => getIt<SignUpPageCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: TkCommon.signUp.i18n),
      body: SafeArea(
        child: BlocBuilder<SignUpPageCubit, SignUpPageState>(
          buildWhen: (SignUpPageState previous, SignUpPageState current) =>
              previous.showErrors != current.showErrors,
          builder: (_, SignUpPageState state) {
            return ValidatedForm(
              showErrors: state.showErrors,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 32, 18, 18),
                children: const <Widget>[
                  FieldFirstName(),
                  SizedBox(height: 20),
                  FieldLastName(),
                  SizedBox(height: 20),
                  FieldEmail(),
                  SizedBox(height: 20),
                  FieldPassword(),
                  SizedBox(height: 20),
                  FieldRepeatPassword(),
                  SizedBox(height: 16),
                  Conditions(),
                  SizedBox(height: 32),
                  ButtonSignUp(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
