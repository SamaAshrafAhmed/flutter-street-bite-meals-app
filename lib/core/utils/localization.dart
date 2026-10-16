import 'package:flutter/widgets.dart';
import 'package:street_bite/l10n/generated/app_localizations.dart';

final localeNotifier = ValueNotifier<Locale>(const Locale('en'));

extension LocalizationContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  void setAppLocale(Locale locale) => localeNotifier.value = locale;
}
