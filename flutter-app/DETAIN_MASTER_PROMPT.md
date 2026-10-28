# DETAIN — MASTER PROMPT
# Copy this whole file into any AI coding tool (Antigravity, or any other).
# It is the single master instruction for building DETAIN from scratch to a working app.
# Do not skip sections. Do not invent features. Do not remove rules to make it build.

---

## 1. YOUR ROLE

You are a senior Flutter developer building a real, working college app.
Build the app, do not just describe it. Fix every build error yourself.
If you cannot fix an error, say the exact error in simple words and what you tried.
Work in small, testable steps. After each step, tell me what works and what does not.

## 2. THE PROJECT

**Name:** DETAIN
**Expansion:** Digital Education Tracking Attendance Identification Network
**Tagline:** One Student. One Phone. One Chance.
**Prepared by:** Zahid Ahmed
**Watermark:** Light diagonal "ZAHID AHMED" watermark on every screen, behind the content, never blocking a button.

**Problem, in simple words:**
A student can attend class, yet the sheet can later say absent. A photo of a QR can be sent to a friend at the hostel, and that friend marks proxy. A student who was present has no proof. An honest teacher also has no proof. Old systems need WiFi, a projector, or a new machine, and many colleges do not have them reliably.

**Idea, in one line:**
DETAIN gives proof that this student, on this phone, was in this room, at this class time, and gives both sides a record neither side can silently change.

**What is new:**
Not QR alone. The combination is new for a college class: one QR/code per class + room + phone + biometric + live teacher count + Double Loss Rule + student receipt + locked sheet + private message box + teacher updates box + timetable notifications + progress zones, all offline and simple.

**Made for:**
A real classroom, not a smart classroom. No reliable college WiFi. Projector works sometimes, fails sometimes. Wooden broken benches. No smart board, no new machine to buy.

## 3. HARD RULES — NEVER BREAK THESE

1. **FREE ONLY.** Flutter, VS Code / Android Studio, and free packages only. No server, no paid database, no paid cloud, no Firebase paid plan, no paid API. Offline storage on the phone is enough for Phase 1 and the pilot.
2. **OFFLINE FIRST.** Attendance must save on the phone with no internet. Sync later only via teacher-phone hotspot if needed. Scan time is the real time, not sync time.
3. **NO FACE PHOTO, EVER.** Never store a face photo. Never add face-photo matching. Biometric means only the phone's own fingerprint / Face ID, which returns yes or no.
4. **ONE QR / CODE PER CLASS.** One QR and one 6-digit code for the whole class session. It dies when the teacher closes the session. No rotating QR, no per-student QR.
5. **NO PROJECTOR NEEDED.** QR on the teacher phone, or on screen if it works. If there is no projector, the teacher says the code aloud or writes it on the board. Students scan it, or enter the code.
6. **DOUBLE LOSS RULE.** This is the core rule. If phone owner tries to mark for a different student, the target gets no mark from that scan, AND the owner loses his own attendance for that class. If the owner was already present, it turns to absent. If not yet marked, he is blocked for that class. A failed or blurry scan alone is only a retry, never a penalty. Show a warning before scanning. Flags are private to teacher/coordinator only. The class screen shows numbers only, never flagged names.
7. **RECEIPT + LOCKED SHEET.** After a good mark, the student gets time, room, subject, and receipt code (format DT-xxxxx). After close, the sheet locks. There is no silent edit button. A correction needs a reason, stays visible in a log, and never overwrites the original.
8. **PRIVACY.** A private student message saves ONLY category, text, and time. Never save name, phone, or device with a message. If a writer writes a name inside the message text, that is their own choice. The system must not add identity.
9. **SIMPLE UI.** Short words, big buttons, one action at a time. No technical English, no long forms. A teacher must understand it in 2 minutes.
10. **WATERMARK.** Light diagonal ZAHID AHMED watermark on every screen.
11. **NO INVENTED NUMBERS.** Never invent college rules, attendance percentages, or statistics. Progress zones below are demo thresholds, not a college rule, and must be labelled as demo.

## 4. TECH STACK (FREE)

- Language: Dart, framework: Flutter, one codebase for Android, iOS, and laptop/desktop.
- Editor: VS Code or Android Studio, both free.
- Storage: SharedPreferences for the starter, local database (SQLite / Hive) in the full app. No server.
- QR: qr_flutter for showing QR, mobile_scanner for camera scanning in step 2 only.
- Biometric: local_auth only, fingerprint / phone Face ID.
- Room: geolocator GPS in the full app. In the starter, a room tick box is a stand-in and must be labelled as a stand-in.
- Notifications: flutter_local_notifications in step 3 only. In the starter, in-app test buttons are enough.
- Sharing: Android APK built with `flutter build apk` and shared directly. Do NOT require Google Play ($25) or Apple App Store ($99) for the demo or pilot.

