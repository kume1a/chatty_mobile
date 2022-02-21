abstract class TkCommon {
  static const String error = 'TkCommon.error';
  static const String signIn = 'TkCommon.signIn';
  static const String signUp = 'TkCommon.signUp';
  static const String email = 'TkCommon.email';
  static const String password = 'TkCommon.password';
  static const String firstName = 'TkCommon.firstName';
  static const String lastName = 'TkCommon.lastName';
  static const String repeatPassword = 'TkCommon.repeatPassword';
  static const String messages = 'TkCommon.messages';
  static const String search = 'TkCommon.search';
  static const String recent = 'TkCommon.recent';
  static const String online = 'TkCommon.online';
}

abstract class TkErrors {
  static const String unknown = 'TkErrors.unknown';
  static const String network = 'TkErrors.network';
  static const String invalidEmailOrPassword = '';
  static const String emailAlreadyUsed = '';
}

abstract class TkValidationErrors {
  static const String fieldIsRequired = 'TkValidationErrors.fieldIsRequired';
  static const String invalidEmail = 'TkValidationErrors.invalidEmail';
  static const String shortPassword = 'TkValidationErrors.shortPassword';
  static const String repeatedPasswordDoesNotMatch = 'TkValidationErrors.repeatedPasswordDoesNotMatch';
  static const String shortName = 'TkValidationErrors.shortName';
}

abstract class TkSignIn {
  static const String google = 'TkSignIn.google';
  static const String facebook = 'TkSignIn.facebook';
  static const String captionContinueWith = 'TkSignIn.captionContinueWith';
  static const String captionDontHaveAccount = 'TkSignIn.captionDontHaveAccount';
}

abstract class TkSignUp {
  static const String captionAgreeWithProvided = 'TkSignUp.captionAgreeWithProvided';
  static const String and = 'TkSignUp.and';
  static const String termsOfService = 'TkSignUp.termsOfService';
  static const String privacyPolicy = 'TkSignUp.privacyPolicy';
}

abstract class TkTermsOfService {
  static const String header = 'TkTermsOfService.header';
}

abstract class TkPrivacyPolicy {
  static const String header = 'TkPrivacyPolicy.header';
}
