import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'StreetBite'**
  String get appName;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleTheme;

  /// No description provided for @noMealsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No meals available'**
  String get noMealsAvailable;

  /// No description provided for @featuredMeals.
  ///
  /// In en, this message translates to:
  /// **'Featured meals'**
  String get featuredMeals;

  /// No description provided for @liveMenu.
  ///
  /// In en, this message translates to:
  /// **'Live menu'**
  String get liveMenu;

  /// No description provided for @hotOffers.
  ///
  /// In en, this message translates to:
  /// **'Hot offers'**
  String get hotOffers;

  /// No description provided for @hotPick.
  ///
  /// In en, this message translates to:
  /// **'Hot pick'**
  String get hotPick;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'{meal} added to cart'**
  String addedToCart(String meal);

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartTitle;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @removeItem.
  ///
  /// In en, this message translates to:
  /// **'Remove item'**
  String get removeItem;

  /// No description provided for @favoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No favorite meals yet'**
  String get favoritesEmpty;

  /// No description provided for @ordersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get ordersEmpty;

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @favoritesTab.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTab;

  /// No description provided for @cartTab.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cartTab;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @ordersTab.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersTab;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutButton;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to continue'**
  String get loginSubtitle;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUpLink.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpLink;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpTitle;

  /// No description provided for @signUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to get started'**
  String get signUpSubtitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpButton;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginLink;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Delicious meals, delivered'**
  String get splashTagline;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @errorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get errorWrongPassword;

  /// No description provided for @errorEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use'**
  String get errorEmailInUse;

  /// No description provided for @errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak'**
  String get errorWeakPassword;

  /// No description provided for @errorNetworkRequest.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please try again'**
  String get errorNetworkRequest;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later'**
  String get errorTooManyRequests;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get errorInvalidCredential;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorUnknown;

  /// No description provided for @mealsError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load meals'**
  String get mealsError;

  /// No description provided for @favoriteAction.
  ///
  /// In en, this message translates to:
  /// **'Save favorite'**
  String get favoriteAction;

  /// No description provided for @instructionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructionsLabel;

  /// No description provided for @instructionsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Instructions are unavailable right now.'**
  String get instructionsUnavailable;

  /// No description provided for @nearbyVendors.
  ///
  /// In en, this message translates to:
  /// **'Nearby Vendors'**
  String get nearbyVendors;

  /// No description provided for @ratingFive.
  ///
  /// In en, this message translates to:
  /// **'Rating 5.0'**
  String get ratingFive;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get placeOrder;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully'**
  String get orderPlaced;

  /// No description provided for @ordersHistory.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get ordersHistory;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrders;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(int count);

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @cashPayment.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cashPayment;

  /// No description provided for @cardPayment.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get cardPayment;

  /// No description provided for @cairoVendor.
  ///
  /// In en, this message translates to:
  /// **'Cairo Street Bites'**
  String get cairoVendor;

  /// No description provided for @alexandriaVendor.
  ///
  /// In en, this message translates to:
  /// **'Alexandria Grill'**
  String get alexandriaVendor;

  /// No description provided for @dubaiVendor.
  ///
  /// In en, this message translates to:
  /// **'Dubai Shawarma'**
  String get dubaiVendor;

  /// No description provided for @ammanVendor.
  ///
  /// In en, this message translates to:
  /// **'Amman Falafel'**
  String get ammanVendor;

  /// No description provided for @riyadhVendor.
  ///
  /// In en, this message translates to:
  /// **'Riyadh Bites'**
  String get riyadhVendor;

  /// No description provided for @egyptianCuisine.
  ///
  /// In en, this message translates to:
  /// **'Egyptian'**
  String get egyptianCuisine;

  /// No description provided for @mediterraneanCuisine.
  ///
  /// In en, this message translates to:
  /// **'Mediterranean'**
  String get mediterraneanCuisine;

  /// No description provided for @arabianCuisine.
  ///
  /// In en, this message translates to:
  /// **'Arabian'**
  String get arabianCuisine;

  /// No description provided for @levantineCuisine.
  ///
  /// In en, this message translates to:
  /// **'Levantine'**
  String get levantineCuisine;

  /// No description provided for @saudiCuisine.
  ///
  /// In en, this message translates to:
  /// **'Saudi'**
  String get saudiCuisine;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
