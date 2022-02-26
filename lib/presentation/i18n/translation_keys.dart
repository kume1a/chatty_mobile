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
  static const String logout = 'TkCommon.logout';
  static const String settings = 'TkCommon.settings';
}

abstract class TkError {
  static const String unknown = 'TkError.unknown';
  static const String network = 'TkError.network';
  static const String invalidEmailOrPassword = 'TkError.invalidEmailOrPassword';
  static const String emailAlreadyUsed = 'TkError.emailAlreadyUsed';
  static const String permissionDenied = 'TkError.permissionDenied';
  static const String microphonePermissionDenied = 'TkError.microphonePermissionDenied';
  static const String microphonePermissionPermanentlyDenied =
      'TkError.microphonePermissionPermanentlyDenied';
  static const String storagePermissionDenied = 'TkError.storagePermissionDenied';
  static const String storagePermissionPermanentlyDenied =
      'TkError.storagePermissionPermanentlyDenied';
  static const String cameraPermissionDenied = 'TkError.cameraPermissionDenied';
  static const String cameraPermissionPermanentlyDenied =
      'TkError.cameraPermissionPermanentlyDenied';
  static const String pickImage = 'TkError.pickImage';
}

abstract class TkValidationError {
  static const String fieldIsRequired = 'TkValidationError.fieldIsRequired';
  static const String invalidEmail = 'TkValidationError.invalidEmail';
  static const String shortPassword = 'TkValidationError.shortPassword';
  static const String repeatedPasswordDoesNotMatch =
      'TkValidationError.repeatedPasswordDoesNotMatch';
  static const String shortName = 'TkValidationError.shortName';
}

abstract class TkPageSignIn {
  static const String google = 'TkPageSignIn.google';
  static const String facebook = 'TkPageSignIn.facebook';
  static const String captionContinueWith = 'TkPageSignIn.captionContinueWith';
  static const String captionDontHaveAccount = 'TkPageSignIn.captionDontHaveAccount';
}

abstract class TkPageSignUp {
  static const String captionAgreeWithProvided = 'TkPageSignUp.captionAgreeWithProvided';
  static const String and = 'TkPageSignUp.and';
  static const String termsOfService = 'TkPageSignUp.termsOfService';
  static const String privacyPolicy = 'TkPageSignUp.privacyPolicy';
}

abstract class TkPageTermsOfService {
  static const String header = 'TkPageTermsOfService.header';
}

abstract class TkPagePrivacyPolicy {
  static const String header = 'TkPagePrivacyPolicy.header';
}