## 5. DATA MODEL

Use these exact concepts, even if you rename the code fields:

- Student: name. Demo class of 6: Zahid Ahmed, Arjun Kumar, Rohan Sharma, Priya Nair, Kiran Rao, Sneha Patel.
- Session: id (DT-YYYY-MM-DD-CODE), subject, room (default Room 304), code (6 digits), isActive, isClosed, startedAt, closedAt.
- Record per student per session: status = Present | Desk verified | Blocked | Not yet marked, plus time and receipt code if Present.
- Flag: text, for example "Arjun Kumar tried for Rohan Sharma", private to teacher.
- History: one entry per closed session, with subject and per-student attended true/false.
- Message: category, text, time only. Categories: Class information, Doubt in class, Attendance problem, Problem in class, Other.
- Teacher update: type, title, text. Types: Book checking, Record correction, Class test, Assignment, Other update.
- Timetable: editable text, one line per slot, format HH:MM-HH:MM Name. Default demo day:
  09:00-10:00 SE - BCS501
  10:00-11:00 CN - BCS502
  11:00-11:15 Break
  11:15-12:15 TOC - BCS503
  12:15-13:15 AI - BCS515B
  13:15-14:00 Lunch
  14:00-15:00 RMI - BRMK557
  15:00-16:00 EVS - BCS508
  Break 11:00-11:15 and lunch 1:15-2:00 are from the class pattern. Subject order is demo only, replace it with the real day timetable before a pilot.

## 6. SCREENS — BUILD THESE, IN THIS ORDER

### Screen 1: Teacher
- Choose subject from: SE - BCS501, CN - BCS502, TOC - BCS503, AI - BCS515B, RMI - BRMK557, EVS - BCS508.
- Room field, default Room 304.
- Button: Start session — one QR / code per class.
- When live: show QR (payload: DETAIN|sessionId|room|code), show the 6-digit code in large text, show "No projector? Say the code aloud, or write it on the board."
- Live count: Properly marked: X / 6. Split: properly verified, desk verified, blocked attempts, not yet marked. Only proper verification raises the main count.
- Button: Close session — lock sheet.
- When closed: final report, percentage, full list, private flags list, and a copy-as-text report.
- Timetable section: editable timetable, Save button, Test 9 am notification button, Test 10 am grace + next class button.

### Screen 2: Student
- Warning at the top, in red: Try proxy, lose your own attendance. This is the Double Loss Rule.
- Phone owner dropdown, Mark attendance for dropdown.
- Checkbox: I am in Room 304. Label it as a GPS stand-in in the starter.
- Code entry field. Camera scan button is step 2, not step 1.
- Biometric button: Confirm with phone biometric. On a real phone, fingerprint / Face ID must pass. On an emulator with no biometric, a clearly labelled Demo Confirm is allowed for testing only.
- Mark my attendance button. Validate in this order: session is live, code matches, room ticked, biometric confirmed, not already marked.
- If owner != target: apply Double Loss Rule, show the block message, do not give a receipt.
- If owner == target and all checks pass: status Present, show receipt card with time, room, subject, receipt code.
- Note: Desk verified — phone dead or no internet? Go to the teacher desk with ID. Teacher marks Desk verified separately.

### Screen 3: Progress
- Counts only closed classes, not a live session.
- For each student: attended / held closed classes, percentage, zone.
- Zones, labelled as demo only: Green 85% and above (Safe), Yellow 75-84% (Warning), Red below 75% (Danger).
- Example to show in testing: 3 out of 5 = 60%, Red, needs 9 classes in a row to reach 85%.
- Full app rule: a student sees only his own progress. The teacher sees the whole class. In the starter demo, the list is visible for testing.

### Screen 4: Messages — Private student to teacher
- Category dropdown, message text box, Send privately button.
- Save only category, text, time. Never save sender.
- Teacher view list below, with category, text, time only. Mark as seen, clear messages.
- Full app rule: only the teacher sees this list. In the starter demo, the list is visible for testing.
- Built for hesitant students and for CRs passing class information.

### Screen 5: Updates — Teacher to class
- Type dropdown, title, details, Post update button.
- List of updates for students to read. Teacher can delete an update or clear all.
- Full app rule: only the teacher can post or delete. Students can only read. In the starter demo, posting is open for testing.

## 7. HOW ONE CLASS WORKS — THE FLOW YOU MUST IMPLEMENT

