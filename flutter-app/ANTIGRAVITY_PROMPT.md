# PASTE THIS WHOLE PROMPT INTO ANTIGRAVITY

Build the DETAIN app from the files in this folder. Do not start from a blank project.

Project: DETAIN — Digital Education Tracking Attendance Identification Network.
Tagline: One Student. One Phone. One Chance.
Prepared by Zahid Ahmed. Put a light diagonal ZAHID AHMED watermark on every screen.

Read DETAIN_SPEC.md and lib/main.dart first. Keep every rule in main.dart. Do not remove any feature to make it build.

Goal for this step: make this Flutter starter run cleanly on Android, with no errors, and test the teacher demo flow.

Rules — do not break these:
1. FREE ONLY. Use only free packages. No server, no paid database, no paid cloud, no Firebase paid plan. Offline storage with shared_preferences is enough.
2. OFFLINE FIRST. No college WiFi needed. No projector needed. No new machine to buy.
3. ONE QR / CODE PER CLASS. Teacher starts one session, one QR and one 6-digit code for the whole class. Code dies when the teacher closes the session. No projector? Teacher says the code aloud or writes it on the board.
4. DOUBLE LOSS RULE. If phone owner tries to mark for a different student, the target gets no mark, AND the owner loses his own attendance for that class. A failed scan alone is only a retry, never a penalty.
5. CHECKS TOGETHER: room check, one phone per student, phone biometric (fingerprint / phone Face ID, local_auth only), one mark per class, random second check later if easy. NEVER store a face photo. NEVER add face-photo matching.
6. RECEIPT + LOCKED SHEET. After a good mark, show time, room, subject, and receipt code. After close, the sheet locks. No silent edits. Corrections must stay visible.
7. TIMETABLE + NOTIFICATIONS. Creator timetable, class-start notification, 5-minute grace at class end plus next-class notification. In-app test buttons are fine for now.
8. PROGRESS ZONES (demo only, not a college rule): Green 85%+, Yellow 75-84%, Red below 75%. Count only closed classes.
9. PRIVATE MESSAGE BOX. Teacher sees only category, text, and time. Save NO name, NO phone, NO device with a message.
10. TEACHER UPDATES BOX. Types: Book checking, Record correction, Class test, Assignment, Other update. Teacher posts, students read.
11. SIMPLE WORDS, BIG BUTTONS. One action at a time. No technical English, no long forms.
12. WATERMARK. Light diagonal ZAHID AHMED watermark on every screen, behind the content, not blocking buttons.

Steps:
1. Run `flutter pub get` and fix any package version error, keeping the same free packages if possible.
2. Run `flutter run` and fix every build error. Do not delete features to hide an error — tell me the error in simple words if you cannot fix it.
3. Test this exact flow and report what happened, step by step:
   - Teacher: Start session, note the code.
   - Student: Owner Zahid Ahmed, Mark for Zahid Ahmed, tick room, biometric, enter code, Mark. Receipt must show.
   - Teacher: Count must rise.
   - Student: Owner Arjun Kumar, Mark for Rohan Sharma. Both must be Blocked.
   - Teacher: Close session. Progress must update.
4. When it runs, give me: the exact commands you used, the APK build command (`flutter build apk`), and the next 3 steps only — camera QR scanning, real GPS, background notifications — in that order. Do not build those 3 yet.
