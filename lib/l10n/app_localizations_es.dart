// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Calculadora de porcentajes';

  @override
  String get homeTitle => 'Calculadora %';

  @override
  String get menuHistory => 'Historial';

  @override
  String get menuSettings => 'Ajustes';

  @override
  String get menuShareApp => 'Compartir app';

  @override
  String get menuRateApp => 'Valorar app';

  @override
  String get menuReportBug => 'Informar de un error';

  @override
  String get menuPrivacySettings => 'Ajustes de privacidad';

  @override
  String get menuPrivacyPolicy => 'Política de privacidad';

  @override
  String get menuAbout => 'Acerca de';

  @override
  String get menuExit => 'Salir';

  @override
  String get exitTitle => '¿Estás seguro?';

  @override
  String get exitMessage => '¿Quieres salir de la app?';

  @override
  String get no => 'No';

  @override
  String get yes => 'Sí';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get share => 'Compartir';

  @override
  String get reset => 'Restablecer';

  @override
  String get calculate => 'Calcular';

  @override
  String get shareResultTooltip => 'Compartir resultado';

  @override
  String copied(String label) {
    return '$label copiado';
  }

  @override
  String get errorRequired => 'Introduce un valor';

  @override
  String get errorInvalidNumber => 'Introduce un número válido';

  @override
  String get errorNegative => 'No puede ser negativo';

  @override
  String get errorWholeNumber => 'Introduce un número entero';

  @override
  String get errorAtLeastOne => 'Debe ser al menos 1';

  @override
  String get errorBelow100 => 'Debe ser menor que 100 %';

  @override
  String get errorNotZero => 'No puede ser 0';

  @override
  String get errorPositive => 'Debe ser mayor que 0';

  @override
  String hintExample(String value) {
    return 'p. ej. $value';
  }

  @override
  String get resultsHeader => 'Resultados';

  @override
  String get sharedFrom => 'Calculado con Calculadora de porcentajes';

  @override
  String shareAppText(String url) {
    return 'Uso Calculadora de porcentajes para calcular rápido porcentajes, propinas, descuentos y más. Pruébala: $url';
  }

  @override
  String get calcPercentageTitle => 'Calcular porcentaje';

  @override
  String get calcPercentageSubtitle =>
      'Halla el porcentaje de cualquier número';

  @override
  String get fieldPercentage => 'Porcentaje';

  @override
  String get fieldValue => 'Valor';

  @override
  String get fieldAmount => 'Cantidad';

  @override
  String get fieldIncreaseBy => 'Aumentar en';

  @override
  String get fieldDecreaseBy => 'Reducir en';

  @override
  String get resultResult => 'Resultado';

  @override
  String get resultIncrease => 'Aumento';

  @override
  String get resultDecrease => 'Reducción';

  @override
  String get calcIncreaseTitle => 'Aumento porcentual';

  @override
  String get calcIncreaseSubtitle => 'Aumenta un número en un porcentaje';

  @override
  String get calcDecreaseTitle => 'Reducción porcentual';

  @override
  String get calcDecreaseSubtitle => 'Reduce un número en un porcentaje';

  @override
  String get calcTipTitle => 'Propina y dividir cuenta';

  @override
  String get calcTipSubtitle => 'Calcula la propina y divide la cuenta';

  @override
  String get fieldBillAmount => 'Importe de la cuenta';

  @override
  String get fieldPeople => 'Número de personas';

  @override
  String get fieldTipPercent => 'Propina';

  @override
  String get resultTipAmount => 'Importe de la propina';

  @override
  String get resultTipPerPerson => 'Propina por persona';

  @override
  String get resultTotalToPay => 'Total a pagar';

  @override
  String get resultTotalPerPerson => 'Total por persona';

  @override
  String get calcMarginTitle => 'Margen de beneficio';

  @override
  String get calcMarginSubtitle => 'Halla el precio de venta para un margen';

  @override
  String get fieldCost => 'Coste';

  @override
  String get fieldMargin => 'Margen';

  @override
  String get resultPrice => 'Precio de venta';

  @override
  String get resultProfit => 'Beneficio';

  @override
  String get resultMarkup => 'Recargo sobre coste';

  @override
  String get calcChangeTitle => 'Variación porcentual';

  @override
  String get calcChangeSubtitle => 'Cuánto ha subido o bajado un valor';

  @override
  String get fieldInitialValue => 'Valor inicial';

  @override
  String get fieldFinalValue => 'Valor final';

  @override
  String get resultPercentChange => 'Variación porcentual';

  @override
  String get resultDifference => 'Diferencia';

  @override
  String get calcPercentOfTitle => 'Qué % es';

  @override
  String get calcPercentOfSubtitle => 'Qué porcentaje es un valor de otro';

  @override
  String get fieldPart => 'Valor';

  @override
  String get fieldWhole => 'Es qué % de';

  @override
  String get calcDiscountTitle => 'Descuento';

  @override
  String get calcDiscountSubtitle => 'Precio rebajado y cuánto ahorras';

  @override
  String get fieldOriginalPrice => 'Precio original';

  @override
  String get fieldDiscount => 'Descuento';

  @override
  String get resultFinalPrice => 'Precio final';

  @override
  String get resultYouSave => 'Ahorras';

  @override
  String get calcTaxTitle => 'IVA / Impuestos';

  @override
  String get calcTaxSubtitle => 'Añade o quita impuestos a un precio';

  @override
  String get fieldTaxRate => 'Tipo impositivo';

  @override
  String get resultWithTax => 'Precio con impuesto';

  @override
  String get resultTaxAdded => 'Impuesto añadido';

  @override
  String get resultWithoutTax => 'Precio sin impuesto';

  @override
  String get resultTaxIncluded => 'Impuesto incluido';

  @override
  String get calcGradeTitle => 'Nota de examen';

  @override
  String get calcGradeSubtitle => 'Convierte tus puntos en porcentaje';

  @override
  String get fieldScore => 'Tu puntuación';

  @override
  String get fieldTotalMarks => 'Puntuación máxima';

  @override
  String get resultPercentage => 'Porcentaje';

  @override
  String get resultMarksLost => 'Puntos perdidos';

  @override
  String get calcLoanTitle => 'Préstamo e intereses';

  @override
  String get calcLoanSubtitle => 'Cuota mensual e intereses totales';

  @override
  String get fieldLoanAmount => 'Importe del préstamo';

  @override
  String get fieldInterestRate => 'Tipo de interés (anual)';

  @override
  String get fieldTermYears => 'Plazo (años)';

  @override
  String get resultMonthlyPayment => 'Cuota mensual';

  @override
  String get resultTotalPayment => 'Total pagado';

  @override
  String get resultTotalInterest => 'Intereses totales';

  @override
  String get historyTitle => 'Historial';

  @override
  String get historyEmpty => 'Tus cálculos aparecerán aquí.';

  @override
  String get historyClear => 'Borrar historial';

  @override
  String get historyClearConfirm => '¿Eliminar todos los cálculos guardados?';

  @override
  String get historyDeleted => 'Cálculo eliminado';

  @override
  String get undo => 'Deshacer';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get themeSystem => 'Predeterminado del sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get languageSystem => 'Predeterminado del sistema';

  @override
  String get aboutDescription =>
      'Calcula fácilmente porcentajes, propinas, descuentos, impuestos, notas y préstamos. Sencilla, rápida y gratuita.';

  @override
  String aboutVersion(String version) {
    return 'Versión $version';
  }

  @override
  String get reportBugIntro =>
      '¿Has encontrado un cierre inesperado o un error? ¿Tienes una idea para mejorar la app? Nos encantaría saberlo: tu opinión no tiene precio.';

  @override
  String get reportBugLabel => 'Describe el problema o tu idea';

  @override
  String get reportBugHint => 'p. ej. La app se cierra al girar la pantalla';

  @override
  String get reportBugSend => 'Enviar';

  @override
  String reportBugNoEmail(String email) {
    return 'No se encontró ninguna app de correo. Escríbenos a $email';
  }

  @override
  String get updateAvailableTitle => 'Actualización disponible';

  @override
  String get updateAvailableMessage =>
      'Hay una nueva versión de Calculadora de porcentajes con mejoras y correcciones.';

  @override
  String get updateRequiredTitle => 'Actualización necesaria';

  @override
  String get updateRequiredMessage =>
      'Esta versión ya no es compatible. Actualiza para seguir usando la app.';

  @override
  String get updateNow => 'Actualizar';

  @override
  String get later => 'Más tarde';

  @override
  String get premiumTitle => 'Sin anuncios';

  @override
  String get premiumDescription =>
      'Pago único. Elimina todos los anuncios y desbloquea todos los extras.';

  @override
  String premiumBuy(String price) {
    return 'Quitar anuncios – $price';
  }

  @override
  String get premiumActive => 'Ya no tienes anuncios. ¡Gracias por tu apoyo!';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get purchaseUnavailable =>
      'Las compras no están disponibles en este momento.';

  @override
  String get purchaseFailed => 'La compra no se completó. Inténtalo de nuevo.';

  @override
  String get settingsColor => 'Color';

  @override
  String get unlockColorsTitle => 'Desbloquear todos los colores';

  @override
  String get unlockColorsMessage =>
      'Mira un breve anuncio en vídeo para desbloquear todos los colores gratis, o quita los anuncios para desbloquearlo todo.';

  @override
  String get exportTitle => 'Exportar historial';

  @override
  String get exportMessage =>
      'Mira un breve anuncio en vídeo para exportar tu historial como hoja de cálculo (CSV), o quita los anuncios para exportar cuando quieras.';

  @override
  String get watchAd => 'Ver anuncio';

  @override
  String get adNotReady =>
      'No hay anuncios disponibles ahora. Inténtalo de nuevo en un momento.';

  @override
  String get colorsUnlocked => '¡Todos los colores desbloqueados!';

  @override
  String get exportCsv => 'Exportar como CSV';

  @override
  String get csvDate => 'Fecha';

  @override
  String get csvCalculator => 'Calculadora';

  @override
  String get csvInputs => 'Valores';

  @override
  String get csvResults => 'Resultados';

  @override
  String get widgetEmpty => 'Tu último cálculo aparecerá aquí';

  @override
  String get featuresTitle => 'Funciones';

  @override
  String get featCalculators => '11 calculadoras';

  @override
  String get featCalculatorsDesc =>
      'Porcentaje, qué %, aumento, reducción, variación, descuento, propina y dividir cuenta, IVA, margen, nota de examen, préstamo e intereses';

  @override
  String get featInstant => 'Resultados al instante';

  @override
  String get featInstantDesc =>
      'Las respuestas aparecen mientras escribes. Toca para copiar o compartir.';

  @override
  String get featHistory => 'Historial y exportación';

  @override
  String get featHistoryDesc =>
      'Cada cálculo se guarda. Vuelve a abrirlo o expórtalo a CSV.';

  @override
  String get featWidget => 'Widget y accesos directos';

  @override
  String get featWidgetDesc =>
      'Tu último resultado en la pantalla de inicio. Mantén pulsado el icono para ver accesos directos.';

  @override
  String get featStyle => 'Tu estilo';

  @override
  String get featStyleDesc => 'Modo claro y oscuro con colores a elegir.';

  @override
  String get featLanguages => '7 idiomas';

  @override
  String get featPrivate => 'Privada';

  @override
  String get featPrivateDesc =>
      'Sin cuenta. Tus números se quedan en tu dispositivo.';

  @override
  String get featAdFree => 'Opción sin anuncios';

  @override
  String get featAdFreeDesc =>
      'Un pago único quita los anuncios y desbloquea todos los extras.';

  @override
  String get aiTitle => 'Asistente de IA';

  @override
  String get aiWelcome =>
      'Pregunta sobre tus cálculos guardados o escribe un cálculo con tus propias palabras.';

  @override
  String get aiHint => 'Pregunta o escribe un cálculo…';

  @override
  String get aiSuggestion1 => '¿Cuánto he ahorrado con descuentos?';

  @override
  String get aiSuggestion2 => '15 % de descuento sobre 2.400 más 7,5 % de IVA';

  @override
  String get aiSuggestion3 => '¿Cuál es la propina media que he dado?';

  @override
  String get aiInsightsTitle => 'Resumen';

  @override
  String get aiInsightsButton => 'Ver resumen';

  @override
  String get aiInsightsEmpty =>
      'Haz primero algunos cálculos y vuelve para ver el resumen.';

  @override
  String get aiThinking => 'Pensando…';

  @override
  String get aiOpenCalculator => 'Abrir';

  @override
  String aiStep(int n) {
    return 'Paso $n';
  }

  @override
  String get aiReport => 'Denunciar respuesta';

  @override
  String aiRemaining(int count) {
    return 'Te quedan $count preguntas de IA hoy';
  }

  @override
  String get aiQuotaReached => 'Has usado las preguntas de IA de hoy.';

  @override
  String get aiWatchAdMore => 'Ver un anuncio para 5 más';

  @override
  String get aiPremiumMore => 'Sin anuncios: 30 al día';

  @override
  String get aiConsentTitle => '¿Usar el asistente de IA?';

  @override
  String get aiConsentMessage =>
      'Para responder, tu pregunta y tus cálculos guardados se envían a un servicio de IA (actualmente Google Gemini). No se envía nada hasta que preguntas y no se incluye ninguna cuenta ni nombre. No escribas datos personales en tus preguntas.';

  @override
  String get aiConsentAgree => 'Aceptar';

  @override
  String get aiDisclaimer =>
      'La IA puede equivocarse. Los números los calcula la calculadora, no la IA.';

  @override
  String get aiErrorGeneric => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get aiErrorOffline =>
      'Sin conexión. Revisa Internet e inténtalo de nuevo.';

  @override
  String get aiErrorBusy =>
      'El asistente de IA está ocupado. Inténtalo más tarde.';

  @override
  String get aiErrorRefused => 'La IA no puede ayudar con esa solicitud.';

  @override
  String get aiExplain => 'Explicar';

  @override
  String get aiExplainTitle => 'Cómo se calcula';

  @override
  String get aiInvalidStep =>
      'Este cálculo no se puede hacer con esos números.';

  @override
  String get aiBonusAdded => '¡5 preguntas más añadidas!';

  @override
  String get aiErrorUnavailable =>
      'El asistente de IA no está disponible en este momento.';

  @override
  String get menuCheckUpdates => 'Buscar actualizaciones';

  @override
  String updateUpToDate(String version) {
    return 'Tienes la última versión ($version).';
  }

  @override
  String get updateCheckFailed =>
      'No se pudo buscar actualizaciones. Inténtalo más tarde.';

  @override
  String get adPassWatch => 'Ver un vídeo: 24 horas sin anuncios';

  @override
  String adPassActive(String time) {
    return 'Sin anuncios hasta $time';
  }

  @override
  String get adPassGranted => 'Sin anuncios durante 24 horas. ¡Disfruta!';
}
