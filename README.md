# DETAIN

**DETAIN — Digital Education Tracking Attendance Identification Network**
Tagline: **One Student. One Phone. One Chance.**
Prepared by Zahid Ahmed.

An offline, anti-proxy college attendance system for a real classroom — no college WiFi, no projector, no new machine to buy.

## What it does

- One QR/code per class, shown on the teacher phone, said aloud, or written on the board.
- Student checks together: room (phone GPS in the full app), one phone per student, phone biometric (fingerprint / phone Face ID, no face photo stored).
- Live properly-marked count on the teacher phone.
- **Double Loss Rule:** if a student tries to mark for another student, the target gets no mark and the attempter also loses his own attendance for that class.
- Student receipt with time, room, subject, and receipt code.
- Locked sheet after close — no silent edits, corrections stay visible.
- Timetable notifications, progress Green / Yellow / Red, private student message box (teacher sees category, text, time only), and teacher updates box.

## Files in this repo

- `detain-offline-demo.html` — Working offline demo. Open it on a phone or laptop, no internet needed after it opens. Teacher tab, then Student tab.
- `flutter-app/` — Free Flutter starter (Teacher, Student, Progress, Messages, Updates). See `flutter-app/README.md` for how to run it with `flutter pub get` and `flutter run`.
- `detain-master-prompt.md` — Full 12-section master prompt for building DETAIN.
- `detain-quick-master-prompt.md` — Short prompt for public URL + APK + login.
- `detain-manus-frontend-prompt.md` — Prompt for a frontend look only.
- `detain-pitch-script.md` — 5–8 minute pitch script, about 7 minutes at normal speed.

## What is NOT in this repo

The master notes PDF and the demo videos are not pushed here, because this push is for UTF-8 text files only. The PDF and videos stay as separate deliverables.

## Honest limits

- Room tick in the starter is a stand-in for phone GPS. Real GPS comes in the full app.
- Biometric on an emulator uses Demo Confirm. On a real phone, fingerprint / Face ID must pass.
- Progress zones are demo thresholds (Green 85%+, Yellow 75–84%, Red below 75%), not a verified college rule. Change them to the college rule before a pilot.
- Do not claim DETAIN is unique worldwide as a QR product. Its distinction is the combination: Double Loss + receipt + locked sheet + private box + timetable + progress, offline and simple.
