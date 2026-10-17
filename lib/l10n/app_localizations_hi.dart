// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'प्रतिशत कैलकुलेटर';

  @override
  String get homeTitle => '% कैलकुलेटर';

  @override
  String get menuHistory => 'इतिहास';

  @override
  String get menuSettings => 'सेटिंग्स';

  @override
  String get menuShareApp => 'ऐप शेयर करें';

  @override
  String get menuRateApp => 'ऐप को रेट करें';

  @override
  String get menuReportBug => 'बग रिपोर्ट करें';

  @override
  String get menuPrivacySettings => 'गोपनीयता सेटिंग्स';

  @override
  String get menuPrivacyPolicy => 'गोपनीयता नीति';

  @override
  String get menuAbout => 'परिचय';

  @override
  String get menuExit => 'बाहर निकलें';

  @override
  String get exitTitle => 'क्या आप निश्चित हैं?';

  @override
  String get exitMessage => 'क्या आप ऐप से बाहर निकलना चाहते हैं?';

  @override
  String get no => 'नहीं';

  @override
  String get yes => 'हाँ';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get share => 'शेयर करें';

  @override
  String get reset => 'रीसेट';

  @override
  String get calculate => 'गणना करें';

  @override
  String get shareResultTooltip => 'परिणाम शेयर करें';

  @override
  String copied(String label) {
    return '$label कॉपी किया गया';
  }

  @override
  String get errorRequired => 'कोई मान दर्ज करें';

  @override
  String get errorInvalidNumber => 'सही संख्या दर्ज करें';

  @override
  String get errorNegative => 'ऋणात्मक नहीं होना चाहिए';

  @override
  String get errorWholeNumber => 'पूर्ण संख्या दर्ज करें';

  @override
  String get errorAtLeastOne => 'कम से कम 1 होना चाहिए';

  @override
  String get errorBelow100 => '100% से कम होना चाहिए';

  @override
  String get errorNotZero => '0 नहीं हो सकता';

  @override
  String get errorPositive => '0 से अधिक होना चाहिए';

  @override
  String hintExample(String value) {
    return 'जैसे $value';
  }

  @override
  String get resultsHeader => 'परिणाम';

  @override
  String get sharedFrom => 'प्रतिशत कैलकुलेटर से गणना की गई';

  @override
  String shareAppText(String url) {
    return 'मैं प्रतिशत, टिप, छूट और बहुत कुछ जल्दी निकालने के लिए प्रतिशत कैलकुलेटर का उपयोग करता/करती हूँ। आप भी आज़माएँ: $url';
  }

  @override
  String get calcPercentageTitle => 'प्रतिशत निकालें';

  @override
  String get calcPercentageSubtitle => 'किसी भी संख्या का प्रतिशत जानें';

  @override
  String get fieldPercentage => 'प्रतिशत';

  @override
  String get fieldValue => 'मान';

  @override
  String get fieldAmount => 'राशि';

  @override
  String get fieldIncreaseBy => 'इतना बढ़ाएँ';

  @override
  String get fieldDecreaseBy => 'इतना घटाएँ';

  @override
  String get resultResult => 'परिणाम';

  @override
  String get resultIncrease => 'वृद्धि';

  @override
  String get resultDecrease => 'कमी';

  @override
  String get calcIncreaseTitle => 'प्रतिशत वृद्धि';

  @override
  String get calcIncreaseSubtitle => 'किसी संख्या को प्रतिशत से बढ़ाएँ';

  @override
  String get calcDecreaseTitle => 'प्रतिशत कमी';

  @override
  String get calcDecreaseSubtitle => 'किसी संख्या को प्रतिशत से घटाएँ';

  @override
  String get calcTipTitle => 'टिप और बिल बँटवारा';

  @override
  String get calcTipSubtitle => 'टिप निकालें और बिल बाँटें';

  @override
  String get fieldBillAmount => 'बिल की राशि';

  @override
  String get fieldPeople => 'लोगों की संख्या';

  @override
  String get fieldTipPercent => 'टिप';

  @override
  String get resultTipAmount => 'टिप की राशि';

  @override
  String get resultTipPerPerson => 'प्रति व्यक्ति टिप';

  @override
  String get resultTotalToPay => 'कुल भुगतान';

  @override
  String get resultTotalPerPerson => 'प्रति व्यक्ति कुल';

  @override
  String get calcMarginTitle => 'लाभ मार्जिन';

  @override
  String get calcMarginSubtitle => 'मार्जिन के अनुसार बिक्री मूल्य जानें';

  @override
  String get fieldCost => 'लागत';

  @override
  String get fieldMargin => 'मार्जिन';

  @override
  String get resultPrice => 'बिक्री मूल्य';

  @override
  String get resultProfit => 'लाभ';

  @override
  String get resultMarkup => 'मार्कअप';

  @override
  String get calcChangeTitle => 'प्रतिशत परिवर्तन';

  @override
  String get calcChangeSubtitle => 'कोई मान कितना बढ़ा या घटा';

  @override
  String get fieldInitialValue => 'प्रारंभिक मान';

  @override
  String get fieldFinalValue => 'अंतिम मान';

  @override
  String get resultPercentChange => 'प्रतिशत परिवर्तन';

  @override
  String get resultDifference => 'अंतर';

  @override
  String get calcPercentOfTitle => 'कितना % है';

  @override
  String get calcPercentOfSubtitle => 'एक मान दूसरे का कितना प्रतिशत है';

  @override
  String get fieldPart => 'मान';

  @override
  String get fieldWhole => 'इसका कितना % है';

  @override
  String get calcDiscountTitle => 'छूट';

  @override
  String get calcDiscountSubtitle => 'छूट के बाद की कीमत और आपकी बचत';

  @override
  String get fieldOriginalPrice => 'मूल कीमत';

  @override
  String get fieldDiscount => 'छूट';

  @override
  String get resultFinalPrice => 'अंतिम कीमत';

  @override
  String get resultYouSave => 'आपकी बचत';

  @override
  String get calcTaxTitle => 'GST / VAT / कर';

  @override
  String get calcTaxSubtitle => 'कीमत में कर जोड़ें या हटाएँ';

  @override
  String get fieldTaxRate => 'कर दर';

  @override
  String get resultWithTax => 'कर सहित कीमत';

  @override
  String get resultTaxAdded => 'जोड़ा गया कर';

  @override
  String get resultWithoutTax => 'कर रहित कीमत';

  @override
  String get resultTaxIncluded => 'शामिल कर';

  @override
  String get calcGradeTitle => 'परीक्षा अंक';

  @override
  String get calcGradeSubtitle => 'अपने अंकों को प्रतिशत में बदलें';

  @override
  String get fieldScore => 'प्राप्त अंक';

  @override
  String get fieldTotalMarks => 'कुल अंक';

  @override
  String get resultPercentage => 'प्रतिशत';

  @override
  String get resultMarksLost => 'कटे अंक';

  @override
  String get calcLoanTitle => 'लोन और ब्याज';

  @override
  String get calcLoanSubtitle => 'मासिक किस्त (EMI) और कुल ब्याज';

  @override
  String get fieldLoanAmount => 'लोन राशि';

  @override
  String get fieldInterestRate => 'ब्याज दर (वार्षिक)';

  @override
  String get fieldTermYears => 'अवधि (वर्ष)';

  @override
  String get resultMonthlyPayment => 'मासिक किस्त (EMI)';

  @override
  String get resultTotalPayment => 'कुल भुगतान';

  @override
  String get resultTotalInterest => 'कुल ब्याज';

  @override
  String get historyTitle => 'इतिहास';

  @override
  String get historyEmpty => 'आपकी गणनाएँ यहाँ दिखेंगी।';

  @override
  String get historyClear => 'इतिहास साफ़ करें';

  @override
  String get historyClearConfirm => 'सभी सहेजी गई गणनाएँ हटाएँ?';

  @override
  String get historyDeleted => 'गणना हटा दी गई';

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsTheme => 'थीम';

  @override
  String get themeSystem => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get languageSystem => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get aboutDescription =>
      'प्रतिशत, टिप, छूट, कर, अंक और लोन की आसानी से गणना करें। सरल, तेज़ और मुफ़्त।';

  @override
  String aboutVersion(String version) {
    return 'संस्करण $version';
  }

  @override
  String get reportBugIntro =>
      'कोई क्रैश या बग मिला? ऐप को बेहतर बनाने का कोई विचार है? हमें बताइए — आपकी राय हमारे लिए अनमोल है।';

  @override
  String get reportBugLabel => 'समस्या या अपना विचार लिखें';

  @override
  String get reportBugHint => 'जैसे स्क्रीन घुमाने पर ऐप बंद हो जाता है';

  @override
  String get reportBugSend => 'भेजें';

  @override
  String reportBugNoEmail(String email) {
    return 'कोई ईमेल ऐप नहीं मिला। कृपया हमें $email पर लिखें';
  }

  @override
  String get updateAvailableTitle => 'अपडेट उपलब्ध है';

  @override
  String get updateAvailableMessage =>
      'प्रतिशत कैलकुलेटर का नया संस्करण सुधारों के साथ उपलब्ध है।';

  @override
  String get updateRequiredTitle => 'अपडेट ज़रूरी है';

  @override
  String get updateRequiredMessage =>
      'यह संस्करण अब समर्थित नहीं है। ऐप का उपयोग जारी रखने के लिए कृपया अपडेट करें।';

  @override
  String get updateNow => 'अभी अपडेट करें';

  @override
  String get later => 'बाद में';

  @override
  String get premiumTitle => 'विज्ञापन-मुक्त बनें';

  @override
  String get premiumDescription =>
      'एक बार की खरीद। सभी विज्ञापन हटाती है और सभी अतिरिक्त सुविधाएँ अनलॉक करती है।';

  @override
  String premiumBuy(String price) {
    return 'विज्ञापन हटाएँ – $price';
  }

  @override
  String get premiumActive =>
      'आप विज्ञापन-मुक्त हैं। आपके समर्थन के लिए धन्यवाद!';

  @override
  String get restorePurchases => 'खरीदारी पुनर्स्थापित करें';

  @override
  String get purchaseUnavailable => 'अभी खरीदारी उपलब्ध नहीं है।';

  @override
  String get purchaseFailed =>
      'खरीदारी पूरी नहीं हुई। कृपया फिर से कोशिश करें।';

  @override
  String get settingsColor => 'रंग';

  @override
  String get unlockColorsTitle => 'सभी रंग अनलॉक करें';

  @override
  String get unlockColorsMessage =>
      'सभी रंग मुफ़्त में अनलॉक करने के लिए एक छोटा वीडियो विज्ञापन देखें, या सब कुछ अनलॉक करने के लिए विज्ञापन-मुक्त बनें।';

  @override
  String get exportTitle => 'इतिहास निर्यात करें';

  @override
  String get exportMessage =>
      'अपना इतिहास स्प्रेडशीट (CSV) के रूप में निर्यात करने के लिए एक छोटा वीडियो विज्ञापन देखें, या कभी भी निर्यात करने के लिए विज्ञापन-मुक्त बनें।';

  @override
  String get watchAd => 'विज्ञापन देखें';

  @override
  String get adNotReady =>
      'अभी कोई विज्ञापन उपलब्ध नहीं है। कृपया थोड़ी देर बाद फिर कोशिश करें।';

  @override
  String get colorsUnlocked => 'सभी रंग अनलॉक हो गए!';

  @override
  String get exportCsv => 'CSV के रूप में निर्यात करें';

  @override
  String get csvDate => 'तारीख';

  @override
  String get csvCalculator => 'कैलकुलेटर';

  @override
  String get csvInputs => 'दर्ज मान';

  @override
  String get csvResults => 'परिणाम';

  @override
  String get widgetEmpty => 'आपकी पिछली गणना यहाँ दिखेगी';

  @override
  String get featuresTitle => 'सुविधाएँ';

  @override
  String get featCalculators => '11 कैलकुलेटर';

  @override
  String get featCalculatorsDesc =>
      'प्रतिशत, कितना %, वृद्धि, कमी, परिवर्तन, छूट, टिप और बिल बँटवारा, GST/VAT, लाभ मार्जिन, परीक्षा अंक, लोन और ब्याज';

  @override
  String get featInstant => 'तुरंत परिणाम';

  @override
  String get featInstantDesc =>
      'टाइप करते ही जवाब दिखते हैं। कॉपी या शेयर करने के लिए टैप करें।';

  @override
  String get featHistory => 'इतिहास और निर्यात';

  @override
  String get featHistoryDesc =>
      'हर गणना सहेजी जाती है। उसे फिर से खोलें या CSV में निर्यात करें।';

  @override
  String get featWidget => 'विजेट और शॉर्टकट';

  @override
  String get featWidgetDesc =>
      'होम स्क्रीन पर अपना पिछला परिणाम देखें। शॉर्टकट के लिए ऐप आइकन को देर तक दबाएँ।';

  @override
  String get featStyle => 'आपकी शैली';

  @override
  String get featStyleDesc => 'लाइट और डार्क मोड, पसंदीदा रंगों के साथ।';

  @override
  String get featLanguages => '7 भाषाएँ';

  @override
  String get featPrivate => 'निजी';

  @override
  String get featPrivateDesc =>
      'किसी खाते की ज़रूरत नहीं। आपके नंबर आपके डिवाइस पर ही रहते हैं।';

  @override
  String get featAdFree => 'विज्ञापन-मुक्त विकल्प';

  @override
  String get featAdFreeDesc =>
      'एक बार की खरीद से सभी विज्ञापन हटते हैं और सभी अतिरिक्त सुविधाएँ अनलॉक होती हैं।';

  @override
  String get aiTitle => 'AI सहायक';

  @override
  String get aiWelcome =>
      'अपनी सहेजी गई गणनाओं के बारे में पूछें, या अपने शब्दों में कोई गणना लिखें।';

  @override
  String get aiHint => 'पूछें या गणना लिखें…';

  @override
  String get aiSuggestion1 => 'मैंने छूट से कितना बचाया?';

  @override
  String get aiSuggestion2 => '2,400 पर 15% छूट और 7.5% GST';

  @override
  String get aiSuggestion3 => 'मैंने औसतन कितनी टिप दी?';

  @override
  String get aiInsightsTitle => 'जानकारी';

  @override
  String get aiInsightsButton => 'जानकारी पाएँ';

  @override
  String get aiInsightsEmpty =>
      'पहले कुछ गणनाएँ करें, फिर जानकारी के लिए वापस आएँ।';

  @override
  String get aiThinking => 'सोच रहा है…';

  @override
  String get aiOpenCalculator => 'खोलें';

  @override
  String aiStep(int n) {
    return 'चरण $n';
  }

  @override
  String get aiReport => 'जवाब की शिकायत करें';

  @override
  String aiRemaining(int count) {
    return 'आज $count AI सवाल बचे हैं';
  }

  @override
  String get aiQuotaReached => 'आपने आज के AI सवाल इस्तेमाल कर लिए हैं।';

  @override
  String get aiWatchAdMore => '5 और के लिए विज्ञापन देखें';

  @override
  String get aiPremiumMore => 'विज्ञापन-मुक्त: रोज़ 30';

  @override
  String get aiConsentTitle => 'AI सहायक का उपयोग करें?';

  @override
  String get aiConsentMessage =>
      'जवाब देने के लिए आपका सवाल और आपकी सहेजी गई गणनाएँ एक AI सेवा (अभी Google Gemini) को भेजी जाती हैं। जब तक आप पूछते नहीं, कुछ नहीं भेजा जाता, और कोई खाता या नाम शामिल नहीं होता। कृपया अपने सवालों में निजी जानकारी न लिखें।';

  @override
  String get aiConsentAgree => 'सहमत हूँ';

  @override
  String get aiDisclaimer =>
      'AI गलती कर सकता है। संख्याएँ कैलकुलेटर से आती हैं, AI से नहीं।';

  @override
  String get aiErrorGeneric => 'कुछ गलत हो गया। कृपया फिर से कोशिश करें।';

  @override
  String get aiErrorOffline =>
      'कनेक्शन नहीं है। इंटरनेट जाँचें और फिर कोशिश करें।';

  @override
  String get aiErrorBusy => 'AI सहायक अभी व्यस्त है। बाद में कोशिश करें।';

  @override
  String get aiErrorRefused => 'AI इस अनुरोध में मदद नहीं कर सकता।';

  @override
  String get aiExplain => 'समझाएँ';

  @override
  String get aiExplainTitle => 'यह कैसे निकाला गया';

  @override
  String get aiInvalidStep => 'इन संख्याओं से यह गणना नहीं हो सकती।';

  @override
  String get aiBonusAdded => '5 और सवाल जोड़े गए!';

  @override
  String get aiErrorUnavailable => 'AI सहायक अभी उपलब्ध नहीं है।';
}
