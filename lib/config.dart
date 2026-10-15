/// Server the app talks to.
/// Overridable at build time for test builds: `--dart-define=API_BASE=http://10.0.2.2:8765/api`.
const String apiBaseUrl = String.fromEnvironment('API_BASE', defaultValue: 'https://balance-academy.com/api');
const String siteUrl = 'https://balance-academy.com';

/// QR format the Balance Academy attendance app already understands (its config.dart: 'MK-' + the
/// student number, no padding). Used as the fallback while the rotating code is not available.
const String legacyQrPrefix = 'MK-';

/// The rotating code changes every this many seconds (must match the server's BleToken).
const int codeWindowSeconds = 30;

const String appVersionLabel = '1.0.0';
