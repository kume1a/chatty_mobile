import 'package:flutter/material.dart';

import 'core/routes/navigator_key_holder.dart';
import 'core/routes/route_generator.dart';
import 'core/values/themes.dart';
import 'i18n/app_locales.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chatty',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.routeFactory,
      initialRoute: Routes.root,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      navigatorKey: NavigatorKeyHolder.navigatorKey,
      locale: AppLocales.localeEn,
      localizationsDelegates: AppLocales.localizationsDelegates,
    );
  }
}
