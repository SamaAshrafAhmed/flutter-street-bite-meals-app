// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ستريت بايت';

  @override
  String get toggleTheme => 'تبديل المظهر';

  @override
  String get noMealsAvailable => 'لا توجد وجبات متاحة';

  @override
  String get featuredMeals => 'وجبات مميزة';

  @override
  String get liveMenu => 'القائمة الحالية';

  @override
  String get hotOffers => 'عروض مميزة';

  @override
  String get hotPick => 'اختيار مميز';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String addedToCart(String meal) {
    return 'تمت إضافة $meal إلى السلة';
  }

  @override
  String get cartTitle => 'السلة';

  @override
  String get cartEmpty => 'سلتك فارغة';

  @override
  String get removeItem => 'إزالة العنصر';

  @override
  String get favoritesEmpty => 'لا توجد وجبات مفضلة بعد';

  @override
  String get ordersEmpty => 'لا توجد طلبات بعد';

  @override
  String get homeTab => 'الرئيسية';

  @override
  String get favoritesTab => 'المفضلة';

  @override
  String get cartTab => 'السلة';

  @override
  String get profileTab => 'الملف الشخصي';

  @override
  String get ordersTab => 'الطلبات';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get themeLabel => 'المظهر';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeDark => 'داكن';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get logoutButton => 'تسجيل الخروج';

  @override
  String get logoutConfirmTitle => 'تسجيل الخروج؟';

  @override
  String get logoutConfirmMessage => 'هل أنت متأكد من تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get loginTitle => 'مرحباً بعودتك';

  @override
  String get loginSubtitle => 'سجل الدخول للمتابعة';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get signUpLink => 'إنشاء حساب';

  @override
  String get signUpTitle => 'إنشاء حساب';

  @override
  String get signUpSubtitle => 'أنشئ حساباً للبدء';

  @override
  String get nameLabel => 'الاسم';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get signUpButton => 'إنشاء حساب';

  @override
  String get haveAccount => 'لديك حساب بالفعل؟';

  @override
  String get loginLink => 'تسجيل الدخول';

  @override
  String get splashTagline => 'وجبات شهية تصلك حتى بابك';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get confirmPasswordRequired => 'يرجى تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get errorUserNotFound => 'لا يوجد مستخدم بهذا البريد الإلكتروني';

  @override
  String get errorWrongPassword => 'كلمة المرور غير صحيحة';

  @override
  String get errorEmailInUse => 'البريد الإلكتروني مستخدم بالفعل';

  @override
  String get errorWeakPassword => 'كلمة المرور ضعيفة';

  @override
  String get errorNetworkRequest => 'خطأ في الشبكة. حاول مرة أخرى';

  @override
  String get errorTooManyRequests => 'محاولات كثيرة. حاول لاحقاً';

  @override
  String get errorInvalidCredential => 'بيانات الدخول غير صحيحة';

  @override
  String get errorUnknown => 'حدث خطأ ما';

  @override
  String get firebaseDataError =>
      'تعذر الوصول إلى بيانات حسابك. حاول مرة أخرى.';

  @override
  String get mealsError => 'تعذر تحميل الوجبات';

  @override
  String get favoriteAction => 'حفظ في المفضلة';

  @override
  String get instructionsLabel => 'طريقة التحضير';

  @override
  String get instructionsUnavailable => 'طريقة التحضير غير متاحة حالياً.';

  @override
  String get nearbyVendors => 'البائعون القريبون';

  @override
  String ratingLabel(String rating) {
    return 'التقييم $rating';
  }

  @override
  String get placeOrder => 'تأكيد الطلب';

  @override
  String get orderPlaced => 'تم تأكيد الطلب بنجاح';

  @override
  String get ordersHistory => 'سجل الطلبات';

  @override
  String get noOrders => 'لا توجد طلبات بعد';

  @override
  String itemsCount(int count) {
    return '$count عناصر';
  }

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get cashPayment => 'نقداً';

  @override
  String get cardPayment => 'بطاقة';

  @override
  String get authenticateProfile => 'تحقق لفتح الملف الشخصي';

  @override
  String get biometricReason => 'تحقق لفتح ملف StreetBite الشخصي';

  @override
  String get biometricUnavailable =>
      'قم بإعداد بصمة أو وسيلة تحقق حيوية على هذا الجهاز ثم حاول مرة أخرى.';

  @override
  String get biometricFailed => 'فشل التحقق. حاول مرة أخرى.';

  @override
  String get guestUser => 'مستخدم StreetBite';

  @override
  String get emailUnavailable => 'البريد الإلكتروني غير متاح';

  @override
  String get profilePhotoError => 'تعذر تحديث صورة الملف الشخصي.';

  @override
  String get deviceDetails => 'تفاصيل الجهاز';

  @override
  String get deviceModel => 'الطراز';

  @override
  String get deviceManufacturer => 'الشركة المصنعة';

  @override
  String get deviceSystem => 'النظام';

  @override
  String get deviceVersion => 'الإصدار';

  @override
  String get deviceId => 'معرف الجهاز';

  @override
  String get deviceDetailsUnavailable => 'تفاصيل الجهاز غير متاحة.';

  @override
  String get cairoVendor => 'وجبات شارع القاهرة';

  @override
  String get alexandriaVendor => 'مشويات الإسكندرية';

  @override
  String get gizaVendor => 'ركن كشري الجيزة';

  @override
  String get luxorVendor => 'مطبخ الأقصر الشعبي';

  @override
  String get aswanVendor => 'وجبات أسوان النوبية';

  @override
  String get egyptianCuisine => 'مصرية';

  @override
  String get alexandriaCuisine => 'مأكولات بحرية إسكندرانية';

  @override
  String get gizaCuisine => 'كشري';

  @override
  String get luxorCuisine => 'صعيدية';

  @override
  String get aswanCuisine => 'نوبية';
}