1. Timetable is set by the creator. The system knows what class is now and what is next.
2. Notification before class: NOW IS YOUR SE class from 9 am to 10 am.
3. Teacher starts the class. One tap. One QR/code for the whole class.
4. QR circulates. Students scan it, or enter the code said aloud or written on the board.
5. Student checks pass together: room, one phone per student, phone biometric, one mark per class. Random second check during class, at a random time, in the full app.
6. Live count rises on the teacher phone.
7. Class ends + grace: At 10 am: You have 5 more minutes to mark SE attendance. Now from 10 am to 11 am, it is CN class. After 5 minutes, SE closes automatically.
8. Sheet locks + report. Final count, percentage, locked sheet, private flags.

## 8. EDGE CASES — HANDLE ALL OF THESE

- Wrong code: show "Wrong code" only, no penalty, no flag.
- Blurry scan / failed scan: retry only, no penalty, no flag.
- Same phone tries 2 accounts in one session: confirmed proxy, Double Loss applies.
- Same account from 2 devices or 2 places at once: confirmed proxy, Double Loss applies.
- Second check fails: confirmed proxy, Double Loss applies.
- Innocent target arrives later and marks correctly himself: he still gets present. The attempter still loses his own.
- Phone dead / no internet: Desk verified path, saved separately, not as a normal scan.
- Student appeals: appeal to coordinator with ID proof. If accepted, penalty is removed, but the correction stays visible in the log.
- Session already closed: code must not work. Show "Session closed."
- Student already marked: second mark is blocked, show "Already marked present."
- No biometric on device: show a clear message, and in the starter only, allow Demo Confirm with a label that says it is for testing.

## 9. BUILD STEPS — DO NOT SKIP AHEAD

**Step 1 — Core (build this first):**
Teacher start, one QR/code, student code entry, room tick, biometric with Demo Confirm fallback, live count, Double Loss, receipt, close + lock, progress, messages, updates, timetable test buttons, watermark. Use the starter in lib/main.dart if it is in the folder. Run `flutter pub get`, then `flutter run`. Fix every error without deleting a feature.

**Step 2 — Camera + GPS (only after Step 1 works):**
Add camera QR scanning with mobile_scanner, and replace the room tick with real phone GPS (geolocator). GPS must work without college WiFi. Keep code entry as fallback, because iOS browser scanning and low-light scanning can fail.

**Step 3 — Notifications + Report (only after Step 2 works):**
Add background notifications with flutter_local_notifications: class start, 5-minute grace at class end + next class. Add Excel / PDF report export on the teacher phone. Keep in-app test buttons until background notifications are proven.

**Step 4 — Pilot (only after Step 3 works):**
One real class, one week. Collect teacher and student feedback. Fix only what breaks in a real room. Then expand class by class. Do not add new features during the pilot week.

## 10. TEST CHECKLIST — REPORT EACH RESULT

Test in this exact order, and report pass or fail for each line:
1. Teacher starts SE session. QR and code appear.
2. Student: Owner Zahid Ahmed, Mark for Zahid Ahmed, room ticked, biometric confirmed, correct code. Result must be Present + receipt DT-xxxxx.
3. Teacher count rises to 1 / 6.
4. Student: Owner Arjun Kumar, Mark for Rohan Sharma, correct code. Result must be Blocked for both Arjun and Rohan, flag created, count does NOT rise.
5. Student: Rohan Sharma marks for himself correctly afterwards. Result must be Present. Arjun must still be Blocked.
6. Wrong code: retry only, no block, no flag.
7. Teacher closes session. Sheet locks, code stops working, Progress updates.
8. Message sent: teacher list shows category, text, time only, no sender name.
9. Teacher update posted: students can read it.
10. Timetable test buttons show the exact 9 am and 10 am messages.
11. Watermark ZAHID AHMED is visible on every screen.
12. App works with no internet after first open, on Android.

## 11. ACCEPTANCE CRITERIA — DONE MEANS ALL OF THESE

- `flutter pub get` and `flutter run` succeed with no errors.
- All 12 test checklist lines pass.
- No paid package, no server, no face photo, no silent edit, no invented college rule.
- APK builds with `flutter build apk` and can be shared directly, with no store needed.
- You give me: exact commands used, what passed, what failed, and the next 3 steps only. No new features beyond the spec unless I ask for them.

## 12. WHEN YOU ARE STUCK

- Fix only the error. Do not add a new feature to hide it.
- Do not remove Double Loss, receipt, locked sheet, private messages, or the watermark to make it build.
- Do not switch to a paid service, a server, or face recognition as a shortcut.
- If a package version breaks, try the nearest free version first, and tell me the old and new version in simple words.
- Keep the code simple, in simple words, with short comments. A student with a basic Flutter level must be able to read it.
