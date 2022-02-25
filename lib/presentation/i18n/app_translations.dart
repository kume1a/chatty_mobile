import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:static_i18n/static_i18n.dart';

import 'app_locales.dart';
import 'translation_keys.dart';

@injectable
class AppTranslations extends Translations {
  @override
  Map<Locale, Map<String, String>> get keys => <Locale, Map<String, String>>{
        AppLocales.localeEn: _enUs,
      };

  final Map<String, String> _enUs = <String, String>{
    TkCommon.error: 'Error',
    TkCommon.signIn: 'Sign in',
    TkCommon.signUp: 'Sign up',
    TkCommon.email: 'Email',
    TkCommon.password: 'Password',
    TkCommon.firstName: 'First name',
    TkCommon.lastName: 'Last name',
    TkCommon.repeatPassword: 'Repeat password',
    TkCommon.messages: 'Messages',
    TkCommon.search: 'Search',
    TkCommon.recent: 'Recent',
    TkCommon.online: 'Online',
    TkCommon.logout: 'Logout',

    TkErrors.unknown: 'Unknown error',
    TkErrors.network: 'Network error',

    TkValidationErrors.fieldIsRequired: 'Field is required',
    TkValidationErrors.invalidEmail: 'Invalid email',
    TkValidationErrors.shortPassword: 'Password is too short',
    TkValidationErrors.repeatedPasswordDoesNotMatch: 'Repeated password does not match password',
    TkValidationErrors.shortName: 'Name is too short',

    TkSignIn.google: 'Google',
    TkSignIn.facebook: 'Facebook',
    TkSignIn.captionContinueWith: 'or continue with',
    TkSignIn.captionDontHaveAccount: "Don't have an account? ",

    TkSignUp.captionAgreeWithProvided: 'I agree with provided ',
    TkSignUp.and: ' and ',
    TkSignUp.termsOfService: 'terms of service',
    TkSignUp.privacyPolicy: 'privacy policy',

    TkTermsOfService.header: 'Terms of service',

    TkPrivacyPolicy.header: 'Privacy policy',
  };
}
