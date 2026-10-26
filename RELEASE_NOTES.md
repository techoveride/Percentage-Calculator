# Release notes — Percentage Calculator

Package `com.techoveride.percentagecalculator` · Google Play

| Version | Build | Highlights |
|---|---|---|
| [1.0.6](#106--build-7) | 7 | Padded app icon, themed (Android 13+) icon |
| [1.0.5](#105--build-6) | 6 | 24-hour ad-free pass, Go ad-free and Check for updates in the menu, small-screen fixes |
| [1.0.4](#104--build-5) | 5 | AI assistant (Ask, Smart input, Explain, Insights), Features section |
| [1.0.3](#103--build-4) | 4 | Calculator names on the home screen no longer cut off |
| [1.0.2](#102--build-3) | 3 | New launch (splash) screen for light and dark mode |
| [1.0.1](#101--build-2) | 2 | New support email |
| [1.0.0](#100--build-1) | 1 | First release |

Each version below has the text to paste into Play Console → *Release notes*
(every language is under Play's 500-character limit). Play keeps only the
languages that have a store listing.

---

## 1.0.6 — build 7

- New launcher icon: the logo sits inside the launcher's circle/squircle with
  white padding instead of being cropped (adaptive foreground at 40% of the
  layer, inset 0). Android 7 and iOS get a padded white tile.
- Android 13+ themed icons: monochrome % layer the system tints.

```
<en-US>
What's new
• Refreshed app icon that fits neatly on your home screen
• Supports themed icons on Android 13 and newer
• Small fixes and improvements
</en-US>
<fr-FR>
Nouveautés
• Icône de l'application repensée, mieux adaptée à votre écran d'accueil
• Prise en charge des icônes à thème sur Android 13 et versions ultérieures
• Petites corrections et améliorations
</fr-FR>
<sw>
Mapya
• Aikoni mpya ya programu inayokaa vizuri kwenye skrini yako ya mwanzo
• Inatumia aikoni zenye mandhari kwenye Android 13 na matoleo mapya
• Marekebisho madogo na maboresho
</sw>
<hi-IN>
नया क्या है
• नया ऐप आइकन जो आपकी होम स्क्रीन पर अच्छी तरह फ़िट होता है
• Android 13 और नए वर्ज़न पर थीम वाले आइकन का समर्थन
• छोटे सुधार और बेहतरियाँ
</hi-IN>
<es-ES>
Novedades
• Icono de la aplicación renovado que encaja mejor en tu pantalla de inicio
• Compatible con iconos temáticos en Android 13 y versiones posteriores
• Pequeñas correcciones y mejoras
</es-ES>
<pt-BR>
Novidades
• Ícone do app renovado que se encaixa melhor na sua tela inicial
• Suporte a ícones com tema no Android 13 e versões mais recentes
• Pequenas correções e melhorias
</pt-BR>
<ar>
الجديد
• أيقونة تطبيق جديدة تتناسب بشكل أنيق مع شاشتك الرئيسية
• دعم الأيقونات ذات السمات على Android 13 والإصدارات الأحدث
• إصلاحات وتحسينات صغيرة
</ar>
```

## 1.0.5 — build 6

- **24-hour ad-free pass:** watch one rewarded video to hide banners and app
  open ads for 24 hours (survives restarts; ads return when it ends).
- Menu: **Go ad-free** (pass or one-time purchase) and **Check for updates**
  (asks Google Play and Remote Config, says if you're up to date).
- Small phones / larger text: Settings purchase buttons wrap instead of being
  cut off; theme choice is a list; home cards and menu header grow with text.

```
<en-US>
What's new
• Watch a short video to enjoy 24 hours without ads
• New "Go ad-free" and "Check for updates" options in the menu
• Better layout on smaller phones and with larger text sizes
• Small fixes and improvements
</en-US>
<fr-FR>
Nouveautés
• Regardez une courte vidéo pour profiter de 24 heures sans publicité
• Nouvelles options « Sans publicité » et « Rechercher des mises à jour » dans le menu
• Meilleur affichage sur les petits téléphones et avec une grande taille de texte
• Petites corrections et améliorations
</fr-FR>
<sw>
Mapya
• Tazama video fupi ufurahie saa 24 bila matangazo
• Chaguo mpya za "Bila matangazo" na "Angalia masasisho" kwenye menyu
• Mpangilio bora kwenye simu ndogo na kwa maandishi makubwa
• Marekebisho madogo na maboresho
</sw>
<hi-IN>
नया क्या है
• एक छोटा वीडियो देखें और 24 घंटे विज्ञापन-मुक्त रहें
• मेनू में नए "विज्ञापन-मुक्त बनें" और "अपडेट जाँचें" विकल्प
• छोटे फ़ोन और बड़े टेक्स्ट आकार पर बेहतर लेआउट
• छोटे सुधार और बेहतरियाँ
</hi-IN>
<es-ES>
Novedades
• Mira un vídeo corto y disfruta de 24 horas sin anuncios
• Nuevas opciones «Sin anuncios» y «Buscar actualizaciones» en el menú
• Mejor diseño en teléfonos pequeños y con texto grande
• Pequeñas correcciones y mejoras
</es-ES>
<pt-BR>
Novidades
• Assista a um vídeo curto e aproveite 24 horas sem anúncios
• Novas opções "Sem anúncios" e "Verificar atualizações" no menu
• Layout melhor em celulares menores e com texto grande
• Pequenas correções e melhorias
</pt-BR>
<ar>
الجديد
• شاهد فيديو قصيرًا واستمتع بـ24 ساعة بدون إعلانات
• خيارا "بدون إعلانات" و"البحث عن تحديثات" الجديدان في القائمة
• تصميم أفضل على الهواتف الصغيرة ومع الخط الكبير
• إصلاحات وتحسينات صغيرة
</ar>
```

## 1.0.4 — build 5

- **AI assistant** (free, powered by Google Gemini through Firebase AI Logic):
  - Ask about your saved calculations ("How much have I saved with discounts?").
  - Smart input: type a calculation in words ("15% off 2,400 plus 7.5% VAT"); the
    app's own calculators work out the exact numbers, step by step.
  - **Explain** button on every result: the formula with your numbers.
  - **Insights** card summarising your history.
  - 3 questions a day free, +5 per rewarded ad (twice a day), 30 a day ad-free.
  - Consent prompt, report button on every answer, switchable from Remote Config.
- **Features** section in About.

```
<en-US>
What's new
• New AI assistant: ask about your saved calculations or type a calculation in your own words, like "15% off 2,400 plus 7.5% VAT"
• Insights: a quick summary of your spending, savings and habits
• Explain: see step by step how any result is calculated
• Features overview in the About screen
• 3 free AI questions a day (30 with ad-free)
</en-US>
<fr-FR>
Nouveautés
• Nouvel assistant IA : posez une question sur vos calculs enregistrés ou décrivez un calcul avec vos mots, par ex. « 15 % de remise sur 2 400 plus 7,5 % de TVA »
• Aperçus : un résumé rapide de vos dépenses, économies et habitudes
• Expliquer : voyez étape par étape comment chaque résultat est calculé
• Présentation des fonctionnalités dans « À propos »
• 3 questions IA gratuites par jour (30 sans publicité)
</fr-FR>
<sw>
Mapya
• Msaidizi mpya wa AI: uliza kuhusu hesabu ulizohifadhi au andika hesabu kwa maneno yako, mf. "Punguzo la 15% kwa 2,400 pamoja na VAT 7.5%"
• Maarifa: muhtasari wa haraka wa matumizi, akiba na mazoea yako
• Eleza: ona hatua kwa hatua jinsi kila jibu linavyokokotolewa
• Muhtasari wa vipengele kwenye skrini ya Kuhusu
• Maswali 3 ya AI bure kila siku (30 bila matangazo)
</sw>
<hi-IN>
नया क्या है
• नया AI सहायक: अपनी सहेजी गई गणनाओं के बारे में पूछें या अपने शब्दों में गणना लिखें, जैसे "2,400 पर 15% छूट और 7.5% GST"
• जानकारी: आपके खर्च, बचत और आदतों का झटपट सारांश
• समझाएँ: देखें कि हर परिणाम कदम-दर-कदम कैसे निकाला गया
• परिचय स्क्रीन में सुविधाओं की सूची
• रोज़ 3 मुफ़्त AI सवाल (विज्ञापन-मुक्त में 30)
</hi-IN>
<es-ES>
Novedades
• Nuevo asistente de IA: pregunta sobre tus cálculos guardados o escribe un cálculo con tus palabras, como «15 % de descuento sobre 2.400 más 7,5 % de IVA»
• Resumen: un vistazo rápido a tus gastos, ahorros y hábitos
• Explicar: mira paso a paso cómo se calcula cada resultado
• Resumen de funciones en «Acerca de»
• 3 preguntas de IA gratis al día (30 sin anuncios)
</es-ES>
<pt-BR>
Novidades
• Novo assistente de IA: pergunte sobre seus cálculos salvos ou escreva um cálculo com suas palavras, como "15% de desconto em 2.400 mais 7,5% de imposto"
• Insights: um resumo rápido dos seus gastos, economias e hábitos
• Explicar: veja passo a passo como cada resultado é calculado
• Visão geral dos recursos na tela Sobre
• 3 perguntas de IA grátis por dia (30 sem anúncios)
</pt-BR>
<ar>
الجديد
• مساعد ذكاء اصطناعي جديد: اسأل عن عملياتك الحسابية المحفوظة أو اكتب عملية حسابية بكلماتك، مثل "خصم 15% على 2,400 مع ضريبة 7.5%"
• رؤى: ملخص سريع لإنفاقك وتوفيرك وعاداتك
• شرح: شاهد خطوة بخطوة كيف تُحسب كل نتيجة
• نظرة عامة على الميزات في شاشة "حول التطبيق"
• 3 أسئلة مجانية يوميًا للذكاء الاصطناعي (30 بدون إعلانات)
</ar>
```

## 1.0.3 — build 4

- Calculator names on the home screen wrap to two lines instead of being cut off.

## 1.0.2 — build 3

- New launch screen: gradient % on white, near-black in dark mode, matching on
  Android 12+ and older versions.

## 1.0.1 — build 2

- Support email changed to techoveridehub@gmail.com; privacy policy moved to
  https://techoveridehub.com/percal-privacy-policy/.

Play notes covering 1.0.1–1.0.3 (for testers who had 1.0.0):

```
<en-US>
What's new
• Fresh launch screen that matches light and dark mode
• Calculator names on the home screen are no longer cut off
• New support email: techoveridehub@gmail.com
• Small fixes and improvements
</en-US>
<fr-FR>
Nouveautés
• Nouvel écran de démarrage adapté aux modes clair et sombre
• Les noms des calculatrices ne sont plus coupés sur l'écran d'accueil
• Nouvelle adresse d'assistance : techoveridehub@gmail.com
• Petites corrections et améliorations
</fr-FR>
<sw>
Mapya
• Skrini mpya ya kuanzia inayolingana na mandhari angavu na giza
• Majina ya vikokotoo kwenye skrini ya mwanzo hayakatiki tena
• Barua pepe mpya ya msaada: techoveridehub@gmail.com
• Marekebisho madogo na maboresho
</sw>
<hi-IN>
नया क्या है
• नई स्टार्ट स्क्रीन, जो लाइट और डार्क मोड के अनुसार दिखती है
• होम स्क्रीन पर कैलकुलेटर के नाम अब कटते नहीं हैं
• नया सहायता ईमेल: techoveridehub@gmail.com
• छोटे सुधार और बेहतरियाँ
</hi-IN>
<es-ES>
Novedades
• Nueva pantalla de inicio adaptada a los modos claro y oscuro
• Los nombres de las calculadoras ya no se cortan en la pantalla principal
• Nuevo correo de soporte: techoveridehub@gmail.com
• Pequeñas correcciones y mejoras
</es-ES>
<pt-BR>
Novidades
• Nova tela de abertura que combina com os modos claro e escuro
• Os nomes das calculadoras não aparecem mais cortados na tela inicial
• Novo e-mail de suporte: techoveridehub@gmail.com
• Pequenas correções e melhorias
</pt-BR>
<ar>
الجديد
• شاشة بدء جديدة تتوافق مع الوضعين الفاتح والداكن
• لم تعد أسماء الحاسبات مقطوعة في الشاشة الرئيسية
• بريد دعم جديد: techoveridehub@gmail.com
• إصلاحات وتحسينات صغيرة
</ar>
```

## 1.0.0 — build 1

First release on the new package name (a rebuild of the original app, recovered
and modernised for Flutter 3.47 / Material 3):

- 11 calculators: percentage, what % of, increase, decrease, percentage change,
  discount, tip & split bill, VAT / sales tax, profit margin, exam grade,
  loan & interest.
- Results as you type, copy and share; history with CSV export.
- Light / dark mode and accent colours; English, French, Swahili, Hindi,
  Spanish, Portuguese and Arabic.
- Home-screen widget and long-press shortcuts.
- Ads (banner, app open, rewarded) with a one-time "remove ads" purchase;
  Google consent form for the EEA/UK.
- Firebase Analytics, Crashlytics and Remote Config–driven update prompts.

```
<en-US>
Welcome to Percentage Calculator!
• 11 calculators: percentage, % of, increase, decrease, % change, discount, tip & split bill, VAT/tax, profit margin, exam grade, loan & interest
• Results update as you type – tap to copy or share
• Calculation history, exportable as CSV
• Light & dark mode with accent colours
• Home-screen widget and app shortcuts
• Available in 7 languages
• One-time purchase to remove all ads
</en-US>
<fr-FR>
Bienvenue dans Calculatrice de pourcentage !
• 11 calculatrices : pourcentage, quel %, augmentation, diminution, variation, remise, pourboire et partage, TVA, marge, note d'examen, prêt et intérêts
• Résultats instantanés – touchez pour copier ou partager
• Historique des calculs, exportable en CSV
• Mode clair et sombre, couleurs au choix
• Widget d'écran d'accueil et raccourcis
• Disponible en 7 langues
• Achat unique pour supprimer les publicités
</fr-FR>
<sw>
Karibu Kikokotoo cha Asilimia!
• Vikokotoo 11: asilimia, ni % ngapi, ongezeko, upungufu, mabadiliko, punguzo, bakshishi na kugawana bili, VAT/kodi, faida, alama za mtihani, mkopo na riba
• Matokeo yanaonekana unapoandika – gusa kunakili au kushiriki
• Historia ya hesabu, inaweza kuhamishwa kama CSV
• Mandhari angavu na giza, rangi za kuchagua
• Wijeti ya skrini ya nyumbani na njia za mkato
• Inapatikana kwa lugha 7
• Malipo ya mara moja kuondoa matangazo
</sw>
<hi-IN>
प्रतिशत कैलकुलेटर में आपका स्वागत है!
• 11 कैलकुलेटर: प्रतिशत, कितना %, वृद्धि, कमी, प्रतिशत परिवर्तन, छूट, टिप और बिल बँटवारा, GST/VAT, लाभ मार्जिन, परीक्षा अंक, लोन और ब्याज (EMI)
• टाइप करते ही परिणाम – कॉपी या शेयर करने के लिए टैप करें
• गणनाओं का इतिहास, CSV में निर्यात
• लाइट और डार्क मोड, पसंदीदा रंग
• होम-स्क्रीन विजेट और शॉर्टकट
• 7 भाषाओं में उपलब्ध
• विज्ञापन हटाने के लिए एक बार की खरीद
</hi-IN>
<es-ES>
¡Bienvenido a Calculadora de porcentajes!
• 11 calculadoras: porcentaje, qué %, aumento, reducción, variación, descuento, propina y dividir cuenta, IVA, margen, nota de examen, préstamo e intereses
• Resultados al instante – toca para copiar o compartir
• Historial de cálculos, exportable a CSV
• Modo claro y oscuro con colores a elegir
• Widget de pantalla de inicio y accesos directos
• Disponible en 7 idiomas
• Pago único para quitar los anuncios
</es-ES>
<pt-BR>
Bem-vindo à Calculadora de porcentagem!
• 11 calculadoras: porcentagem, quantos %, aumento, redução, variação, desconto, gorjeta e divisão da conta, imposto, margem de lucro, nota da prova, empréstimo e juros
• Resultados enquanto você digita – toque para copiar ou compartilhar
• Histórico de cálculos, exportável em CSV
• Modo claro e escuro com cores à escolha
• Widget na tela inicial e atalhos
• Disponível em 7 idiomas
• Compra única para remover os anúncios
</pt-BR>
<ar>
مرحبًا بك في حاسبة النسبة المئوية!
• 11 حاسبة: النسبة المئوية، كم % من، الزيادة، التخفيض، نسبة التغير، الخصم، الإكرامية وتقسيم الفاتورة، ضريبة القيمة المضافة، هامش الربح، درجة الاختبار، القرض والفائدة
• نتائج فورية أثناء الكتابة – اضغط للنسخ أو المشاركة
• سجل العمليات الحسابية مع التصدير بصيغة CSV
• الوضع الفاتح والداكن مع ألوان مميزة
• أداة للشاشة الرئيسية واختصارات
• متوفر بـ 7 لغات
• شراء لمرة واحدة لإزالة الإعلانات
</ar>
```
