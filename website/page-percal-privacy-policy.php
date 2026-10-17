<?php
/**
 * Template Name: Percentage Calculator – Privacy Policy
 * Template Post Type: page
 *
 * Privacy policy for the Percentage Calculator app (Android / iOS).
 *
 * Install:
 *  1. Copy this file into your active theme folder (a child theme is best, so
 *     theme updates don't remove it): wp-content/themes/<your-theme>/
 *  2. In WordPress, create a Page with the slug  percal-privacy-policy  and
 *     publish it. WordPress uses this file for that page automatically
 *     (page-{slug}.php); you can also pick it under Page → Template.
 *  3. The page is then live at https://techoveridehub.com/percal-privacy-policy/
 *     — the URL the app links to and the one to give Google Play Console.
 *
 * The policy text lives in this file; anything typed in the page editor is
 * not shown.
 *
 * @package Techoveride
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

$percal_app_name      = 'Percentage Calculator';
$percal_developer     = 'Techoveride';
$percal_contact_email = 'techoveridehub@gmail.com';
$percal_website       = home_url( '/' );
$percal_package_name  = 'com.techoveride.percentagecalculator';
$percal_last_updated  = 'October 17, 2026';

$percal_email_link = sprintf(
	'<a href="%1$s">%2$s</a>',
	esc_url( 'mailto:' . antispambot( $percal_contact_email ) ),
	esc_html( antispambot( $percal_contact_email ) )
);

// Header: classic themes use header.php; block themes use the "header" part.
if ( function_exists( 'wp_is_block_theme' ) && wp_is_block_theme() ) {
	?>
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
	<meta charset="<?php bloginfo( 'charset' ); ?>">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>
<div class="wp-site-blocks">
	<?php
	block_template_part( 'header' );
} else {
	get_header();
}
?>

<style>
	/* Scoped to this page so the theme's own styles are untouched. */
	.percal-privacy { max-width: 760px; margin: 0 auto; padding: 32px 16px 64px; line-height: 1.65; }
	.percal-privacy h1 { margin: 0 0 4px; line-height: 1.25; }
	.percal-privacy h2 { font-size: 1.25rem; margin: 36px 0 8px; }
	.percal-privacy .percal-muted { opacity: .75; }
	.percal-privacy .percal-summary {
		background: rgba(127, 127, 127, .08); border: 1px solid rgba(127, 127, 127, .25);
		border-radius: 12px; padding: 16px 20px; margin-top: 24px;
	}
	.percal-privacy .percal-summary ul { margin: 8px 0 0; padding-left: 20px; }
	.percal-privacy .percal-table-wrap { overflow-x: auto; }
	.percal-privacy table { width: 100%; border-collapse: collapse; margin-top: 8px; font-size: .95rem; }
	.percal-privacy th, .percal-privacy td {
		text-align: left; vertical-align: top; padding: 10px 8px;
		border: 0; border-bottom: 1px solid rgba(127, 127, 127, .25);
	}
	.percal-privacy th { font-weight: 600; opacity: .8; }
	.percal-privacy .percal-footer { margin-top: 48px; font-size: .9rem; }
</style>

