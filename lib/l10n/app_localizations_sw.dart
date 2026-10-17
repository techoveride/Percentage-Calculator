// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Kikokotoo cha Asilimia';

  @override
  String get homeTitle => 'Kikokotoo %';

  @override
  String get menuHistory => 'Historia';

  @override
  String get menuSettings => 'Mipangilio';

  @override
  String get menuShareApp => 'Shiriki Programu';

  @override
  String get menuRateApp => 'Kadiria Programu';

  @override
  String get menuReportBug => 'Ripoti Hitilafu';

  @override
  String get menuPrivacySettings => 'Mipangilio ya Faragha';

  @override
  String get menuPrivacyPolicy => 'Sera ya Faragha';

  @override
  String get menuAbout => 'Kuhusu';

  @override
  String get menuExit => 'Toka';

  @override
  String get exitTitle => 'Una uhakika?';

  @override
  String get exitMessage => 'Je, unataka kutoka kwenye programu?';

  @override
  String get no => 'Hapana';

  @override
  String get yes => 'Ndiyo';

  @override
  String get cancel => 'Ghairi';

  @override
  String get delete => 'Futa';

  @override
  String get share => 'Shiriki';

  @override
  String get reset => 'Anza upya';

  @override
  String get calculate => 'Kokotoa';

  @override
  String get shareResultTooltip => 'Shiriki matokeo';

  @override
  String copied(String label) {
    return '$label imenakiliwa';
  }

  @override
  String get errorRequired => 'Weka thamani';

  @override
  String get errorInvalidNumber => 'Weka namba sahihi';

  @override
  String get errorNegative => 'Haipaswi kuwa hasi';

  @override
  String get errorWholeNumber => 'Weka namba kamili';

  @override
  String get errorAtLeastOne => 'Lazima iwe angalau 1';

  @override
  String get errorBelow100 => 'Lazima iwe chini ya 100%';

  @override
  String get errorNotZero => 'Haiwezi kuwa 0';

  @override
  String get errorPositive => 'Lazima iwe zaidi ya 0';

  @override
  String hintExample(String value) {
    return 'mf. $value';
  }

  @override
  String get resultsHeader => 'Matokeo';

  @override
  String get sharedFrom => 'Imekokotolewa kwa Kikokotoo cha Asilimia';

  @override
  String shareAppText(String url) {
    return 'Ninatumia Kikokotoo cha Asilimia kukokotoa asilimia, bakshishi, punguzo na zaidi kwa haraka. Kijaribu: $url';
  }

  @override
  String get calcPercentageTitle => 'Kokotoa Asilimia';

  @override
  String get calcPercentageSubtitle => 'Pata asilimia ya namba yoyote';

  @override
  String get fieldPercentage => 'Asilimia';

  @override
  String get fieldValue => 'Thamani';

  @override
  String get fieldAmount => 'Kiasi';

  @override
  String get fieldIncreaseBy => 'Ongeza kwa';

  @override
  String get fieldDecreaseBy => 'Punguza kwa';

  @override
  String get resultResult => 'Jibu';

  @override
  String get resultIncrease => 'Ongezeko';

  @override
  String get resultDecrease => 'Upungufu';

  @override
  String get calcIncreaseTitle => 'Ongezeko la Asilimia';

  @override
  String get calcIncreaseSubtitle => 'Ongeza namba kwa asilimia';

  @override
  String get calcDecreaseTitle => 'Upungufu wa Asilimia';

  @override
  String get calcDecreaseSubtitle => 'Punguza namba kwa asilimia';

  @override
  String get calcTipTitle => 'Bakshishi na Kugawana Bili';

  @override
  String get calcTipSubtitle => 'Kokotoa bakshishi na ugawane bili';

  @override
  String get fieldBillAmount => 'Kiasi cha bili';

  @override
  String get fieldPeople => 'Idadi ya watu';

  @override
  String get fieldTipPercent => 'Bakshishi';

  @override
  String get resultTipAmount => 'Kiasi cha bakshishi';

  @override
  String get resultTipPerPerson => 'Bakshishi kwa kila mtu';

  @override
  String get resultTotalToPay => 'Jumla ya kulipa';

  @override
  String get resultTotalPerPerson => 'Jumla kwa kila mtu';

  @override
  String get calcMarginTitle => 'Kiwango cha Faida';

  @override
  String get calcMarginSubtitle => 'Pata bei ya kuuza kwa kiwango cha faida';

  @override
  String get fieldCost => 'Gharama';

  @override
  String get fieldMargin => 'Kiwango cha faida';

  @override
  String get resultPrice => 'Bei ya kuuza';

  @override
  String get resultProfit => 'Faida';

  @override
  String get resultMarkup => 'Nyongeza juu ya gharama';

  @override
  String get calcChangeTitle => 'Mabadiliko ya Asilimia';

  @override
  String get calcChangeSubtitle => 'Thamani imepanda au kushuka kwa kiasi gani';

  @override
  String get fieldInitialValue => 'Thamani ya awali';

  @override
  String get fieldFinalValue => 'Thamani ya mwisho';

  @override
  String get resultPercentChange => 'Mabadiliko ya asilimia';

  @override
  String get resultDifference => 'Tofauti';

  @override
  String get calcPercentOfTitle => 'Ni % ngapi ya';

  @override
  String get calcPercentOfSubtitle =>
      'Thamani moja ni asilimia ngapi ya nyingine';

  @override
  String get fieldPart => 'Thamani';

  @override
  String get fieldWhole => 'Ni % ngapi ya';

  @override
  String get calcDiscountTitle => 'Punguzo';

  @override
  String get calcDiscountSubtitle => 'Bei baada ya punguzo na unachookoa';

  @override
  String get fieldOriginalPrice => 'Bei ya awali';

  @override
  String get fieldDiscount => 'Punguzo';

  @override
  String get resultFinalPrice => 'Bei ya mwisho';

  @override
  String get resultYouSave => 'Unaokoa';

  @override
  String get calcTaxTitle => 'VAT / Kodi';

  @override
  String get calcTaxSubtitle => 'Ongeza au ondoa kodi kwenye bei';

  @override
  String get fieldTaxRate => 'Kiwango cha kodi';

  @override
  String get resultWithTax => 'Bei ikiwa na kodi';

  @override
  String get resultTaxAdded => 'Kodi iliyoongezwa';

  @override
  String get resultWithoutTax => 'Bei bila kodi';

  @override
  String get resultTaxIncluded => 'Kodi iliyojumuishwa';

  @override
  String get calcGradeTitle => 'Alama za Mtihani';

  @override
  String get calcGradeSubtitle => 'Badilisha alama zako kuwa asilimia';

  @override
  String get fieldScore => 'Alama zako';

  @override
  String get fieldTotalMarks => 'Jumla ya alama';

  @override
  String get resultPercentage => 'Asilimia';

  @override
  String get resultMarksLost => 'Alama zilizopotea';

  @override
  String get calcLoanTitle => 'Mkopo na Riba';

  @override
  String get calcLoanSubtitle => 'Malipo ya kila mwezi na jumla ya riba';

  @override
  String get fieldLoanAmount => 'Kiasi cha mkopo';

  @override
  String get fieldInterestRate => 'Kiwango cha riba (kwa mwaka)';

  @override
  String get fieldTermYears => 'Muda (miaka)';

  @override
  String get resultMonthlyPayment => 'Malipo ya kila mwezi';

  @override
  String get resultTotalPayment => 'Jumla ya malipo';

  @override
  String get resultTotalInterest => 'Jumla ya riba';

  @override
  String get historyTitle => 'Historia';

  @override
  String get historyEmpty => 'Hesabu zako zitaonekana hapa.';

  @override
  String get historyClear => 'Futa historia';

  @override
  String get historyClearConfirm => 'Futa hesabu zote zilizohifadhiwa?';

  @override
  String get historyDeleted => 'Hesabu imefutwa';

  @override
  String get undo => 'Tendua';

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get settingsTheme => 'Mandhari';

  @override
  String get themeSystem => 'Chaguo-msingi la mfumo';

  @override
  String get themeLight => 'Angavu';

  @override
  String get themeDark => 'Giza';

  @override
  String get settingsLanguage => 'Lugha';

  @override
  String get languageSystem => 'Chaguo-msingi la mfumo';

  @override
  String get aboutDescription =>
      'Kokotoa kwa urahisi asilimia, bakshishi, punguzo, kodi, alama na mikopo. Rahisi, haraka na bure.';

  @override
  String aboutVersion(String version) {
    return 'Toleo $version';
  }

  @override
  String get reportBugIntro =>
      'Umekutana na hitilafu au programu kufunga ghafla? Una wazo la kuiboresha? Tungependa kusikia kutoka kwako — maoni yako ni ya thamani kubwa.';

  @override
  String get reportBugLabel => 'Eleza tatizo au wazo lako';

  @override
  String get reportBugHint => 'mf. Programu inafunga ninapozungusha skrini';

  @override
  String get reportBugSend => 'Tuma';

  @override
  String reportBugNoEmail(String email) {
    return 'Hakuna programu ya barua pepe. Tafadhali tuandikie kwa $email';
  }

  @override
  String get updateAvailableTitle => 'Sasisho linapatikana';

  @override
  String get updateAvailableMessage =>
      'Toleo jipya la Kikokotoo cha Asilimia linapatikana likiwa na maboresho na marekebisho.';

  @override
  String get updateRequiredTitle => 'Sasisho linahitajika';

  @override
  String get updateRequiredMessage =>
      'Toleo hili halitumiki tena. Tafadhali sasisha ili kuendelea kutumia programu.';

  @override
  String get updateNow => 'Sasisha sasa';

  @override
  String get later => 'Baadaye';

  @override
  String get premiumTitle => 'Bila matangazo';

  @override
  String get premiumDescription =>
      'Malipo ya mara moja. Huondoa matangazo yote na kufungua ziada zote.';

  @override
  String premiumBuy(String price) {
    return 'Ondoa matangazo – $price';
  }

  @override
  String get premiumActive => 'Huna matangazo tena. Asante kwa msaada wako!';

  @override
  String get restorePurchases => 'Rejesha ununuzi';

  @override
  String get purchaseUnavailable => 'Ununuzi haupatikani kwa sasa.';

  @override
  String get purchaseFailed => 'Ununuzi haukufanikiwa. Tafadhali jaribu tena.';

  @override
  String get settingsColor => 'Rangi';

  @override
  String get unlockColorsTitle => 'Fungua rangi zote';

  @override
  String get unlockColorsMessage =>
      'Tazama tangazo fupi la video ili kufungua rangi zote bure, au ondoa matangazo ili kufungua kila kitu.';

  @override
  String get exportTitle => 'Hamisha historia';

  @override
  String get exportMessage =>
      'Tazama tangazo fupi la video ili kuhamisha historia yako kama jedwali (CSV), au ondoa matangazo ili kuhamisha wakati wowote.';

  @override
  String get watchAd => 'Tazama tangazo';

  @override
  String get adNotReady =>
      'Hakuna tangazo kwa sasa. Tafadhali jaribu tena baada ya muda mfupi.';

  @override
  String get colorsUnlocked => 'Rangi zote zimefunguliwa!';

  @override
  String get exportCsv => 'Hamisha kama CSV';

  @override
  String get csvDate => 'Tarehe';

  @override
  String get csvCalculator => 'Kikokotoo';

  @override
  String get csvInputs => 'Ulichoingiza';

  @override
  String get csvResults => 'Matokeo';

  @override
  String get widgetEmpty => 'Hesabu yako ya mwisho itaonekana hapa';

  @override
  String get featuresTitle => 'Vipengele';

  @override
  String get featCalculators => 'Vikokotoo 11';

  @override
  String get featCalculatorsDesc =>
      'Asilimia, ni % ngapi, ongezeko, upungufu, mabadiliko, punguzo, bakshishi na kugawana bili, VAT, faida, alama za mtihani, mkopo na riba';

  @override
  String get featInstant => 'Matokeo papo hapo';

  @override
  String get featInstantDesc =>
      'Majibu yanaonekana unapoandika. Gusa kunakili au kushiriki.';

  @override
  String get featHistory => 'Historia na kuhamisha';

  @override
  String get featHistoryDesc =>
      'Kila hesabu huhifadhiwa. Ifungue tena au uihamishe kama CSV.';

  @override
  String get featWidget => 'Wijeti na njia za mkato';

  @override
  String get featWidgetDesc =>
      'Ona jibu lako la mwisho kwenye skrini ya mwanzo. Bonyeza aikoni kwa muda kwa njia za mkato.';

  @override
  String get featStyle => 'Mtindo wako';

  @override
  String get featStyleDesc =>
      'Mandhari angavu na giza pamoja na rangi za kuchagua.';

  @override
  String get featLanguages => 'Lugha 7';

  @override
  String get featPrivate => 'Faragha';

  @override
  String get featPrivateDesc =>
      'Hakuna akaunti inayohitajika. Namba zako zinabaki kwenye kifaa chako.';

  @override
  String get featAdFree => 'Chaguo bila matangazo';

  @override
  String get featAdFreeDesc =>
      'Malipo ya mara moja huondoa matangazo yote na kufungua ziada zote.';

  @override
  String get aiTitle => 'Msaidizi wa AI';

  @override
  String get aiWelcome =>
      'Uliza kuhusu hesabu ulizohifadhi, au andika hesabu kwa maneno yako mwenyewe.';

  @override
  String get aiHint => 'Uliza au andika hesabu…';

  @override
  String get aiSuggestion1 => 'Nimeokoa kiasi gani kwa punguzo?';

  @override
  String get aiSuggestion2 => 'Punguzo la 15% kwa 2,400 pamoja na VAT 7.5%';

  @override
  String get aiSuggestion3 => 'Wastani wa bakshishi niliyotoa ni kiasi gani?';

  @override
  String get aiInsightsTitle => 'Maarifa';

  @override
  String get aiInsightsButton => 'Pata maarifa';

  @override
  String get aiInsightsEmpty =>
      'Fanya hesabu chache kwanza, kisha urudi kupata maarifa.';

  @override
  String get aiThinking => 'Inafikiri…';

  @override
  String get aiOpenCalculator => 'Fungua';

  @override
  String aiStep(int n) {
    return 'Hatua $n';
  }

  @override
  String get aiReport => 'Ripoti jibu';

  @override
  String aiRemaining(int count) {
    return 'Maswali $count ya AI yamebaki leo';
  }

  @override
  String get aiQuotaReached => 'Umetumia maswali yako ya AI ya leo.';

  @override
  String get aiWatchAdMore => 'Tazama tangazo upate 5 zaidi';

  @override
  String get aiPremiumMore => 'Bila matangazo: 30 kwa siku';

  @override
  String get aiConsentTitle => 'Tumia msaidizi wa AI?';

  @override
  String get aiConsentMessage =>
      'Ili kujibu, swali lako na hesabu ulizohifadhi hutumwa kwa huduma ya AI (kwa sasa Google Gemini). Hakuna kinachotumwa hadi uulize, na hakuna akaunti wala jina linalojumuishwa. Tafadhali usiandike taarifa binafsi kwenye maswali yako.';

  @override
  String get aiConsentAgree => 'Kubali';

  @override
  String get aiDisclaimer =>
      'AI inaweza kukosea. Namba zinatoka kwenye kikokotoo, si AI.';

  @override
  String get aiErrorGeneric => 'Hitilafu imetokea. Tafadhali jaribu tena.';

  @override
  String get aiErrorOffline =>
      'Hakuna mtandao. Angalia intaneti yako ujaribu tena.';

  @override
  String get aiErrorBusy =>
      'Msaidizi wa AI ana shughuli nyingi. Jaribu tena baadaye.';

  @override
  String get aiErrorRefused => 'AI haiwezi kusaidia na ombi hilo.';

  @override
  String get aiExplain => 'Eleza';

  @override
  String get aiExplainTitle => 'Jinsi inavyokokotolewa';

  @override
  String get aiInvalidStep => 'Hesabu hii haiwezi kufanyika kwa namba hizo.';

  @override
  String get aiBonusAdded => 'Maswali 5 zaidi yameongezwa!';

  @override
  String get aiErrorUnavailable => 'Msaidizi wa AI haupatikani kwa sasa.';
}
