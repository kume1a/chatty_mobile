import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/bloc_provider_alias.dart';
import '../di/di_config.dart';
import 'bl/core/shared_blocs/current_user_cubit.dart';
import 'core/routes/navigator_key_holder.dart';
import 'core/routes/route_generator.dart';
import 'core/values/themes.dart';
import 'i18n/app_locales.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProviderAlias>[
        BlocProvider<CurrentUserCubit>(
          create: (_) => getIt<CurrentUserCubit>()..init(),
        ),
      ],
      child: MaterialApp(
        title: 'chatty',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.routeFactory,
        initialRoute: Routes.root,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        navigatorKey: NavigatorKeyHolder.navigatorKey,
        locale: AppLocales.localeEn,
        localizationsDelegates: AppLocales.localizationsDelegates,
      ),
    );
  }
}
