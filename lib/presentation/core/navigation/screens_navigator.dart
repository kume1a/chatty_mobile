import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import 'route_arguments/chat_page_args.dart';
import 'route_generator.dart';

@lazySingleton
class ScreensNavigator {
  Future<void> pop<T extends Object?>({
    T? result,
  }) async =>
      GlobalNavigator.pop(result: result);

  Future<void> toSignInPage() => GlobalNavigator.pushNamedAndRemoveAll(Routes.signIn);

  Future<void> toSignUpPage() => GlobalNavigator.pushNamed(Routes.signUp);

  Future<void> toTermsOfServicePage() => GlobalNavigator.pushNamed(Routes.termsOfService);

  Future<void> toPrivacyPolicyPage() => GlobalNavigator.pushNamed(Routes.privacyPolicy);

  Future<void> toChatsPage() => GlobalNavigator.pushNamedAndRemoveAll(Routes.chats);

  Future<void> toChatPage(ChatPageArgs args) =>
      GlobalNavigator.pushNamed(Routes.chat, arguments: args);

  Future<void> toSearchPage() => GlobalNavigator.pushNamed(Routes.search);

  Future<void> toProfilePage() => GlobalNavigator.pushNamed(Routes.profile);
}
