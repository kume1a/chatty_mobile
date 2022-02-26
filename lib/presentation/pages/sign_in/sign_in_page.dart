import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:static_i18n/static_i18n.dart';

import '../../../di/di_config.dart';
import '../../bl/sign_in/sign_in_page_cubit.dart';
import '../../i18n/translation_keys.dart';
import 'widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInPageCubit>(
      create: (_) => getIt<SignInPageCubit>(),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 18);

    return TapOutsideToClearFocus(
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  <Widget>[
                    const LogoHeader(),
                    const SizedBox(height: 32),
                    Text(
                      TkCommon.signIn.i18n,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              SliverPadding(
                padding: padding,
                sliver: SliverToBoxAdapter(
                  child: BlocBuilder<SignInPageCubit, SignInPageState>(
                    buildWhen: (SignInPageState previous, SignInPageState current) =>
                        previous.showErrors != current.showErrors,
                    builder: (_, SignInPageState state) {
                      return ValidatedForm(
                        showErrors: state.showErrors,
                        child: Column(
                          children: const <Widget>[
                            FieldEmail(),
                            SizedBox(height: 16),
                            FieldPassword(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  <Widget>[
                    const SizedBox(height: 16),
                    const Padding(
                      padding: padding,
                      child: ButtonSignIn(),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      TkPageSignIn.captionContinueWith.i18n,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: padding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          ButtonGoogle(),
                          SizedBox(width: 18),
                          ButtonFacebook(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SliverFillRemaining(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: UnderCaption(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
