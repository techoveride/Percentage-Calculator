// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Calculadora de porcentagem';

  @override
  String get homeTitle => 'Calculadora %';

  @override
  String get menuHistory => 'Histórico';

  @override
  String get menuSettings => 'Configurações';

  @override
  String get menuShareApp => 'Compartilhar app';

  @override
  String get menuRateApp => 'Avaliar app';

  @override
  String get menuReportBug => 'Relatar erro';

  @override
  String get menuPrivacySettings => 'Configurações de privacidade';

  @override
  String get menuPrivacyPolicy => 'Política de privacidade';

  @override
  String get menuAbout => 'Sobre';

  @override
  String get menuExit => 'Sair';

  @override
  String get exitTitle => 'Tem certeza?';

  @override
  String get exitMessage => 'Deseja sair do app?';

  @override
  String get no => 'Não';

  @override
  String get yes => 'Sim';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get share => 'Compartilhar';

  @override
  String get reset => 'Limpar';

  @override
  String get calculate => 'Calcular';

  @override
  String get shareResultTooltip => 'Compartilhar resultado';

  @override
  String copied(String label) {
    return '$label copiado';
  }

  @override
  String get errorRequired => 'Digite um valor';

  @override
  String get errorInvalidNumber => 'Digite um número válido';

  @override
  String get errorNegative => 'Não pode ser negativo';

  @override
  String get errorWholeNumber => 'Digite um número inteiro';

  @override
  String get errorAtLeastOne => 'Deve ser pelo menos 1';

  @override
  String get errorBelow100 => 'Deve ser menor que 100%';

  @override
  String get errorNotZero => 'Não pode ser 0';

  @override
  String get errorPositive => 'Deve ser maior que 0';

  @override
  String hintExample(String value) {
    return 'ex.: $value';
  }

  @override
  String get resultsHeader => 'Resultados';

  @override
  String get sharedFrom => 'Calculado com Calculadora de porcentagem';

  @override
  String shareAppText(String url) {
    return 'Uso a Calculadora de porcentagem para calcular rapidamente porcentagens, gorjetas, descontos e muito mais. Experimente: $url';
  }

  @override
  String get calcPercentageTitle => 'Calcular porcentagem';

  @override
  String get calcPercentageSubtitle =>
      'Descubra a porcentagem de qualquer número';

  @override
  String get fieldPercentage => 'Porcentagem';

  @override
  String get fieldValue => 'Valor';

  @override
  String get fieldAmount => 'Quantia';

  @override
  String get fieldIncreaseBy => 'Aumentar em';

  @override
  String get fieldDecreaseBy => 'Diminuir em';

  @override
  String get resultResult => 'Resultado';

  @override
  String get resultIncrease => 'Aumento';

  @override
  String get resultDecrease => 'Redução';

  @override
  String get calcIncreaseTitle => 'Aumento percentual';

  @override
  String get calcIncreaseSubtitle => 'Aumente um número em uma porcentagem';

  @override
  String get calcDecreaseTitle => 'Redução percentual';

  @override
  String get calcDecreaseSubtitle => 'Diminua um número em uma porcentagem';

  @override
  String get calcTipTitle => 'Gorjeta e divisão da conta';

  @override
  String get calcTipSubtitle => 'Calcule a gorjeta e divida a conta';

  @override
  String get fieldBillAmount => 'Valor da conta';

  @override
  String get fieldPeople => 'Número de pessoas';

  @override
  String get fieldTipPercent => 'Gorjeta';

  @override
  String get resultTipAmount => 'Valor da gorjeta';

  @override
  String get resultTipPerPerson => 'Gorjeta por pessoa';

  @override
  String get resultTotalToPay => 'Total a pagar';

  @override
  String get resultTotalPerPerson => 'Total por pessoa';

  @override
  String get calcMarginTitle => 'Margem de lucro';

  @override
  String get calcMarginSubtitle => 'Encontre o preço de venda para uma margem';

  @override
  String get fieldCost => 'Custo';

  @override
  String get fieldMargin => 'Margem';

  @override
  String get resultPrice => 'Preço de venda';

  @override
  String get resultProfit => 'Lucro';

  @override
  String get resultMarkup => 'Markup';

  @override
  String get calcChangeTitle => 'Variação percentual';

  @override
  String get calcChangeSubtitle => 'Quanto um valor subiu ou caiu';

  @override
  String get fieldInitialValue => 'Valor inicial';

  @override
  String get fieldFinalValue => 'Valor final';

  @override
  String get resultPercentChange => 'Variação percentual';

  @override
  String get resultDifference => 'Diferença';

  @override
  String get calcPercentOfTitle => 'Quantos % de';

  @override
  String get calcPercentOfSubtitle => 'Que porcentagem um valor é de outro';

  @override
  String get fieldPart => 'Valor';

  @override
  String get fieldWhole => 'É quantos % de';

  @override
  String get calcDiscountTitle => 'Desconto';

  @override
  String get calcDiscountSubtitle =>
      'Preço com desconto e quanto você economiza';

  @override
  String get fieldOriginalPrice => 'Preço original';

  @override
  String get fieldDiscount => 'Desconto';

  @override
  String get resultFinalPrice => 'Preço final';

  @override
  String get resultYouSave => 'Você economiza';

  @override
  String get calcTaxTitle => 'Imposto / IVA';

  @override
  String get calcTaxSubtitle => 'Adicione ou remova imposto de um preço';

  @override
  String get fieldTaxRate => 'Alíquota';

  @override
  String get resultWithTax => 'Preço com imposto';

  @override
  String get resultTaxAdded => 'Imposto adicionado';

  @override
  String get resultWithoutTax => 'Preço sem imposto';

  @override
  String get resultTaxIncluded => 'Imposto incluído';

  @override
  String get calcGradeTitle => 'Nota da prova';

  @override
  String get calcGradeSubtitle => 'Converta seus pontos em porcentagem';

  @override
  String get fieldScore => 'Sua nota';

  @override
  String get fieldTotalMarks => 'Nota máxima';

  @override
  String get resultPercentage => 'Porcentagem';

  @override
  String get resultMarksLost => 'Pontos perdidos';

  @override
  String get calcLoanTitle => 'Empréstimo e juros';

  @override
  String get calcLoanSubtitle => 'Parcela mensal e juros totais';

  @override
  String get fieldLoanAmount => 'Valor do empréstimo';

  @override
  String get fieldInterestRate => 'Taxa de juros (ao ano)';

  @override
  String get fieldTermYears => 'Prazo (anos)';

  @override
  String get resultMonthlyPayment => 'Parcela mensal';

  @override
  String get resultTotalPayment => 'Total pago';

  @override
  String get resultTotalInterest => 'Juros totais';

  @override
  String get historyTitle => 'Histórico';

  @override
  String get historyEmpty => 'Seus cálculos aparecerão aqui.';

  @override
  String get historyClear => 'Limpar histórico';

  @override
  String get historyClearConfirm => 'Excluir todos os cálculos salvos?';

  @override
  String get historyDeleted => 'Cálculo excluído';

  @override
  String get undo => 'Desfazer';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get themeSystem => 'Padrão do sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Padrão do sistema';

  @override
  String get aboutDescription =>
      'Calcule facilmente porcentagens, gorjetas, descontos, impostos, notas e empréstimos. Simples, rápido e grátis.';

  @override
  String aboutVersion(String version) {
    return 'Versão $version';
  }

  @override
  String get reportBugIntro =>
      'Encontrou uma falha ou erro? Tem uma ideia para melhorar o app? Adoraríamos saber — sua opinião é valiosa.';

  @override
  String get reportBugLabel => 'Descreva o problema ou sua ideia';

  @override
  String get reportBugHint => 'ex.: O app fecha quando giro a tela';

  @override
  String get reportBugSend => 'Enviar';

  @override
  String reportBugNoEmail(String email) {
    return 'Nenhum app de e-mail encontrado. Escreva para $email';
  }

  @override
  String get updateAvailableTitle => 'Atualização disponível';

  @override
  String get updateAvailableMessage =>
      'Uma nova versão da Calculadora de porcentagem está disponível com melhorias e correções.';

  @override
  String get updateRequiredTitle => 'Atualização necessária';

  @override
  String get updateRequiredMessage =>
      'Esta versão não é mais suportada. Atualize para continuar usando o app.';

  @override
  String get updateNow => 'Atualizar agora';

  @override
  String get later => 'Mais tarde';

  @override
  String get premiumTitle => 'Sem anúncios';

  @override
  String get premiumDescription =>
      'Compra única. Remove todos os anúncios e libera todos os extras.';

  @override
  String premiumBuy(String price) {
    return 'Remover anúncios – $price';
  }

  @override
  String get premiumActive => 'Você está sem anúncios. Obrigado pelo apoio!';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get purchaseUnavailable =>
      'As compras não estão disponíveis no momento.';

  @override
  String get purchaseFailed => 'A compra não foi concluída. Tente novamente.';

  @override
  String get settingsColor => 'Cor';

  @override
  String get unlockColorsTitle => 'Liberar todas as cores';

  @override
  String get unlockColorsMessage =>
      'Assista a um anúncio em vídeo curto para liberar todas as cores grátis, ou remova os anúncios para liberar tudo.';

  @override
  String get exportTitle => 'Exportar histórico';

  @override
  String get exportMessage =>
      'Assista a um anúncio em vídeo curto para exportar seu histórico como planilha (CSV), ou remova os anúncios para exportar quando quiser.';

  @override
  String get watchAd => 'Assistir anúncio';

  @override
  String get adNotReady =>
      'Nenhum anúncio disponível agora. Tente novamente em instantes.';

  @override
  String get colorsUnlocked => 'Todas as cores foram liberadas!';

  @override
  String get exportCsv => 'Exportar como CSV';

  @override
  String get csvDate => 'Data';

  @override
  String get csvCalculator => 'Calculadora';

  @override
  String get csvInputs => 'Valores';

  @override
  String get csvResults => 'Resultados';

  @override
  String get widgetEmpty => 'Seu último cálculo aparecerá aqui';

  @override
  String get featuresTitle => 'Recursos';

  @override
  String get featCalculators => '11 calculadoras';

  @override
  String get featCalculatorsDesc =>
      'Porcentagem, quantos %, aumento, redução, variação, desconto, gorjeta e divisão da conta, imposto, margem de lucro, nota da prova, empréstimo e juros';

  @override
  String get featInstant => 'Resultados instantâneos';

  @override
  String get featInstantDesc =>
      'As respostas aparecem enquanto você digita. Toque para copiar ou compartilhar.';

  @override
  String get featHistory => 'Histórico e exportação';

  @override
  String get featHistoryDesc =>
      'Cada cálculo é salvo. Abra de novo ou exporte em CSV.';

  @override
  String get featWidget => 'Widget e atalhos';

  @override
  String get featWidgetDesc =>
      'Veja seu último resultado na tela inicial. Toque e segure o ícone para ver atalhos.';

  @override
  String get featStyle => 'Seu estilo';

  @override
  String get featStyleDesc => 'Modo claro e escuro com cores à escolha.';

  @override
  String get featLanguages => '7 idiomas';

  @override
  String get featPrivate => 'Privado';

  @override
  String get featPrivateDesc =>
      'Sem conta. Seus números ficam no seu aparelho.';

  @override
  String get featAdFree => 'Opção sem anúncios';

  @override
  String get featAdFreeDesc =>
      'Uma compra única remove os anúncios e libera todos os extras.';

  @override
  String get aiTitle => 'Assistente de IA';

  @override
  String get aiWelcome =>
      'Pergunte sobre seus cálculos salvos ou escreva um cálculo com suas palavras.';

  @override
  String get aiHint => 'Pergunte ou escreva um cálculo…';

  @override
  String get aiSuggestion1 => 'Quanto economizei com descontos?';

  @override
  String get aiSuggestion2 => '15% de desconto em 2.400 mais 7,5% de imposto';

  @override
  String get aiSuggestion3 => 'Qual foi minha gorjeta média?';

  @override
  String get aiInsightsTitle => 'Insights';

  @override
  String get aiInsightsButton => 'Ver insights';

  @override
  String get aiInsightsEmpty =>
      'Faça alguns cálculos primeiro e volte para ver os insights.';

  @override
  String get aiThinking => 'Pensando…';

  @override
  String get aiOpenCalculator => 'Abrir';

  @override
  String aiStep(int n) {
    return 'Passo $n';
  }

  @override
  String get aiReport => 'Denunciar resposta';

  @override
  String aiRemaining(int count) {
    return '$count perguntas de IA restantes hoje';
  }

  @override
  String get aiQuotaReached => 'Você usou as perguntas de IA de hoje.';

  @override
  String get aiWatchAdMore => 'Assista a um anúncio para mais 5';

  @override
  String get aiPremiumMore => 'Sem anúncios: 30 por dia';

  @override
  String get aiConsentTitle => 'Usar o assistente de IA?';

  @override
  String get aiConsentMessage =>
      'Para responder, sua pergunta e seus cálculos salvos são enviados a um serviço de IA (atualmente o Google Gemini). Nada é enviado até você perguntar, e nenhuma conta ou nome é incluído. Não escreva informações pessoais nas perguntas.';

  @override
  String get aiConsentAgree => 'Concordo';

  @override
  String get aiDisclaimer =>
      'A IA pode errar. Os números vêm da calculadora, não da IA.';

  @override
  String get aiErrorGeneric => 'Algo deu errado. Tente novamente.';

  @override
  String get aiErrorOffline =>
      'Sem conexão. Verifique a internet e tente novamente.';

  @override
  String get aiErrorBusy =>
      'O assistente de IA está ocupado. Tente mais tarde.';

  @override
  String get aiErrorRefused => 'A IA não pode ajudar com esse pedido.';

  @override
  String get aiExplain => 'Explicar';

  @override
  String get aiExplainTitle => 'Como é calculado';

  @override
  String get aiInvalidStep =>
      'Este cálculo não pode ser feito com esses números.';

  @override
  String get aiBonusAdded => 'Mais 5 perguntas adicionadas!';

  @override
  String get aiErrorUnavailable =>
      'O assistente de IA não está disponível no momento.';
}
