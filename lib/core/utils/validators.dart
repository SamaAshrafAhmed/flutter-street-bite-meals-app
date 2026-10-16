 import 'package:street_bite/l10n/generated/app_localizations.dart';

class Validators {
  Validators._();

  static String? email(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) return l10n.emailRequired;
    final emailRegex = RegExp(r'^[\w\-.]+@[\w\-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) return l10n.emailInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) return l10n.passwordRequired;
    if (value.length < 6) return l10n.passwordTooShort;
    return null;
  }

  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? confirmPassword(
    String? value,
    String original,
    AppLocalizations l10n,
  ) {
    if (value == null || value.isEmpty) return l10n.confirmPasswordRequired;
    if (value != original) return l10n.passwordsDoNotMatch;
    return null;
  }
}
