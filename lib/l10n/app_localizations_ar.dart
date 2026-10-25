// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'حاسبة النسبة المئوية';

  @override
  String get homeTitle => 'حاسبة %';

  @override
  String get menuHistory => 'السجل';

  @override
  String get menuSettings => 'الإعدادات';

  @override
  String get menuShareApp => 'مشاركة التطبيق';

  @override
  String get menuRateApp => 'تقييم التطبيق';

  @override
  String get menuReportBug => 'الإبلاغ عن خطأ';

  @override
  String get menuPrivacySettings => 'إعدادات الخصوصية';

  @override
  String get menuPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get menuAbout => 'حول التطبيق';

  @override
  String get menuExit => 'خروج';

  @override
  String get exitTitle => 'هل أنت متأكد؟';

  @override
  String get exitMessage => 'هل تريد الخروج من التطبيق؟';

  @override
  String get no => 'لا';

  @override
  String get yes => 'نعم';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get share => 'مشاركة';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get calculate => 'احسب';

  @override
  String get shareResultTooltip => 'مشاركة النتيجة';

  @override
  String copied(String label) {
    return 'تم نسخ $label';
  }

  @override
  String get errorRequired => 'أدخل قيمة';

  @override
  String get errorInvalidNumber => 'أدخل رقمًا صالحًا';

  @override
  String get errorNegative => 'يجب ألا تكون القيمة سالبة';

  @override
  String get errorWholeNumber => 'أدخل عددًا صحيحًا';

  @override
  String get errorAtLeastOne => 'يجب أن تكون 1 على الأقل';

  @override
  String get errorBelow100 => 'يجب أن تكون أقل من 100%';

  @override
  String get errorNotZero => 'لا يمكن أن تكون 0';

  @override
  String get errorPositive => 'يجب أن تكون أكبر من 0';

  @override
  String hintExample(String value) {
    return 'مثال: $value';
  }

  @override
  String get resultsHeader => 'النتائج';

  @override
  String get sharedFrom => 'تم الحساب باستخدام حاسبة النسبة المئوية';

  @override
  String shareAppText(String url) {
    return 'أستخدم حاسبة النسبة المئوية لحساب النسب والإكراميات والخصومات وغيرها بسرعة. جرّبها: $url';
  }

  @override
  String get calcPercentageTitle => 'حساب النسبة المئوية';

  @override
  String get calcPercentageSubtitle => 'اعرف النسبة المئوية لأي رقم';

  @override
  String get fieldPercentage => 'النسبة المئوية';

  @override
  String get fieldValue => 'القيمة';

  @override
  String get fieldAmount => 'المبلغ';

  @override
  String get fieldIncreaseBy => 'زيادة بنسبة';

  @override
  String get fieldDecreaseBy => 'تخفيض بنسبة';

  @override
  String get resultResult => 'النتيجة';

  @override
  String get resultIncrease => 'مقدار الزيادة';

  @override
  String get resultDecrease => 'مقدار التخفيض';

  @override
  String get calcIncreaseTitle => 'الزيادة بالنسبة المئوية';

  @override
  String get calcIncreaseSubtitle => 'زد رقمًا بنسبة مئوية';

  @override
  String get calcDecreaseTitle => 'التخفيض بالنسبة المئوية';

  @override
  String get calcDecreaseSubtitle => 'خفّض رقمًا بنسبة مئوية';

  @override
  String get calcTipTitle => 'الإكرامية وتقسيم الفاتورة';

  @override
  String get calcTipSubtitle => 'احسب الإكرامية وقسّم الفاتورة';

  @override
  String get fieldBillAmount => 'مبلغ الفاتورة';

  @override
  String get fieldPeople => 'عدد الأشخاص';

  @override
  String get fieldTipPercent => 'الإكرامية';

  @override
  String get resultTipAmount => 'مبلغ الإكرامية';

  @override
  String get resultTipPerPerson => 'الإكرامية لكل شخص';

  @override
  String get resultTotalToPay => 'الإجمالي المستحق';

  @override
  String get resultTotalPerPerson => 'الإجمالي لكل شخص';

  @override
  String get calcMarginTitle => 'هامش الربح';

  @override
  String get calcMarginSubtitle => 'اعرف سعر البيع لهامش ربح معيّن';

  @override
  String get fieldCost => 'التكلفة';

  @override
  String get fieldMargin => 'الهامش';

  @override
  String get resultPrice => 'سعر البيع';

  @override
  String get resultProfit => 'الربح';

  @override
  String get resultMarkup => 'نسبة الزيادة على التكلفة';

  @override
  String get calcChangeTitle => 'التغير بالنسبة المئوية';

  @override
  String get calcChangeSubtitle => 'مقدار ارتفاع القيمة أو انخفاضها';

  @override
  String get fieldInitialValue => 'القيمة الأولية';

  @override
  String get fieldFinalValue => 'القيمة النهائية';

  @override
  String get resultPercentChange => 'نسبة التغير';

  @override
  String get resultDifference => 'الفرق';

  @override
  String get calcPercentOfTitle => 'كم % من';

  @override
  String get calcPercentOfSubtitle => 'كم تمثل قيمة من أخرى بالنسبة المئوية';

  @override
  String get fieldPart => 'القيمة';

  @override
  String get fieldWhole => 'تمثل كم % من';

  @override
  String get calcDiscountTitle => 'الخصم';

  @override
  String get calcDiscountSubtitle => 'السعر بعد الخصم ومقدار التوفير';

  @override
  String get fieldOriginalPrice => 'السعر الأصلي';

  @override
  String get fieldDiscount => 'الخصم';

  @override
  String get resultFinalPrice => 'السعر النهائي';

  @override
  String get resultYouSave => 'توفّر';

  @override
  String get calcTaxTitle => 'ضريبة القيمة المضافة';

  @override
  String get calcTaxSubtitle => 'أضف الضريبة إلى السعر أو احذفها منه';

  @override
  String get fieldTaxRate => 'نسبة الضريبة';

  @override
  String get resultWithTax => 'السعر شامل الضريبة';

  @override
  String get resultTaxAdded => 'الضريبة المضافة';

  @override
  String get resultWithoutTax => 'السعر بدون ضريبة';

  @override
  String get resultTaxIncluded => 'الضريبة المشمولة';

  @override
  String get calcGradeTitle => 'درجة الاختبار';

  @override
  String get calcGradeSubtitle => 'حوّل درجاتك إلى نسبة مئوية';

  @override
  String get fieldScore => 'درجتك';

  @override
  String get fieldTotalMarks => 'الدرجة الكاملة';

  @override
  String get resultPercentage => 'النسبة المئوية';

  @override
  String get resultMarksLost => 'الدرجات المفقودة';

  @override
  String get calcLoanTitle => 'القرض والفائدة';

  @override
  String get calcLoanSubtitle => 'القسط الشهري وإجمالي الفائدة';

  @override
  String get fieldLoanAmount => 'مبلغ القرض';

  @override
  String get fieldInterestRate => 'سعر الفائدة (سنويًا)';

  @override
  String get fieldTermYears => 'المدة (بالسنوات)';

  @override
  String get resultMonthlyPayment => 'القسط الشهري';

  @override
  String get resultTotalPayment => 'إجمالي المدفوعات';

  @override
  String get resultTotalInterest => 'إجمالي الفائدة';

  @override
  String get historyTitle => 'السجل';

  @override
  String get historyEmpty => 'ستظهر عملياتك الحسابية هنا.';

  @override
  String get historyClear => 'مسح السجل';

  @override
  String get historyClearConfirm =>
      'هل تريد حذف كل العمليات الحسابية المحفوظة؟';

  @override
  String get historyDeleted => 'تم حذف العملية';

  @override
  String get undo => 'تراجع';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get themeSystem => 'حسب النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get languageSystem => 'حسب النظام';

  @override
  String get aboutDescription =>
      'احسب بسهولة النسب المئوية والإكراميات والخصومات والضرائب والدرجات والقروض. بسيط وسريع ومجاني.';

  @override
  String aboutVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get reportBugIntro =>
      'هل واجهت تعطلًا أو خطأ؟ لديك فكرة لتحسين التطبيق؟ يسعدنا أن نسمع منك، فرأيك لا يُقدّر بثمن.';

  @override
  String get reportBugLabel => 'صف المشكلة أو فكرتك';

  @override
  String get reportBugHint => 'مثال: يتوقف التطبيق عند تدوير الشاشة';

  @override
  String get reportBugSend => 'إرسال';

  @override
  String reportBugNoEmail(String email) {
    return 'لم يتم العثور على تطبيق بريد. يُرجى مراسلتنا على $email';
  }

  @override
  String get updateAvailableTitle => 'تحديث متاح';

  @override
  String get updateAvailableMessage =>
      'يتوفر إصدار جديد من حاسبة النسبة المئوية مع تحسينات وإصلاحات.';

  @override
  String get updateRequiredTitle => 'التحديث مطلوب';

  @override
  String get updateRequiredMessage =>
      'لم يعد هذا الإصدار مدعومًا. يُرجى التحديث لمواصلة استخدام التطبيق.';

  @override
  String get updateNow => 'حدّث الآن';

  @override
  String get later => 'لاحقًا';

  @override
  String get premiumTitle => 'بدون إعلانات';

  @override
  String get premiumDescription =>
      'شراء لمرة واحدة. يزيل كل الإعلانات ويفتح كل الميزات الإضافية.';

  @override
  String premiumBuy(String price) {
    return 'إزالة الإعلانات – $price';
  }

  @override
  String get premiumActive => 'أنت الآن بدون إعلانات. شكرًا لدعمك!';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get purchaseUnavailable => 'عمليات الشراء غير متاحة حاليًا.';

  @override
  String get purchaseFailed =>
      'لم تكتمل عملية الشراء. يُرجى المحاولة مرة أخرى.';

  @override
  String get settingsColor => 'اللون';

  @override
  String get unlockColorsTitle => 'فتح كل الألوان';

  @override
  String get unlockColorsMessage =>
      'شاهد إعلان فيديو قصيرًا لفتح كل الألوان مجانًا، أو أزل الإعلانات لفتح كل شيء.';

  @override
  String get exportTitle => 'تصدير السجل';

  @override
  String get exportMessage =>
      'شاهد إعلان فيديو قصيرًا لتصدير سجلك كجدول بيانات (CSV)، أو أزل الإعلانات للتصدير في أي وقت.';

  @override
  String get watchAd => 'شاهد الإعلان';

  @override
  String get adNotReady => 'لا يتوفر إعلان الآن. يُرجى المحاولة بعد قليل.';

  @override
  String get colorsUnlocked => 'تم فتح كل الألوان!';

  @override
  String get exportCsv => 'تصدير بصيغة CSV';

  @override
  String get csvDate => 'التاريخ';

  @override
  String get csvCalculator => 'الحاسبة';

  @override
  String get csvInputs => 'القيم المدخلة';

  @override
  String get csvResults => 'النتائج';

  @override
  String get widgetEmpty => 'ستظهر آخر عملية حسابية هنا';

  @override
  String get featuresTitle => 'الميزات';

  @override
  String get featCalculators => '11 حاسبة';

  @override
  String get featCalculatorsDesc =>
      'النسبة المئوية، كم % من، الزيادة، التخفيض، التغير، الخصم، الإكرامية وتقسيم الفاتورة، ضريبة القيمة المضافة، هامش الربح، درجة الاختبار، القرض والفائدة';

  @override
  String get featInstant => 'نتائج فورية';

  @override
  String get featInstantDesc =>
      'تظهر الإجابات أثناء الكتابة. اضغط للنسخ أو المشاركة.';

  @override
  String get featHistory => 'السجل والتصدير';

  @override
  String get featHistoryDesc =>
      'تُحفظ كل عملية حسابية. أعد فتحها أو صدّرها بصيغة CSV.';

  @override
  String get featWidget => 'الأداة والاختصارات';

  @override
  String get featWidgetDesc =>
      'شاهد آخر نتيجة على الشاشة الرئيسية. اضغط مطولًا على أيقونة التطبيق للاختصارات.';

  @override
  String get featStyle => 'أسلوبك';

  @override
  String get featStyleDesc => 'الوضع الفاتح والداكن مع ألوان مميزة.';

  @override
  String get featLanguages => '7 لغات';

  @override
  String get featPrivate => 'خاص';

  @override
  String get featPrivateDesc => 'لا حاجة إلى حساب. تبقى أرقامك على جهازك.';

  @override
  String get featAdFree => 'خيار بدون إعلانات';

  @override
  String get featAdFreeDesc =>
      'شراء لمرة واحدة يزيل كل الإعلانات ويفتح كل الميزات الإضافية.';

  @override
  String get aiTitle => 'مساعد الذكاء الاصطناعي';

  @override
  String get aiWelcome =>
      'اسأل عن عملياتك الحسابية المحفوظة، أو اكتب عملية حسابية بكلماتك.';

  @override
  String get aiHint => 'اسأل أو اكتب عملية حسابية…';

  @override
  String get aiSuggestion1 => 'كم وفّرت من الخصومات؟';

  @override
  String get aiSuggestion2 => 'خصم 15% على 2,400 مع ضريبة 7.5%';

  @override
  String get aiSuggestion3 => 'ما متوسط الإكرامية التي قدمتها؟';

  @override
  String get aiInsightsTitle => 'رؤى';

  @override
  String get aiInsightsButton => 'احصل على رؤى';

  @override
  String get aiInsightsEmpty =>
      'قم ببعض العمليات الحسابية أولًا، ثم عد للحصول على رؤى.';

  @override
  String get aiThinking => 'جارٍ التفكير…';

  @override
  String get aiOpenCalculator => 'فتح';

  @override
  String aiStep(int n) {
    return 'الخطوة $n';
  }

  @override
  String get aiReport => 'الإبلاغ عن الإجابة';

  @override
  String aiRemaining(int count) {
    return 'تبقّى $count من أسئلة الذكاء الاصطناعي اليوم';
  }

  @override
  String get aiQuotaReached => 'استخدمت أسئلة الذكاء الاصطناعي لهذا اليوم.';

  @override
  String get aiWatchAdMore => 'شاهد إعلانًا للحصول على 5 أخرى';

  @override
  String get aiPremiumMore => 'بدون إعلانات: 30 يوميًا';

  @override
  String get aiConsentTitle => 'استخدام مساعد الذكاء الاصطناعي؟';

  @override
  String get aiConsentMessage =>
      'للإجابة، يُرسل سؤالك وعملياتك الحسابية المحفوظة إلى خدمة ذكاء اصطناعي (حاليًا Google Gemini). لا يُرسل أي شيء حتى تسأل، ولا يُضمَّن أي حساب أو اسم. يُرجى عدم كتابة معلومات شخصية في أسئلتك.';

  @override
  String get aiConsentAgree => 'موافق';

  @override
  String get aiDisclaimer =>
      'قد يخطئ الذكاء الاصطناعي. الأرقام تأتي من الحاسبة وليس من الذكاء الاصطناعي.';

  @override
  String get aiErrorGeneric => 'حدث خطأ. يُرجى المحاولة مرة أخرى.';

  @override
  String get aiErrorOffline =>
      'لا يوجد اتصال. تحقق من الإنترنت وحاول مرة أخرى.';

  @override
  String get aiErrorBusy => 'مساعد الذكاء الاصطناعي مشغول. حاول لاحقًا.';

  @override
  String get aiErrorRefused =>
      'لا يمكن للذكاء الاصطناعي المساعدة في هذا الطلب.';

  @override
  String get aiExplain => 'شرح';

  @override
  String get aiExplainTitle => 'طريقة الحساب';

  @override
  String get aiInvalidStep => 'لا يمكن إجراء هذه العملية بهذه الأرقام.';

  @override
  String get aiBonusAdded => 'تمت إضافة 5 أسئلة أخرى!';

  @override
  String get aiErrorUnavailable => 'مساعد الذكاء الاصطناعي غير متاح حاليًا.';

  @override
  String get menuCheckUpdates => 'البحث عن تحديثات';

  @override
  String updateUpToDate(String version) {
    return 'لديك أحدث إصدار ($version).';
  }

  @override
  String get updateCheckFailed =>
      'تعذّر البحث عن تحديثات. يُرجى المحاولة لاحقًا.';

  @override
  String get adPassWatch => 'شاهد فيديو: بدون إعلانات لمدة 24 ساعة';

  @override
  String adPassActive(String time) {
    return 'بدون إعلانات حتى $time';
  }

  @override
  String get adPassGranted => 'لا إعلانات خلال الـ24 ساعة القادمة. استمتع!';
}
