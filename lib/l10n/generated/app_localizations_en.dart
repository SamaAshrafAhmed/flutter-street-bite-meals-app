// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'StreetBite';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get noMealsAvailable => 'No meals available';

  @override
  String get featuredMeals => 'Featured meals';

  @override
  String get liveMenu => 'Live menu';

  @override
  String get hotOffers => 'Hot offers';

  @override
  String get hotPick => 'Hot pick';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(String meal) {
    return '$meal added to cart';
  }

  @override
  String get cartTitle => 'Cart';

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get removeItem => 'Remove item';

  @override
  String get favoritesEmpty => 'No favorite meals yet';

  @override
  String get ordersEmpty => 'No orders yet';

  @override
  String get homeTab => 'Home';

  @override
  String get favoritesTab => 'Favorites';

  @override
  String get cartTab => 'Cart';

  @override
  String get profileTab => 'Profile';

  @override
  String get ordersTab => 'Orders';

  @override
  String get profileTitle => 'Profile';

  @override
  String get themeLabel => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'System';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get logoutButton => 'Log out';

  @override
  String get logoutConfirmTitle => 'Log out?';

  @override
  String get logoutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Log in to continue';

  @override
  String get loginButton => 'Log in';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUpLink => 'Sign up';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get signUpSubtitle => 'Sign up to get started';

  @override
  String get nameLabel => 'Name';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get signUpButton => 'Sign up';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get loginLink => 'Log in';

  @override
  String get splashTagline => 'Delicious meals, delivered';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get errorUserNotFound => 'No user found with this email';

  @override
  String get errorWrongPassword => 'Incorrect password';

  @override
  String get errorEmailInUse => 'This email is already in use';

  @override
  String get errorWeakPassword => 'The password is too weak';

  @override
  String get errorNetworkRequest => 'Network error. Please try again';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Please try again later';

  @override
  String get errorInvalidCredential => 'Invalid credentials';

  @override
  String get errorUnknown => 'Something went wrong';

  @override
  String get mealsError => 'Unable to load meals';

  @override
  String get favoriteAction => 'Save favorite';

  @override
  String get instructionsLabel => 'Instructions';

  @override
  String get instructionsUnavailable =>
      'Instructions are unavailable right now.';

  @override
  String get nearbyVendors => 'Nearby Vendors';

  @override
  String get ratingFive => 'Rating 5.0';

  @override
  String get placeOrder => 'Place order';

  @override
  String get orderPlaced => 'Order placed successfully';

  @override
  String get ordersHistory => 'Order history';

  @override
  String get noOrders => 'No orders yet';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get cashPayment => 'Cash';

  @override
  String get cardPayment => 'Card';

  @override
  String get cairoVendor => 'Cairo Street Bites';

  @override
  String get alexandriaVendor => 'Alexandria Grill';

  @override
  String get dubaiVendor => 'Dubai Shawarma';

  @override
  String get ammanVendor => 'Amman Falafel';

  @override
  String get riyadhVendor => 'Riyadh Bites';

  @override
  String get egyptianCuisine => 'Egyptian';

  @override
  String get mediterraneanCuisine => 'Mediterranean';

  @override
  String get arabianCuisine => 'Arabian';

  @override
  String get levantineCuisine => 'Levantine';

  @override
  String get saudiCuisine => 'Saudi';
}
