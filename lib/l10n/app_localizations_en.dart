// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Percentage Calculator';

  @override
  String get homeTitle => '% Calculator';

  @override
  String get menuHistory => 'History';

  @override
  String get menuSettings => 'Settings';

  @override
  String get menuShareApp => 'Share App';

  @override
  String get menuRateApp => 'Rate App';

  @override
  String get menuReportBug => 'Report Bug';

  @override
  String get menuPrivacySettings => 'Privacy Settings';

  @override
  String get menuPrivacyPolicy => 'Privacy Policy';

  @override
  String get menuAbout => 'About';

  @override
  String get menuExit => 'Exit';

  @override
  String get exitTitle => 'Are you sure?';

  @override
  String get exitMessage => 'Do you want to exit the app?';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get share => 'Share';

  @override
  String get reset => 'Reset';

  @override
  String get calculate => 'Calculate';

  @override
  String get shareResultTooltip => 'Share result';

  @override
  String copied(String label) {
    return '$label copied';
  }

  @override
  String get errorRequired => 'Enter a value';

  @override
  String get errorInvalidNumber => 'Enter a valid number';

  @override
  String get errorNegative => 'Must not be negative';

  @override
  String get errorWholeNumber => 'Enter a whole number';

  @override
  String get errorAtLeastOne => 'Must be at least 1';

  @override
  String get errorBelow100 => 'Must be below 100%';

  @override
  String get errorNotZero => 'Cannot be 0';

  @override
  String get errorPositive => 'Must be greater than 0';

  @override
  String hintExample(String value) {
    return 'e.g. $value';
  }

  @override
  String get resultsHeader => 'Results';

  @override
  String get sharedFrom => 'Calculated with Percentage Calculator';

  @override
  String shareAppText(String url) {
    return 'I use Percentage Calculator for quick percentages, tips, discounts and more. Try it: $url';
  }

  @override
  String get calcPercentageTitle => 'Calculate Percentage';

  @override
  String get calcPercentageSubtitle => 'Find the percentage of any number';

  @override
  String get fieldPercentage => 'Percentage';

  @override
  String get fieldValue => 'Value';

  @override
  String get fieldAmount => 'Amount';

  @override
  String get fieldIncreaseBy => 'Increase by';

  @override
  String get fieldDecreaseBy => 'Decrease by';

  @override
  String get resultResult => 'Result';

  @override
  String get resultIncrease => 'Increase';

  @override
  String get resultDecrease => 'Decrease';

  @override
  String get calcIncreaseTitle => 'Percentage Increase';

  @override
  String get calcIncreaseSubtitle => 'Increase a number by a percentage';

  @override
  String get calcDecreaseTitle => 'Percentage Decrease';

  @override
  String get calcDecreaseSubtitle => 'Decrease a number by a percentage';

  @override
  String get calcTipTitle => 'Tip & Split Bill';

  @override
  String get calcTipSubtitle => 'Work out the tip and split the bill';

  @override
  String get fieldBillAmount => 'Bill amount';

  @override
  String get fieldPeople => 'Number of people';

  @override
  String get fieldTipPercent => 'Tip';

  @override
  String get resultTipAmount => 'Tip amount';

  @override
  String get resultTipPerPerson => 'Tip per person';

  @override
  String get resultTotalToPay => 'Total to pay';

  @override
  String get resultTotalPerPerson => 'Total per person';

  @override
  String get calcMarginTitle => 'Profit Margin';

  @override
  String get calcMarginSubtitle => 'Find the selling price for a profit margin';

  @override
  String get fieldCost => 'Cost';

  @override
  String get fieldMargin => 'Margin';

  @override
  String get resultPrice => 'Selling price';

  @override
  String get resultProfit => 'Profit';

  @override
  String get resultMarkup => 'Markup';

  @override
  String get calcChangeTitle => 'Percentage Change';

  @override
  String get calcChangeSubtitle => 'How much a value has gone up or down';

  @override
  String get fieldInitialValue => 'Initial value';

  @override
  String get fieldFinalValue => 'Final value';

  @override
  String get resultPercentChange => 'Percentage change';

  @override
  String get resultDifference => 'Difference';

  @override
  String get calcPercentOfTitle => 'What % of';

  @override
  String get calcPercentOfSubtitle => 'What percentage one value is of another';

  @override
  String get fieldPart => 'Value';

  @override
  String get fieldWhole => 'Is what % of';

  @override
  String get calcDiscountTitle => 'Discount';

  @override
  String get calcDiscountSubtitle => 'Sale price and how much you save';

  @override
  String get fieldOriginalPrice => 'Original price';

  @override
  String get fieldDiscount => 'Discount';

  @override
  String get resultFinalPrice => 'Final price';

  @override
  String get resultYouSave => 'You save';

  @override
  String get calcTaxTitle => 'VAT / Sales Tax';

  @override
  String get calcTaxSubtitle => 'Add or remove tax from a price';

  @override
  String get fieldTaxRate => 'Tax rate';

  @override
  String get resultWithTax => 'Price with tax added';

  @override
  String get resultTaxAdded => 'Tax added';

  @override
  String get resultWithoutTax => 'Price with tax removed';

  @override
  String get resultTaxIncluded => 'Tax included';

  @override
  String get calcGradeTitle => 'Exam Grade';

  @override
  String get calcGradeSubtitle => 'Turn your marks into a percentage';

  @override
  String get fieldScore => 'Your score';

  @override
  String get fieldTotalMarks => 'Total marks';

  @override
  String get resultPercentage => 'Percentage';

  @override
  String get resultMarksLost => 'Marks lost';

  @override
  String get calcLoanTitle => 'Loan & Interest';

  @override
  String get calcLoanSubtitle => 'Monthly payment and total interest';

  @override
  String get fieldLoanAmount => 'Loan amount';

  @override
  String get fieldInterestRate => 'Interest rate (per year)';

  @override
  String get fieldTermYears => 'Term (years)';

  @override
  String get resultMonthlyPayment => 'Monthly payment';

  @override
  String get resultTotalPayment => 'Total payment';

  @override
  String get resultTotalInterest => 'Total interest';

  @override
  String get historyTitle => 'History';

  @override
  String get historyEmpty => 'Your calculations will appear here.';

  @override
  String get historyClear => 'Clear history';

  @override
  String get historyClearConfirm => 'Delete all saved calculations?';

  @override
  String get historyDeleted => 'Calculation deleted';

  @override
  String get undo => 'Undo';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get themeSystem => 'System default';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get aboutDescription =>
      'Effortlessly calculate percentages, tips, discounts, taxes, grades and loans. Simple, fast and free.';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get reportBugIntro =>
      'Found a crash or a bug? Have an idea to make the app better? We\'d love to hear from you — your feedback is priceless.';

  @override
  String get reportBugLabel => 'Describe the problem or your idea';

  @override
  String get reportBugHint => 'e.g. The app crashes when I rotate the screen';

  @override
  String get reportBugSend => 'Send';

  @override
  String reportBugNoEmail(String email) {
    return 'No email app found. Please write to $email';
  }

  @override
  String get updateAvailableTitle => 'Update available';

  @override
  String get updateAvailableMessage =>
      'A new version of Percentage Calculator is available with improvements and fixes.';

  @override
  String get updateRequiredTitle => 'Update required';

  @override
  String get updateRequiredMessage =>
      'This version is no longer supported. Please update to keep using the app.';

  @override
  String get updateNow => 'Update now';

  @override
  String get later => 'Later';

  @override
  String get premiumTitle => 'Go ad-free';

  @override
  String get premiumDescription =>
      'One-time purchase. Removes all ads and unlocks every extra.';

  @override
  String premiumBuy(String price) {
    return 'Remove ads – $price';
  }

  @override
  String get premiumActive => 'You\'re ad-free. Thank you for your support!';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get purchaseUnavailable => 'Purchases aren\'t available right now.';

  @override
  String get purchaseFailed =>
      'The purchase didn\'t go through. Please try again.';

  @override
  String get settingsColor => 'Color';

  @override
  String get unlockColorsTitle => 'Unlock all colors';

  @override
  String get unlockColorsMessage =>
      'Watch a short video ad to unlock every color for free, or go ad-free to unlock everything.';

  @override
  String get exportTitle => 'Export history';

  @override
  String get exportMessage =>
      'Watch a short video ad to export your history as a spreadsheet (CSV), or go ad-free to export any time.';

  @override
  String get watchAd => 'Watch ad';

  @override
  String get adNotReady =>
      'No ad is available right now. Please try again in a moment.';

  @override
  String get colorsUnlocked => 'All colors unlocked!';

  @override
  String get exportCsv => 'Export as CSV';

  @override
  String get csvDate => 'Date';

  @override
  String get csvCalculator => 'Calculator';

  @override
  String get csvInputs => 'Inputs';

  @override
  String get csvResults => 'Results';

  @override
  String get widgetEmpty => 'Your last calculation will appear here';

  @override
  String get featuresTitle => 'Features';

  @override
  String get featCalculators => '11 calculators';

  @override
  String get featCalculatorsDesc =>
      'Percentage, what % of, increase, decrease, change, discount, tip & split bill, VAT, profit margin, exam grade, loan & interest';

  @override
  String get featInstant => 'Instant results';

  @override
  String get featInstantDesc =>
      'Answers appear as you type. Tap to copy or share.';

  @override
  String get featHistory => 'History & export';

  @override
  String get featHistoryDesc =>
      'Every calculation is saved. Reopen it or export it as CSV.';

  @override
  String get featWidget => 'Widget & shortcuts';

  @override
  String get featWidgetDesc =>
      'See your last result on the home screen. Long-press the app icon for shortcuts.';

  @override
  String get featStyle => 'Your style';

  @override
  String get featStyleDesc => 'Light and dark mode with accent colours.';

  @override
  String get featLanguages => '7 languages';

  @override
  String get featPrivate => 'Private';

  @override
  String get featPrivateDesc =>
      'No account needed. Your numbers stay on your device.';

  @override
  String get featAdFree => 'Ad-free option';

  @override
  String get featAdFreeDesc =>
      'A one-time purchase removes all ads and unlocks every extra.';

  @override
  String get aiTitle => 'AI assistant';

  @override
  String get aiWelcome =>
      'Ask about your saved calculations, or type a calculation in your own words.';

  @override
  String get aiHint => 'Ask or type a calculation…';

  @override
  String get aiSuggestion1 => 'How much have I saved with discounts?';

  @override
  String get aiSuggestion2 => '15% off 2,400 plus 7.5% VAT';

  @override
  String get aiSuggestion3 => 'What\'s the average tip I gave?';

  @override
  String get aiInsightsTitle => 'Insights';

  @override
  String get aiInsightsButton => 'Get insights';

  @override
  String get aiInsightsEmpty =>
      'Do a few calculations first, then come back for insights.';

  @override
  String get aiThinking => 'Thinking…';

  @override
  String get aiOpenCalculator => 'Open';

  @override
  String aiStep(int n) {
    return 'Step $n';
  }

  @override
  String get aiReport => 'Report answer';

  @override
  String aiRemaining(int count) {
    return '$count AI questions left today';
  }

  @override
  String get aiQuotaReached => 'You\'ve used today\'s AI questions.';

  @override
  String get aiWatchAdMore => 'Watch an ad for 5 more';

  @override
  String get aiPremiumMore => 'Go ad-free for 30 a day';

  @override
  String get aiConsentTitle => 'Use the AI assistant?';

  @override
  String get aiConsentMessage =>
      'To answer, your question and your saved calculations are sent to an AI service (currently Google Gemini). Nothing is sent until you ask, and no account or name is included. Please don\'t type personal information in your questions.';

  @override
  String get aiConsentAgree => 'Agree';

  @override
  String get aiDisclaimer =>
      'AI can make mistakes. Numbers come from the calculator, not the AI.';

  @override
  String get aiErrorGeneric => 'Something went wrong. Please try again.';

  @override
  String get aiErrorOffline =>
      'No connection. Check your internet and try again.';

  @override
  String get aiErrorBusy => 'The AI assistant is busy. Please try again later.';

  @override
  String get aiErrorRefused => 'The AI can\'t help with that request.';

  @override
  String get aiExplain => 'Explain';

  @override
  String get aiExplainTitle => 'How it\'s calculated';

  @override
  String get aiInvalidStep =>
      'This calculation couldn\'t be done with those numbers.';

  @override
  String get aiBonusAdded => '5 more questions added!';

  @override
  String get aiErrorUnavailable =>
      'The AI assistant isn\'t available right now.';
}
