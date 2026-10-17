// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Calculatrice de pourcentage';

  @override
  String get homeTitle => 'Calculatrice %';

  @override
  String get menuHistory => 'Historique';

  @override
  String get menuSettings => 'Paramètres';

  @override
  String get menuShareApp => 'Partager l\'application';

  @override
  String get menuRateApp => 'Noter l\'application';

  @override
  String get menuReportBug => 'Signaler un bug';

  @override
  String get menuPrivacySettings => 'Paramètres de confidentialité';

  @override
  String get menuPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get menuAbout => 'À propos';

  @override
  String get menuExit => 'Quitter';

  @override
  String get exitTitle => 'Êtes-vous sûr ?';

  @override
  String get exitMessage => 'Voulez-vous quitter l\'application ?';

  @override
  String get no => 'Non';

  @override
  String get yes => 'Oui';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get share => 'Partager';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get calculate => 'Calculer';

  @override
  String get shareResultTooltip => 'Partager le résultat';

  @override
  String copied(String label) {
    return '$label copié';
  }

  @override
  String get errorRequired => 'Saisissez une valeur';

  @override
  String get errorInvalidNumber => 'Saisissez un nombre valide';

  @override
  String get errorNegative => 'Ne doit pas être négatif';

  @override
  String get errorWholeNumber => 'Saisissez un nombre entier';

  @override
  String get errorAtLeastOne => 'Doit être au moins 1';

  @override
  String get errorBelow100 => 'Doit être inférieur à 100 %';

  @override
  String get errorNotZero => 'Ne peut pas être 0';

  @override
  String get errorPositive => 'Doit être supérieur à 0';

  @override
  String hintExample(String value) {
    return 'ex. $value';
  }

  @override
  String get resultsHeader => 'Résultats';

  @override
  String get sharedFrom => 'Calculé avec Calculatrice de pourcentage';

  @override
  String shareAppText(String url) {
    return 'J\'utilise Calculatrice de pourcentage pour calculer rapidement pourcentages, pourboires, remises et plus. Essayez-la : $url';
  }

  @override
  String get calcPercentageTitle => 'Calculer un pourcentage';

  @override
  String get calcPercentageSubtitle =>
      'Trouvez le pourcentage de n\'importe quel nombre';

  @override
  String get fieldPercentage => 'Pourcentage';

  @override
  String get fieldValue => 'Valeur';

  @override
  String get fieldAmount => 'Montant';

  @override
  String get fieldIncreaseBy => 'Augmenter de';

  @override
  String get fieldDecreaseBy => 'Diminuer de';

  @override
  String get resultResult => 'Résultat';

  @override
  String get resultIncrease => 'Augmentation';

  @override
  String get resultDecrease => 'Diminution';

  @override
  String get calcIncreaseTitle => 'Augmentation en %';

  @override
  String get calcIncreaseSubtitle => 'Augmentez un nombre d\'un pourcentage';

  @override
  String get calcDecreaseTitle => 'Diminution en %';

  @override
  String get calcDecreaseSubtitle => 'Diminuez un nombre d\'un pourcentage';

  @override
  String get calcTipTitle => 'Pourboire et partage';

  @override
  String get calcTipSubtitle => 'Calculez le pourboire et partagez l\'addition';

  @override
  String get fieldBillAmount => 'Montant de l\'addition';

  @override
  String get fieldPeople => 'Nombre de personnes';

  @override
  String get fieldTipPercent => 'Pourboire';

  @override
  String get resultTipAmount => 'Montant du pourboire';

  @override
  String get resultTipPerPerson => 'Pourboire par personne';

  @override
  String get resultTotalToPay => 'Total à payer';

  @override
  String get resultTotalPerPerson => 'Total par personne';

  @override
  String get calcMarginTitle => 'Marge bénéficiaire';

  @override
  String get calcMarginSubtitle => 'Trouvez le prix de vente pour une marge';

  @override
  String get fieldCost => 'Coût';

  @override
  String get fieldMargin => 'Marge';

  @override
  String get resultPrice => 'Prix de vente';

  @override
  String get resultProfit => 'Bénéfice';

  @override
  String get resultMarkup => 'Majoration';

  @override
  String get calcChangeTitle => 'Variation en %';

  @override
  String get calcChangeSubtitle =>
      'De combien une valeur a augmenté ou diminué';

  @override
  String get fieldInitialValue => 'Valeur initiale';

  @override
  String get fieldFinalValue => 'Valeur finale';

  @override
  String get resultPercentChange => 'Variation en pourcentage';

  @override
  String get resultDifference => 'Différence';

  @override
  String get calcPercentOfTitle => 'Quel % de';

  @override
  String get calcPercentOfSubtitle =>
      'Quel pourcentage une valeur représente d\'une autre';

  @override
  String get fieldPart => 'Valeur';

  @override
  String get fieldWhole => 'Représente quel % de';

  @override
  String get calcDiscountTitle => 'Remise';

  @override
  String get calcDiscountSubtitle => 'Prix soldé et économies réalisées';

  @override
  String get fieldOriginalPrice => 'Prix initial';

  @override
  String get fieldDiscount => 'Remise';

  @override
  String get resultFinalPrice => 'Prix final';

  @override
  String get resultYouSave => 'Vous économisez';

  @override
  String get calcTaxTitle => 'TVA / Taxe';

  @override
  String get calcTaxSubtitle => 'Ajoutez ou retirez la taxe d\'un prix';

  @override
  String get fieldTaxRate => 'Taux de taxe';

  @override
  String get resultWithTax => 'Prix TTC (taxe ajoutée)';

  @override
  String get resultTaxAdded => 'Taxe ajoutée';

  @override
  String get resultWithoutTax => 'Prix HT (taxe retirée)';

  @override
  String get resultTaxIncluded => 'Taxe incluse';

  @override
  String get calcGradeTitle => 'Note d\'examen';

  @override
  String get calcGradeSubtitle => 'Convertissez vos points en pourcentage';

  @override
  String get fieldScore => 'Votre note';

  @override
  String get fieldTotalMarks => 'Note maximale';

  @override
  String get resultPercentage => 'Pourcentage';

  @override
  String get resultMarksLost => 'Points perdus';

  @override
  String get calcLoanTitle => 'Prêt et intérêts';

  @override
  String get calcLoanSubtitle => 'Mensualité et coût total des intérêts';

  @override
  String get fieldLoanAmount => 'Montant du prêt';

  @override
  String get fieldInterestRate => 'Taux d\'intérêt (annuel)';

  @override
  String get fieldTermYears => 'Durée (années)';

  @override
  String get resultMonthlyPayment => 'Mensualité';

  @override
  String get resultTotalPayment => 'Montant total remboursé';

  @override
  String get resultTotalInterest => 'Total des intérêts';

  @override
  String get historyTitle => 'Historique';

  @override
  String get historyEmpty => 'Vos calculs apparaîtront ici.';

  @override
  String get historyClear => 'Effacer l\'historique';

  @override
  String get historyClearConfirm => 'Supprimer tous les calculs enregistrés ?';

  @override
  String get historyDeleted => 'Calcul supprimé';

  @override
  String get undo => 'Annuler';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get themeSystem => 'Par défaut du système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get languageSystem => 'Par défaut du système';

  @override
  String get aboutDescription =>
      'Calculez facilement pourcentages, pourboires, remises, taxes, notes et prêts. Simple, rapide et gratuit.';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get reportBugIntro =>
      'Vous avez trouvé un plantage ou un bug ? Une idée pour améliorer l\'application ? Écrivez-nous — votre avis est précieux.';

  @override
  String get reportBugLabel => 'Décrivez le problème ou votre idée';

  @override
  String get reportBugHint =>
      'ex. L\'application plante quand je tourne l\'écran';

  @override
  String get reportBugSend => 'Envoyer';

  @override
  String reportBugNoEmail(String email) {
    return 'Aucune application e-mail trouvée. Écrivez-nous à $email';
  }

  @override
  String get updateAvailableTitle => 'Mise à jour disponible';

  @override
  String get updateAvailableMessage =>
      'Une nouvelle version de Calculatrice de pourcentage est disponible, avec des améliorations et des corrections.';

  @override
  String get updateRequiredTitle => 'Mise à jour requise';

  @override
  String get updateRequiredMessage =>
      'Cette version n\'est plus prise en charge. Veuillez mettre à jour pour continuer à utiliser l\'application.';

  @override
  String get updateNow => 'Mettre à jour';

  @override
  String get later => 'Plus tard';

  @override
  String get premiumTitle => 'Sans publicité';

  @override
  String get premiumDescription =>
      'Achat unique. Supprime toutes les publicités et débloque tous les extras.';

  @override
  String premiumBuy(String price) {
    return 'Supprimer les pubs – $price';
  }

  @override
  String get premiumActive =>
      'Vous êtes sans publicité. Merci pour votre soutien !';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get purchaseUnavailable =>
      'Les achats ne sont pas disponibles pour le moment.';

  @override
  String get purchaseFailed => 'L\'achat n\'a pas abouti. Veuillez réessayer.';

  @override
  String get settingsColor => 'Couleur';

  @override
  String get unlockColorsTitle => 'Débloquer toutes les couleurs';

  @override
  String get unlockColorsMessage =>
      'Regardez une courte vidéo publicitaire pour débloquer gratuitement toutes les couleurs, ou passez sans publicité pour tout débloquer.';

  @override
  String get exportTitle => 'Exporter l\'historique';

  @override
  String get exportMessage =>
      'Regardez une courte vidéo publicitaire pour exporter votre historique en tableur (CSV), ou passez sans publicité pour exporter à tout moment.';

  @override
  String get watchAd => 'Regarder la pub';

  @override
  String get adNotReady =>
      'Aucune publicité disponible pour le moment. Réessayez dans un instant.';

  @override
  String get colorsUnlocked => 'Toutes les couleurs sont débloquées !';

  @override
  String get exportCsv => 'Exporter en CSV';

  @override
  String get csvDate => 'Date';

  @override
  String get csvCalculator => 'Calculatrice';

  @override
  String get csvInputs => 'Valeurs saisies';

  @override
  String get csvResults => 'Résultats';

  @override
  String get widgetEmpty => 'Votre dernier calcul apparaîtra ici';

  @override
  String get featuresTitle => 'Fonctionnalités';

  @override
  String get featCalculators => '11 calculatrices';

  @override
  String get featCalculatorsDesc =>
      'Pourcentage, quel %, augmentation, diminution, variation, remise, pourboire et partage, TVA, marge, note d\'examen, prêt et intérêts';

  @override
  String get featInstant => 'Résultats instantanés';

  @override
  String get featInstantDesc =>
      'Les réponses s\'affichent pendant la saisie. Touchez pour copier ou partager.';

  @override
  String get featHistory => 'Historique et export';

  @override
  String get featHistoryDesc =>
      'Chaque calcul est enregistré. Rouvrez-le ou exportez-le en CSV.';

  @override
  String get featWidget => 'Widget et raccourcis';

  @override
  String get featWidgetDesc =>
      'Votre dernier résultat sur l\'écran d\'accueil. Appui long sur l\'icône pour les raccourcis.';

  @override
  String get featStyle => 'Votre style';

  @override
  String get featStyleDesc => 'Mode clair et sombre avec couleurs au choix.';

  @override
  String get featLanguages => '7 langues';

  @override
  String get featPrivate => 'Confidentiel';

  @override
  String get featPrivateDesc =>
      'Aucun compte requis. Vos chiffres restent sur votre appareil.';

  @override
  String get featAdFree => 'Option sans publicité';

  @override
  String get featAdFreeDesc =>
      'Un achat unique supprime les publicités et débloque tous les extras.';

  @override
  String get aiTitle => 'Assistant IA';

  @override
  String get aiWelcome =>
      'Posez une question sur vos calculs enregistrés ou décrivez un calcul avec vos propres mots.';

  @override
  String get aiHint => 'Posez une question ou décrivez un calcul…';

  @override
  String get aiSuggestion1 => 'Combien ai-je économisé avec les remises ?';

  @override
  String get aiSuggestion2 => '15 % de remise sur 2 400 plus 7,5 % de TVA';

  @override
  String get aiSuggestion3 => 'Quel est mon pourboire moyen ?';

  @override
  String get aiInsightsTitle => 'Aperçus';

  @override
  String get aiInsightsButton => 'Voir les aperçus';

  @override
  String get aiInsightsEmpty =>
      'Faites d\'abord quelques calculs, puis revenez pour les aperçus.';

  @override
  String get aiThinking => 'Réflexion…';

  @override
  String get aiOpenCalculator => 'Ouvrir';

  @override
  String aiStep(int n) {
    return 'Étape $n';
  }

  @override
  String get aiReport => 'Signaler la réponse';

  @override
  String aiRemaining(int count) {
    return 'Encore $count questions IA aujourd\'hui';
  }

  @override
  String get aiQuotaReached => 'Vous avez utilisé vos questions IA du jour.';

  @override
  String get aiWatchAdMore => 'Regarder une pub pour 5 de plus';

  @override
  String get aiPremiumMore => 'Sans pub : 30 par jour';

  @override
  String get aiConsentTitle => 'Utiliser l\'assistant IA ?';

  @override
  String get aiConsentMessage =>
      'Pour répondre, votre question et vos calculs enregistrés sont envoyés à un service d\'IA (actuellement Google Gemini). Rien n\'est envoyé tant que vous ne posez pas de question, et aucun compte ni nom n\'est inclus. N\'écrivez pas d\'informations personnelles dans vos questions.';

  @override
  String get aiConsentAgree => 'Accepter';

  @override
  String get aiDisclaimer =>
      'L\'IA peut se tromper. Les chiffres viennent de la calculatrice, pas de l\'IA.';

  @override
  String get aiErrorGeneric =>
      'Une erreur s\'est produite. Veuillez réessayer.';

  @override
  String get aiErrorOffline =>
      'Pas de connexion. Vérifiez Internet et réessayez.';

  @override
  String get aiErrorBusy => 'L\'assistant IA est occupé. Réessayez plus tard.';

  @override
  String get aiErrorRefused => 'L\'IA ne peut pas répondre à cette demande.';

  @override
  String get aiExplain => 'Expliquer';

  @override
  String get aiExplainTitle => 'Comment c\'est calculé';

  @override
  String get aiInvalidStep => 'Ce calcul est impossible avec ces nombres.';

  @override
  String get aiBonusAdded => '5 questions de plus ajoutées !';

  @override
  String get aiErrorUnavailable =>
      'L\'assistant IA n\'est pas disponible pour le moment.';
}
