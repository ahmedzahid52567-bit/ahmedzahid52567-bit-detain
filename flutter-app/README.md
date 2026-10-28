# DETAIN — Antigravity Pack

**DETAIN = Digital Education Tracking Attendance Identification Network**
Tagline: **One Student. One Phone. One Chance.**
Prepared by Zahid Ahmed. Every screen carries a ZAHID AHMED watermark.

## What is in this folder

| File | What it is |
|---|---|
| `lib/main.dart` | Full Flutter starter. Teacher, Student, Progress, Messages, Updates. Offline storage, one QR/code per class, Double Loss Rule, receipt, locked sheet. |
| `pubspec.yaml` | Free packages only: qr_flutter, shared_preferences, local_auth. No server, no paid service. |
| `DETAIN_SPEC.md` | Master spec. Give this to Antigravity too, so it does not invent features. |
| `ANTIGRAVITY_PROMPT.md` | Paste-ready prompt. Copy it into Antigravity after opening this folder. |
| `reference/detain-offline-demo.html` | Working HTML demo. The logic Antigravity should match. Open it in a browser to see the flow. |
| `reference/detain-master-notes.pdf` | Master notes PDF, 8 pages, watermarked. |

## How to use it in Antigravity — 4 steps

1. **Download the zip, unzip it.** Open the `detain-antigravity` folder in Antigravity, not just one file.
2. **Paste the prompt.** Open `ANTIGRAVITY_PROMPT.md`, copy the whole prompt, paste it into Antigravity chat.
3. **Let it install and run.** It should run:
   ```
   flutter pub get
   flutter run
   ```
   If Flutter is not installed on your computer, Antigravity will tell you the install steps. Flutter itself is free.
4. **Test in this order, like a teacher demo:**
   - Teacher tab: Start session, show QR/code.
   - Student tab: Owner = Zahid Ahmed, Mark for = Zahid Ahmed, tick room, biometric, enter code, Mark.
   - Check Teacher tab count rises, and the receipt shows.
   - Proxy test: Owner = Arjun Kumar, Mark for = Rohan Sharma. Both should be Blocked. That is the Double Loss Rule.
   - Teacher tab: Close session, check Progress tab.

## Free — what costs, what does not

- Free: Flutter, VS Code / Android Studio, this starter, offline storage, GPS, fingerprint, QR, APK sharing.
- Not free, and NOT needed now: Google Play $25 one time, Apple App Store $99 per year. For a college demo, share the APK directly.
- Never add: a paid cloud database, a paid server, or a face-photo database. DETAIN stores no face photo.

## If Antigravity breaks something

Tell it, in simple words:
- "Keep it offline. No server, no paid package."
- "Do not remove the Double Loss Rule, receipt, locked sheet, or ZAHID AHMED watermark."
- "Fix only the error. Do not add new features."

## Honest limits of this starter

- Room tick is a stand-in for phone GPS. Full app: replace it with GPS (geolocator package).
- Biometric on an emulator uses Demo Confirm. On a real phone, fingerprint / Face ID must pass.
- QR scanning by camera is not in this starter — code entry is the fallback, and it works without a projector. Ask Antigravity to add camera scanning with `mobile_scanner` as step 2, after the core works.
- Notifications in this starter are in-app test buttons. Background notifications need `flutter_local_notifications` setup — ask Antigravity for that as step 3, not step 1.
- Progress zones are demo thresholds only, not a verified college rule. Change them to the college rule before a pilot.
