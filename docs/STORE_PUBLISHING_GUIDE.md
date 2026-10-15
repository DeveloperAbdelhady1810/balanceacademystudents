# Balance Academy app - store publishing guide

App: **Balance Academy** (students + parents). Package / bundle id `com.balanceacademy.student`. Target age **13+**.
Server: balance-academy.com (the new features are switched OFF until you enable them - see section 4).

## 1. Blockers status
| Item | Status |
|---|---|
| Privacy policy URL | Done: `https://balance-academy.com/privacy` (also `/privacy-policy`) |
| Account deletion (in-app + web) | Done as a **disable** (nothing erased): Settings > Delete account, `https://balance-academy.com/delete-account`. Apple's 5.1.1(v) may reject "disable only"; if so the fix is a server change (erase personal details). |
| Support URL | Done: `https://balance-academy.com/support` (support@balance-academy.com) |
| Demo reviewer account | Provided by the owner: student `ahmedmoabdelhady152@gmail.com` (password given in chat, not stored here). Put it in Apple "Review sign-in" and Google "App access". |
| Android release key | Done: `C:\Users\AhmedAbdElHady\balance-academy-upload.jks` (alias `upload`), `android/key.properties` is git-ignored. **Back both up.** |
| Target age | 13+ (sign-up in the app refuses under 13). Answer the Google/Apple questionnaires accordingly. |
| Icon / logo | Built from the supplied 86x86 logo (upscaled, soft): supply a 1024x1024 version for sharper store art, then `dart run flutter_launcher_icons`. |
| Firebase | **You create the project**; replace `lib/firebase_options.dart` (git-ignored), add SHA-1 `D4:87:1C:9E:9F:BE:7D:0A:D6:AD:5A:B5:DD:3D:DB:54:DD:7A:8F:EA` (upload key) and the Play App Signing SHA-1 after the first upload; enable Google sign-in; upload the APNs key. |
| Google Play testers | New personal accounts need 12 testers x 14 days before production. |

## 2. Firebase click path
1. console.firebase.google.com > Add project "Balance Academy".
2. Add Android app `com.balanceacademy.student` (add the SHA-1 above) and iOS app `com.balanceacademy.student`.
3. Authentication > Sign-in method > Google > enable. Download `google-services.json` and `GoogleService-Info.plist`.
4. Project settings > Service accounts > Generate new private key (JSON). Upload it **outside the web root** on the server and set `.env`: `FIREBASE_CREDENTIALS=/path/to/file.json`, `FIREBASE_PROJECT_ID=...`, `GOOGLE_MOBILE_SERVER_CLIENT_ID=<web client id>`, `GOOGLE_MOBILE_CLIENT_IDS=<android id>,<ios id>`, `APPLE_MOBILE_CLIENT_ID=com.balanceacademy.student`; then `php artisan config:clear`.
5. Project settings > Cloud Messaging: upload the APNs auth key (.p8).
6. Send me the three files (or fill `lib/firebase_options.dart` and `ios/Flutter/Secrets.xcconfig` from `.example`). Never commit them.

## 3. Build
- Android: `flutter build appbundle --release` -> `build/app/outputs/bundle/release/app-release.aab`.
- iOS (Mac): set the team in Xcode, add Push Notifications, Background Modes > Remote notifications and Sign in with Apple; `pod install`; Archive.
- Listing text (EN + AR, length limits checked): `store_assets/metadata/`.

## 4. Go-live switch (server)
Rotating codes / Bluetooth stay off until `ble_attendance_enabled` = 1 in `platform_settings`. Parent alerts and the admin "Send Notification" page work as soon as a phone registers a push token. Upgrade the assistants' attendance app first (branch `ble-upgrade` of balanceacademy-attendance-mobile), then enable.

## 5. Store forms
- Data safety / App Privacy: collects name, email, phone, parent phone, student profile, attendance, push token; no ads, no tracking, no location. Deletion URL above.
- Content rating: none/none -> 4+ (Apple) / Everyone (Google); audience 13+.
- Screenshots: not generated yet (need the real icon/logo and a test account).