<main id="primary" class="percal-privacy">
	<h1><?php esc_html_e( 'Privacy Policy', 'techoveride' ); ?></h1>
	<p class="percal-muted">
		<?php echo esc_html( $percal_app_name . ' · ' . $percal_developer . ' · Last updated ' . $percal_last_updated ); ?>
	</p>

	<div class="percal-summary">
		<strong>In short</strong>
		<ul>
			<li>You don't need an account, and we don't ask for your name, contacts, photos or location.</li>
			<li>Your calculations, history and settings stay on your device.</li>
			<li>The app is free because it shows ads from Google AdMob, which collects device data to show and measure ads. Where the law requires it, we ask for your consent first.</li>
			<li>You can remove all ads with a one-time purchase through Google Play or the App Store. We never see your payment details.</li>
			<li>We use anonymous usage statistics and crash reports to fix bugs and improve the app.</li>
			<li>The optional AI assistant only sends your question and saved calculations when you ask it something.</li>
			<li>We never sell your personal information.</li>
		</ul>
	</div>

	<h2>1. Who we are</h2>
	<p>
		This policy explains how <?php echo esc_html( $percal_app_name ); ?>
		(package <code><?php echo esc_html( $percal_package_name ); ?></code>),
		published by <?php echo esc_html( $percal_developer ); ?> (“we”, “us”), handles information when you use the app.
		Questions? Email <?php echo $percal_email_link; // phpcs:ignore WordPress.Security.EscapeOutput -- escaped above. ?>.
	</p>

	<h2>2. Information stored only on your device</h2>
	<p>
		The numbers you enter, your calculation history, your theme, colour and language choices, and whether
		you have removed ads or unlocked extras are saved on your device so the app can show them again. Your
		most recent result is also shown on the home-screen widget if you add it. None of this leaves your device unless you use the AI assistant (see section 4).
		You can delete your history at any time (History → Clear history), and uninstalling the app removes
		all of it. If you export your history as a CSV file, you choose where that file is sent.
	</p>

	<h2>3. Information collected by third-party services</h2>
	<p>The app uses the following Google services, which collect information under their own privacy policies:</p>
	<div class="percal-table-wrap">
		<table>
			<tr><th>Service</th><th>What it may collect</th><th>Why</th></tr>
			<tr>
				<td>Google AdMob<br><a href="https://policies.google.com/technologies/partner-sites">How Google uses data</a></td>
				<td>Advertising ID, IP address, approximate location derived from the IP address, device and app information, ad interactions, and diagnostic data.</td>
				<td>To show banner, app-open and rewarded video ads (rewarded ads are only shown when you choose to watch one to unlock an extra), measure them, limit how often you see them, and prevent fraud. Ads may be personalised only where you have allowed it.</td>
			</tr>
			<tr>
				<td>Google Gemini (Firebase AI Logic)<br><a href="https://ai.google.dev/gemini-api/terms">Gemini API terms</a></td>
				<td>Your AI question and saved calculations — only when you use the AI assistant (section 4).</td>
				<td>To answer your question.</td>
			</tr>
			<tr>
				<td>Google Analytics for Firebase<br><a href="https://firebase.google.com/support/privacy">Firebase privacy</a></td>
				<td>App-instance ID, which screens and calculators are used, app version, device model, operating system, language and approximate country. Not the numbers you type.</td>
				<td>To understand which features people use so we can improve the app.</td>
			</tr>
			<tr>
				<td>Firebase Crashlytics<br><a href="https://firebase.google.com/support/privacy">Firebase privacy</a></td>
				<td>Crash reports: the error, the app state when it happened, device model and operating system version, and a Crashlytics installation ID.</td>
				<td>To find and fix crashes.</td>
			</tr>
			<tr>
				<td>Firebase Remote Config<br><a href="https://firebase.google.com/support/privacy">Firebase privacy</a></td>
				<td>Firebase installation ID, app version, device model and operating system version.</td>
				<td>To tell the app when a newer version is available or required.</td>
			</tr>
			<tr>
				<td>Google Play / Apple App Store</td>
				<td>Handled by the store under its own privacy policy. We receive only a confirmation that the purchase was made — never your name, card or payment details.</td>
				<td>The one-time “remove ads” purchase, in-app updates and the rating prompt.</td>
			</tr>
		</table>
	</div>

	<h2>4. When you use the AI assistant</h2>
	<p>
		The AI assistant is optional. The first time you open it, the app asks for your permission. Only when you ask
		a question, request insights or tap “Explain”, the app sends the following over an encrypted connection to
		Google's Gemini AI through Firebase AI Logic, to write the answer:
	</p>
	<ul>
		<li>your question (or the calculation to explain);</li>
		<li>your saved calculations: the calculator used, the numbers you entered, the results and the date;</li>
		<li>the app language;</li>
		<li>a Firebase App Check token, which proves the request comes from the genuine app.</li>
	</ul>
	<p>
		No account, name, email address, advertising ID or location is sent, and we do not store your questions or
		answers. Google processes the request under the
		<a href="https://ai.google.dev/gemini-api/terms">Gemini API terms</a> and the
		<a href="https://policies.google.com/privacy">Google Privacy Policy</a>. We use Gemini's free tier, under which
		Google may use what is sent to improve its products, and trained reviewers may read it — so please don't type
		personal information into your questions. Your daily AI question count is kept only on your device.
		AI answers can be wrong; numbers in the app are always worked out by the calculator itself. You can report any
		answer with the flag button next to it. If we change AI provider, we will update this section first.
	</p>

	<h2>5. Your consent and choices</h2>
	<ul>
		<li>
			<strong>European Economic Area, United Kingdom and Switzerland:</strong> on first launch the app shows
			Google's consent form, where you can accept or refuse personalised ads and data use. You can change your
			choice at any time in the app menu → <em>Privacy Settings</em>.
		</li>
		<li>
			<strong>Everyone:</strong> you can reset or delete your advertising ID, or opt out of personalised ads,
			in your device settings (Android: Settings → Google → Ads, or Settings → Privacy → Ads;
			iOS: Settings → Privacy &amp; Security → Tracking).
		</li>
		<li>
			<strong>California and other US states:</strong> we do not sell personal information for money.
			Sharing device data with Google for advertising may count as “sharing” under some state laws; you can
			opt out using the device settings above.
		</li>
	</ul>

	<h2>6. When you contact us</h2>
	<p>
		If you send a bug report or idea from the app, your email app sends us your message, your email address,
		the app version, your device platform and the app language. We use this only to reply and to improve the app,
		and delete it when it's no longer needed.
	</p>

	<h2>7. Children</h2>
	<p>
		The app is a general-audience calculator and is not directed at children under 13 (or the minimum age in your
		country). We do not knowingly collect personal information from children. If you believe a child has provided
		us with personal information, contact us and we will delete it.
	</p>

	<h2>8. Security and retention</h2>
	<p>
		Data sent to Google services, including the AI assistant, is encrypted in transit and kept according to
		Google's retention policies.
		We keep support emails only as long as needed to handle your request.
	</p>

	<h2>9. Your rights</h2>
	<p>
		Depending on where you live, you may have the right to access, correct, delete or object to the processing of
		your personal information. Because we don't hold app data on our own servers, most requests are handled directly
		in the app (clearing history, Privacy Settings) or through Google. For anything else, email
		<?php echo $percal_email_link; // phpcs:ignore WordPress.Security.EscapeOutput -- escaped above. ?>.
	</p>

	<h2>10. Changes to this policy</h2>
	<p>
		We may update this policy when the app changes. The “Last updated” date above shows the latest version.
	</p>

	<p class="percal-footer percal-muted">
		&copy; <?php echo esc_html( wp_date( 'Y' ) ); ?>
		<a href="<?php echo esc_url( $percal_website ); ?>"><?php echo esc_html( $percal_developer ); ?></a>
	</p>
</main>

<?php
// Footer: matches the header branch above.
if ( function_exists( 'wp_is_block_theme' ) && wp_is_block_theme() ) {
	block_template_part( 'footer' );
	?>
</div>
	<?php wp_footer(); ?>
</body>
</html>
	<?php
} else {
	get_footer();
}
