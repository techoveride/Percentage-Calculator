import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('pt'),
    Locale('sw'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Percentage Calculator'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'% Calculator'**
  String get homeTitle;

  /// No description provided for @menuHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get menuHistory;

  /// No description provided for @menuSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get menuSettings;

  /// No description provided for @menuShareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get menuShareApp;

  /// No description provided for @menuRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get menuRateApp;

  /// No description provided for @menuReportBug.
  ///
  /// In en, this message translates to:
  /// **'Report Bug'**
  String get menuReportBug;

  /// No description provided for @menuPrivacySettings.
  ///
  /// In en, this message translates to:
  /// **'Privacy Settings'**
  String get menuPrivacySettings;

  /// No description provided for @menuPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get menuPrivacyPolicy;

  /// No description provided for @menuAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menuAbout;

  /// No description provided for @menuExit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get menuExit;

  /// No description provided for @exitTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get exitTitle;

  /// No description provided for @exitMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit the app?'**
  String get exitMessage;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @shareResultTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share result'**
  String get shareResultTooltip;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'{label} copied'**
  String copied(String label);

  /// No description provided for @errorRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a value'**
  String get errorRequired;

  /// No description provided for @errorInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get errorInvalidNumber;

  /// No description provided for @errorNegative.
  ///
  /// In en, this message translates to:
  /// **'Must not be negative'**
  String get errorNegative;

  /// No description provided for @errorWholeNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number'**
  String get errorWholeNumber;

  /// No description provided for @errorAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 1'**
  String get errorAtLeastOne;

  /// No description provided for @errorBelow100.
  ///
  /// In en, this message translates to:
  /// **'Must be below 100%'**
  String get errorBelow100;

  /// No description provided for @errorNotZero.
  ///
  /// In en, this message translates to:
  /// **'Cannot be 0'**
  String get errorNotZero;

  /// No description provided for @errorPositive.
  ///
  /// In en, this message translates to:
  /// **'Must be greater than 0'**
  String get errorPositive;

  /// No description provided for @hintExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. {value}'**
  String hintExample(String value);

  /// No description provided for @resultsHeader.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get resultsHeader;

  /// No description provided for @sharedFrom.
  ///
  /// In en, this message translates to:
  /// **'Calculated with Percentage Calculator'**
  String get sharedFrom;

  /// No description provided for @shareAppText.
  ///
  /// In en, this message translates to:
  /// **'I use Percentage Calculator for quick percentages, tips, discounts and more. Try it: {url}'**
  String shareAppText(String url);

  /// No description provided for @calcPercentageTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculate Percentage'**
  String get calcPercentageTitle;

  /// No description provided for @calcPercentageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find the percentage of any number'**
  String get calcPercentageSubtitle;

  /// No description provided for @fieldPercentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get fieldPercentage;

  /// No description provided for @fieldValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get fieldValue;

  /// No description provided for @fieldAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get fieldAmount;

  /// No description provided for @fieldIncreaseBy.
  ///
  /// In en, this message translates to:
  /// **'Increase by'**
  String get fieldIncreaseBy;

  /// No description provided for @fieldDecreaseBy.
  ///
  /// In en, this message translates to:
  /// **'Decrease by'**
  String get fieldDecreaseBy;

  /// No description provided for @resultResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get resultResult;

  /// No description provided for @resultIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase'**
  String get resultIncrease;

  /// No description provided for @resultDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease'**
  String get resultDecrease;

  /// No description provided for @calcIncreaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Percentage Increase'**
  String get calcIncreaseTitle;

  /// No description provided for @calcIncreaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Increase a number by a percentage'**
  String get calcIncreaseSubtitle;

  /// No description provided for @calcDecreaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Percentage Decrease'**
  String get calcDecreaseTitle;

  /// No description provided for @calcDecreaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Decrease a number by a percentage'**
  String get calcDecreaseSubtitle;

  /// No description provided for @calcTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Tip & Split Bill'**
  String get calcTipTitle;

  /// No description provided for @calcTipSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Work out the tip and split the bill'**
  String get calcTipSubtitle;

  /// No description provided for @fieldBillAmount.
  ///
  /// In en, this message translates to:
  /// **'Bill amount'**
  String get fieldBillAmount;

  /// No description provided for @fieldPeople.
  ///
  /// In en, this message translates to:
  /// **'Number of people'**
  String get fieldPeople;

  /// No description provided for @fieldTipPercent.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get fieldTipPercent;

  /// No description provided for @resultTipAmount.
  ///
  /// In en, this message translates to:
  /// **'Tip amount'**
  String get resultTipAmount;

  /// No description provided for @resultTipPerPerson.
  ///
  /// In en, this message translates to:
  /// **'Tip per person'**
  String get resultTipPerPerson;

  /// No description provided for @resultTotalToPay.
  ///
  /// In en, this message translates to:
  /// **'Total to pay'**
  String get resultTotalToPay;

  /// No description provided for @resultTotalPerPerson.
  ///
  /// In en, this message translates to:
  /// **'Total per person'**
  String get resultTotalPerPerson;

  /// No description provided for @calcMarginTitle.
  ///
  /// In en, this message translates to:
  /// **'Profit Margin'**
  String get calcMarginTitle;

  /// No description provided for @calcMarginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find the selling price for a profit margin'**
  String get calcMarginSubtitle;

  /// No description provided for @fieldCost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get fieldCost;

  /// No description provided for @fieldMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get fieldMargin;

  /// No description provided for @resultPrice.
  ///
  /// In en, this message translates to:
  /// **'Selling price'**
  String get resultPrice;

  /// No description provided for @resultProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get resultProfit;

  /// No description provided for @resultMarkup.
  ///
  /// In en, this message translates to:
  /// **'Markup'**
  String get resultMarkup;

  /// No description provided for @calcChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Percentage Change'**
  String get calcChangeTitle;

  /// No description provided for @calcChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How much a value has gone up or down'**
  String get calcChangeSubtitle;

  /// No description provided for @fieldInitialValue.
  ///
  /// In en, this message translates to:
  /// **'Initial value'**
  String get fieldInitialValue;

  /// No description provided for @fieldFinalValue.
  ///
  /// In en, this message translates to:
  /// **'Final value'**
  String get fieldFinalValue;

  /// No description provided for @resultPercentChange.
  ///
  /// In en, this message translates to:
  /// **'Percentage change'**
  String get resultPercentChange;

  /// No description provided for @resultDifference.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get resultDifference;

  /// No description provided for @calcPercentOfTitle.
  ///
  /// In en, this message translates to:
  /// **'What % of'**
  String get calcPercentOfTitle;

  /// No description provided for @calcPercentOfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What percentage one value is of another'**
  String get calcPercentOfSubtitle;

  /// No description provided for @fieldPart.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get fieldPart;

  /// No description provided for @fieldWhole.
  ///
  /// In en, this message translates to:
  /// **'Is what % of'**
  String get fieldWhole;

  /// No description provided for @calcDiscountTitle.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get calcDiscountTitle;

  /// No description provided for @calcDiscountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sale price and how much you save'**
  String get calcDiscountSubtitle;

  /// No description provided for @fieldOriginalPrice.
  ///
  /// In en, this message translates to:
  /// **'Original price'**
  String get fieldOriginalPrice;

  /// No description provided for @fieldDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get fieldDiscount;

  /// No description provided for @resultFinalPrice.
  ///
  /// In en, this message translates to:
  /// **'Final price'**
  String get resultFinalPrice;

  /// No description provided for @resultYouSave.
  ///
  /// In en, this message translates to:
  /// **'You save'**
  String get resultYouSave;

  /// No description provided for @calcTaxTitle.
  ///
  /// In en, this message translates to:
  /// **'VAT / Sales Tax'**
  String get calcTaxTitle;

  /// No description provided for @calcTaxSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add or remove tax from a price'**
  String get calcTaxSubtitle;

  /// No description provided for @fieldTaxRate.
  ///
  /// In en, this message translates to:
  /// **'Tax rate'**
  String get fieldTaxRate;

  /// No description provided for @resultWithTax.
  ///
  /// In en, this message translates to:
  /// **'Price with tax added'**
  String get resultWithTax;

  /// No description provided for @resultTaxAdded.
  ///
  /// In en, this message translates to:
  /// **'Tax added'**
  String get resultTaxAdded;

  /// No description provided for @resultWithoutTax.
  ///
  /// In en, this message translates to:
  /// **'Price with tax removed'**
  String get resultWithoutTax;

  /// No description provided for @resultTaxIncluded.
  ///
  /// In en, this message translates to:
  /// **'Tax included'**
  String get resultTaxIncluded;

  /// No description provided for @calcGradeTitle.
  ///
  /// In en, this message translates to:
  /// **'Exam Grade'**
  String get calcGradeTitle;

  /// No description provided for @calcGradeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn your marks into a percentage'**
  String get calcGradeSubtitle;

  /// No description provided for @fieldScore.
  ///
  /// In en, this message translates to:
  /// **'Your score'**
  String get fieldScore;

  /// No description provided for @fieldTotalMarks.
  ///
  /// In en, this message translates to:
  /// **'Total marks'**
  String get fieldTotalMarks;

  /// No description provided for @resultPercentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get resultPercentage;

  /// No description provided for @resultMarksLost.
  ///
  /// In en, this message translates to:
  /// **'Marks lost'**
  String get resultMarksLost;

  /// No description provided for @calcLoanTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan & Interest'**
  String get calcLoanTitle;

  /// No description provided for @calcLoanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly payment and total interest'**
  String get calcLoanSubtitle;

  /// No description provided for @fieldLoanAmount.
  ///
  /// In en, this message translates to:
  /// **'Loan amount'**
  String get fieldLoanAmount;

  /// No description provided for @fieldInterestRate.
  ///
  /// In en, this message translates to:
  /// **'Interest rate (per year)'**
  String get fieldInterestRate;

  /// No description provided for @fieldTermYears.
  ///
  /// In en, this message translates to:
  /// **'Term (years)'**
  String get fieldTermYears;

  /// No description provided for @resultMonthlyPayment.
  ///
  /// In en, this message translates to:
  /// **'Monthly payment'**
  String get resultMonthlyPayment;

  /// No description provided for @resultTotalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total payment'**
  String get resultTotalPayment;

  /// No description provided for @resultTotalInterest.
  ///
  /// In en, this message translates to:
  /// **'Total interest'**
  String get resultTotalInterest;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your calculations will appear here.'**
  String get historyEmpty;

  /// No description provided for @historyClear.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get historyClear;

  /// No description provided for @historyClearConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete all saved calculations?'**
  String get historyClearConfirm;

  /// No description provided for @historyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Calculation deleted'**
  String get historyDeleted;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'Effortlessly calculate percentages, tips, discounts, taxes, grades and loans. Simple, fast and free.'**
  String get aboutDescription;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String aboutVersion(String version);

  /// No description provided for @reportBugIntro.
  ///
  /// In en, this message translates to:
  /// **'Found a crash or a bug? Have an idea to make the app better? We\'d love to hear from you — your feedback is priceless.'**
  String get reportBugIntro;

  /// No description provided for @reportBugLabel.
  ///
  /// In en, this message translates to:
  /// **'Describe the problem or your idea'**
  String get reportBugLabel;

  /// No description provided for @reportBugHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. The app crashes when I rotate the screen'**
  String get reportBugHint;

  /// No description provided for @reportBugSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get reportBugSend;

  /// No description provided for @reportBugNoEmail.
  ///
  /// In en, this message translates to:
  /// **'No email app found. Please write to {email}'**
  String reportBugNoEmail(String email);

  /// No description provided for @updateAvailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailableTitle;

  /// No description provided for @updateAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'A new version of Percentage Calculator is available with improvements and fixes.'**
  String get updateAvailableMessage;

  /// No description provided for @updateRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Update required'**
  String get updateRequiredTitle;

  /// No description provided for @updateRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This version is no longer supported. Please update to keep using the app.'**
  String get updateRequiredMessage;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @premiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Go ad-free'**
  String get premiumTitle;

  /// No description provided for @premiumDescription.
  ///
  /// In en, this message translates to:
  /// **'One-time purchase. Removes all ads and unlocks every extra.'**
  String get premiumDescription;

  /// No description provided for @premiumBuy.
  ///
  /// In en, this message translates to:
  /// **'Remove ads – {price}'**
  String premiumBuy(String price);

  /// No description provided for @premiumActive.
  ///
  /// In en, this message translates to:
  /// **'You\'re ad-free. Thank you for your support!'**
  String get premiumActive;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @purchaseUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Purchases aren\'t available right now.'**
  String get purchaseUnavailable;

  /// No description provided for @purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'The purchase didn\'t go through. Please try again.'**
  String get purchaseFailed;

  /// No description provided for @settingsColor.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get settingsColor;

  /// No description provided for @unlockColorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock all colors'**
  String get unlockColorsTitle;

  /// No description provided for @unlockColorsMessage.
  ///
  /// In en, this message translates to:
  /// **'Watch a short video ad to unlock every color for free, or go ad-free to unlock everything.'**
  String get unlockColorsMessage;

  /// No description provided for @exportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export history'**
  String get exportTitle;

  /// No description provided for @exportMessage.
  ///
  /// In en, this message translates to:
  /// **'Watch a short video ad to export your history as a spreadsheet (CSV), or go ad-free to export any time.'**
  String get exportMessage;

  /// No description provided for @watchAd.
  ///
  /// In en, this message translates to:
  /// **'Watch ad'**
  String get watchAd;

  /// No description provided for @adNotReady.
  ///
  /// In en, this message translates to:
  /// **'No ad is available right now. Please try again in a moment.'**
  String get adNotReady;

  /// No description provided for @colorsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'All colors unlocked!'**
  String get colorsUnlocked;

  /// No description provided for @exportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export as CSV'**
  String get exportCsv;

  /// No description provided for @csvDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get csvDate;

  /// No description provided for @csvCalculator.
  ///
  /// In en, this message translates to:
  /// **'Calculator'**
  String get csvCalculator;

  /// No description provided for @csvInputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get csvInputs;

  /// No description provided for @csvResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get csvResults;

  /// No description provided for @widgetEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your last calculation will appear here'**
  String get widgetEmpty;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get featuresTitle;

  /// No description provided for @featCalculators.
  ///
  /// In en, this message translates to:
  /// **'11 calculators'**
  String get featCalculators;

  /// No description provided for @featCalculatorsDesc.
  ///
  /// In en, this message translates to:
  /// **'Percentage, what % of, increase, decrease, change, discount, tip & split bill, VAT, profit margin, exam grade, loan & interest'**
  String get featCalculatorsDesc;

  /// No description provided for @featInstant.
  ///
  /// In en, this message translates to:
  /// **'Instant results'**
  String get featInstant;

  /// No description provided for @featInstantDesc.
  ///
  /// In en, this message translates to:
  /// **'Answers appear as you type. Tap to copy or share.'**
  String get featInstantDesc;

  /// No description provided for @featHistory.
  ///
  /// In en, this message translates to:
  /// **'History & export'**
  String get featHistory;

  /// No description provided for @featHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Every calculation is saved. Reopen it or export it as CSV.'**
  String get featHistoryDesc;

  /// No description provided for @featWidget.
  ///
  /// In en, this message translates to:
  /// **'Widget & shortcuts'**
  String get featWidget;

  /// No description provided for @featWidgetDesc.
  ///
  /// In en, this message translates to:
  /// **'See your last result on the home screen. Long-press the app icon for shortcuts.'**
  String get featWidgetDesc;

  /// No description provided for @featStyle.
  ///
  /// In en, this message translates to:
  /// **'Your style'**
  String get featStyle;

  /// No description provided for @featStyleDesc.
  ///
  /// In en, this message translates to:
  /// **'Light and dark mode with accent colours.'**
  String get featStyleDesc;

  /// No description provided for @featLanguages.
  ///
  /// In en, this message translates to:
  /// **'7 languages'**
  String get featLanguages;

  /// No description provided for @featPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get featPrivate;

  /// No description provided for @featPrivateDesc.
  ///
  /// In en, this message translates to:
  /// **'No account needed. Your numbers stay on your device.'**
  String get featPrivateDesc;

  /// No description provided for @featAdFree.
  ///
  /// In en, this message translates to:
  /// **'Ad-free option'**
  String get featAdFree;

  /// No description provided for @featAdFreeDesc.
  ///
  /// In en, this message translates to:
  /// **'A one-time purchase removes all ads and unlocks every extra.'**
  String get featAdFreeDesc;

  /// No description provided for @aiTitle.
  ///
  /// In en, this message translates to:
  /// **'AI assistant'**
  String get aiTitle;

  /// No description provided for @aiWelcome.
  ///
  /// In en, this message translates to:
  /// **'Ask about your saved calculations, or type a calculation in your own words.'**
  String get aiWelcome;

  /// No description provided for @aiHint.
  ///
  /// In en, this message translates to:
  /// **'Ask or type a calculation…'**
  String get aiHint;

  /// No description provided for @aiSuggestion1.
  ///
  /// In en, this message translates to:
  /// **'How much have I saved with discounts?'**
  String get aiSuggestion1;

  /// No description provided for @aiSuggestion2.
  ///
  /// In en, this message translates to:
  /// **'15% off 2,400 plus 7.5% VAT'**
  String get aiSuggestion2;

  /// No description provided for @aiSuggestion3.
  ///
  /// In en, this message translates to:
  /// **'What\'s the average tip I gave?'**
  String get aiSuggestion3;

  /// No description provided for @aiInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get aiInsightsTitle;

  /// No description provided for @aiInsightsButton.
  ///
  /// In en, this message translates to:
  /// **'Get insights'**
  String get aiInsightsButton;

  /// No description provided for @aiInsightsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Do a few calculations first, then come back for insights.'**
  String get aiInsightsEmpty;

  /// No description provided for @aiThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking…'**
  String get aiThinking;

  /// No description provided for @aiOpenCalculator.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get aiOpenCalculator;

  /// No description provided for @aiStep.
  ///
  /// In en, this message translates to:
  /// **'Step {n}'**
  String aiStep(int n);

  /// No description provided for @aiReport.
  ///
  /// In en, this message translates to:
  /// **'Report answer'**
  String get aiReport;

  /// No description provided for @aiRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} AI questions left today'**
  String aiRemaining(int count);

  /// No description provided for @aiQuotaReached.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used today\'s AI questions.'**
  String get aiQuotaReached;

  /// No description provided for @aiWatchAdMore.
  ///
  /// In en, this message translates to:
  /// **'Watch an ad for 5 more'**
  String get aiWatchAdMore;

  /// No description provided for @aiPremiumMore.
  ///
  /// In en, this message translates to:
  /// **'Go ad-free for 30 a day'**
  String get aiPremiumMore;

  /// No description provided for @aiConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Use the AI assistant?'**
  String get aiConsentTitle;

  /// No description provided for @aiConsentMessage.
  ///
  /// In en, this message translates to:
  /// **'To answer, your question and your saved calculations are sent to an AI service (currently Google Gemini). Nothing is sent until you ask, and no account or name is included. Please don\'t type personal information in your questions.'**
  String get aiConsentMessage;

  /// No description provided for @aiConsentAgree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get aiConsentAgree;

  /// No description provided for @aiDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'AI can make mistakes. Numbers come from the calculator, not the AI.'**
  String get aiDisclaimer;

  /// No description provided for @aiErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get aiErrorGeneric;

  /// No description provided for @aiErrorOffline.
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your internet and try again.'**
  String get aiErrorOffline;

  /// No description provided for @aiErrorBusy.
  ///
  /// In en, this message translates to:
  /// **'The AI assistant is busy. Please try again later.'**
  String get aiErrorBusy;

  /// No description provided for @aiErrorRefused.
  ///
  /// In en, this message translates to:
  /// **'The AI can\'t help with that request.'**
  String get aiErrorRefused;

  /// No description provided for @aiExplain.
  ///
  /// In en, this message translates to:
  /// **'Explain'**
  String get aiExplain;

  /// No description provided for @aiExplainTitle.
  ///
  /// In en, this message translates to:
  /// **'How it\'s calculated'**
  String get aiExplainTitle;

  /// No description provided for @aiInvalidStep.
  ///
  /// In en, this message translates to:
  /// **'This calculation couldn\'t be done with those numbers.'**
  String get aiInvalidStep;

  /// No description provided for @aiBonusAdded.
  ///
  /// In en, this message translates to:
  /// **'5 more questions added!'**
  String get aiBonusAdded;

  /// No description provided for @aiErrorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The AI assistant isn\'t available right now.'**
  String get aiErrorUnavailable;

  /// No description provided for @menuCheckUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get menuCheckUpdates;

  /// No description provided for @updateUpToDate.
  ///
  /// In en, this message translates to:
  /// **'You have the latest version ({version}).'**
  String updateUpToDate(String version);

  /// No description provided for @updateCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t check for updates. Please try again later.'**
  String get updateCheckFailed;

  /// No description provided for @adPassWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch a video: no ads for 24 hours'**
  String get adPassWatch;

  /// No description provided for @adPassActive.
  ///
  /// In en, this message translates to:
  /// **'Ad-free until {time}'**
  String adPassActive(String time);

  /// No description provided for @adPassGranted.
  ///
  /// In en, this message translates to:
  /// **'No ads for the next 24 hours. Enjoy!'**
  String get adPassGranted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'en',
    'es',
    'fr',
    'hi',
    'pt',
    'sw',
  ].contains(locale.languageCode);

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
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'pt':
      return AppLocalizationsPt();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
