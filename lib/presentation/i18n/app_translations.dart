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
    TkCommon.settings: 'Settings',

    TkError.unknown: 'Unknown error',
    TkError.network: 'Network error',
    TkError.invalidEmailOrPassword: 'Invalid email or password',
    TkError.emailAlreadyUsed: 'Email is already used by someone else',
    TkError.permissionDenied: 'Permission denied',
    TkError.microphonePermissionDenied: 'Allow microphone permission to record audio',
    TkError.microphonePermissionPermanentlyDenied: 'Allow microphone permission from settings to record audio',
    TkError.storagePermissionDenied: 'Allow storage permission to pick image from storage',
    TkError.storagePermissionPermanentlyDenied: 'Allow storage permission from settings to pick image from storage',
    TkError.cameraPermissionDenied: 'Allow camera permission to take image with camera',
    TkError.cameraPermissionPermanentlyDenied: 'Allow camera permission from settings to take image with camera',
    TkError.pickImage: 'Error while picking image',

    TkValidationError.fieldIsRequired: 'Field is required',
    TkValidationError.invalidEmail: 'Invalid email',
    TkValidationError.shortPassword: 'Password is too short',
    TkValidationError.repeatedPasswordDoesNotMatch: 'Repeated password does not match password',
    TkValidationError.shortName: 'Name is too short',

    TkPageSignIn.google: 'Google',
    TkPageSignIn.facebook: 'Facebook',
    TkPageSignIn.captionContinueWith: 'or continue with',
    TkPageSignIn.captionDontHaveAccount: "Don't have an account? ",

    TkPageSignUp.captionAgreeWithProvided: 'I agree with provided ',
    TkPageSignUp.and: ' and ',
    TkPageSignUp.termsOfService: 'terms of service',
    TkPageSignUp.privacyPolicy: 'privacy policy',

    TkPageTermsOfService.header: 'Terms of service',

    TkPagePrivacyPolicy.header: 'Privacy policy',
  };
}
