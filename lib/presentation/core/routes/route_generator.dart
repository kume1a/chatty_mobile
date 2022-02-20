import 'package:flutter/material.dart';

import '../../pages/chat/chat_page.dart';
import '../../pages/chats/chats_page.dart';
import '../../pages/init/init_page.dart';
import '../../pages/privacy_policy/privacy_policy_page.dart';
import '../../pages/sign_in/sign_in_page.dart';
import '../../pages/sign_up/sign_up_page.dart';
import '../../pages/terms_of_service/terms_of_service_page.dart';
import 'route_arguments/chat_page_args.dart';

abstract class Routes {
  static const String root = 'root';

  static const String signIn = 'sign_in';
  static const String signUp = 'sign_up';
  static const String termsOfService = 'terms_of_service';
  static const String privacyPolicy = 'privacy_policy';
  static const String chats = 'chats';
  static const String chat = 'chat';
}

class RouteGenerator {
  static Route<dynamic>? routeFactory(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return _createRootPageRoute(settings);
      case Routes.signIn:
        return _createSignInPageRoute(settings);
      case Routes.signUp:
        return _createSignUpPageRoute(settings);
      case Routes.termsOfService:
        return _createTermsOfServicePageRoute(settings);
      case Routes.privacyPolicy:
        return _createPrivacyPolicyPageRoute(settings);
      case Routes.chats:
        return _createChatsPageRoute(settings);
      case Routes.chat:
        return _createChatPageRoute(settings);
      default:
        throw Exception('route ${settings.name} is not supported');
    }
  }

  static Route<void> _createRootPageRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => const InitPage(),
      settings: settings,
    );
  }

  static Route<void> _createSignInPageRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => const SignInPage(),
      settings: settings,
    );
  }

  static Route<void> _createSignUpPageRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => const SignUpPage(),
      settings: settings,
    );
  }

  static Route<void> _createTermsOfServicePageRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => const TermsOfServicePage(),
      settings: settings,
    );
  }

  static Route<void> _createPrivacyPolicyPageRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => const PrivacyPolicyPage(),
      settings: settings,
    );
  }

  static Route<void> _createChatsPageRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      builder: (_) => const ChatsPage(),
      settings: settings,
    );
  }

  static Route<void> _createChatPageRoute(RouteSettings settings) {
    if (settings.arguments == null || settings.arguments is! ChatPageArgs) {
      throw Exception('args instance of $ChatPageArgs is required');
    }

    final ChatPageArgs args = settings.arguments! as ChatPageArgs;

    return MaterialPageRoute<void>(
      builder: (_) => ChatPage(args: args),
      settings: settings,
    );
  }
}
