# DETAIN — Master Spec for Antigravity

DETAIN = Digital Education Tracking Attendance Identification Network.
Tagline: One Student. One Phone. One Chance.
Prepared by Zahid Ahmed. Watermark ZAHID AHMED on every screen and every PDF page.

## Problem, in simple words
- A student can attend class, yet the sheet can later say absent.
- A photo of a QR can be sent to a friend at the hostel. That friend marks proxy.
- A student who was present has no proof. A honest teacher also has no proof.
- Old systems need WiFi, projector, or a new machine. Many colleges do not have them reliably.

## Idea, in one line
Proof of presence, not just a QR scan. Proof that this student, on this phone, was in this room, at this class time, with a record neither side can silently change.

## How one class works — 8 steps
1. Timetable is set by the creator. Example day, Room 304.
2. Notification before class: NOW IS YOUR SE class from 9 am to 10 am.
3. Teacher starts the class on her phone. One QR/code is made for this whole class.
4. QR circulates on the teacher phone, or on screen if it works. No projector? Teacher says the code aloud, or writes it on the board. Students scan it, or enter the code.
5. Student checks pass together: room (phone GPS in full app), one phone per student, phone biometric, one mark per class. Random second check during class.
6. Live count rises on the teacher phone. Blocked attempts do not count.
7. Class ends + grace: At 10 am: You have 5 more minutes to mark SE attendance. Now from 10 am to 11 am, it is CN class. After 5 minutes, SE closes.
8. Sheet locks + report: final count, percentage, and sheet on the teacher phone. No silent edits.

## Core locks
- One QR/code per class, stops at close.
- Room check: phone GPS, works without college WiFi or internet.
- One phone per student, one account tied to one phone.
- Phone biometric: fingerprint or phone Face ID, phone says yes/no only. No face photo stored.
- Random second check during class.
- One mark per class.

## Fair rules — Double Loss Rule
- If Arjun tries to mark for Rohan, Rohan gets no mark from that scan.
- Arjun also loses his own attendance for that class. If already present, it turns to absent. If not yet marked, he is blocked.
- Penalty only on a confirmed attempt: same phone tries 2 accounts, same account from 2 devices/places, or second check fails. A blurry or failed scan is only a retry.
- Warning before scanning. Flags are private to teacher/coordinator only. Class screen shows numbers only.
- Receipt: time, room, subject, receipt code (DT-xxxxx).
- Locked sheet: correction needs a reason, stays visible, does not overwrite the original.
- Appeal: student can appeal to coordinator with ID proof.
- Desk verified: phone dead or no internet? Teacher desk, show ID, saved separately as Desk verified.

## Timetable and notifications
- Demo day example only, replace with the real day timetable before a pilot:
  09:00-10:00 SE, 10:00-11:00 CN, 11:00-11:15 Break, 11:15-12:15 TOC, 12:15-13:15 AI, 13:15-14:00 Lunch, 14:00-15:00 RMI, 15:00-16:00 EVS.
- Break 11:00-11:15 and lunch 1:15-2:00 are from the class pattern. Subject order is demo only.
- Start: NOW IS YOUR SE class from 9 am to 10 am.
- End: You have 5 more minutes to mark your SE attendance. Now from 10 am to 11 am, it is your CN class.

## Progress — green, yellow, red
- Counts only closed classes, not a live session.
- Green 85% and above, Yellow 75-84%, Red below 75%.
- These are DEMO thresholds, NOT a verified college rule. Creator can change them.
- Example: 3 out of 5 = 60%, Red, needs 9 classes in a row to reach 85%.

## Two message boxes
- Private student to teacher: categories Class information, Doubt in class, Attendance problem, Problem in class, Other. Teacher sees category, text, time only. No name, phone, or device saved. For hesitant students and CRs.
- Teacher updates to class: types Book checking, Record correction, Class test, Assignment, Other update. Teacher posts, students read. Full app: teacher only can post/delete.

## Made for a real classroom
- No reliable college WiFi. Projector works sometimes, fails sometimes. Wooden broken benches. No smart classroom.
- Needs only teacher phone + student phones. No WiFi, no projector, no new machine, no extra hardware cost.
- Simple UI: short words, big buttons, one action at a time.
- Offline first: saves on the phone, sync later via teacher hotspot if needed. Scan time is the real time, not sync time.
- Low-end friendly: small app, low battery, no heavy face model.

## Cross-platform
- Do not build 3 separate native apps.
- Short term: web app / PWA, opens on Android, iOS, laptop, offline after opening.
- Full version: Flutter, one codebase for Android, iOS, and laptop, with native camera, GPS, Bluetooth, offline storage, notifications.
- iOS note: browser QR scanning is limited on iOS, so code entry is the fallback. A Flutter app fixes camera scanning.

## Build plan
- Phase 1 — Demo: offline HTML demo, explainer video, story video, master PDF. Done.
- Phase 2 — Full app: Flutter app, teacher hotspot sync, phone GPS, phone biometric, background notifications, Excel/PDF report. Next.
- Phase 3 — Pilot: one real class, one week, fix only what breaks in a real room, then expand class by class.

## Honest limits — do not claim these yet
- Room tick in the starter is a GPS stand-in. Real GPS comes in the full app.
- Biometric in the starter uses Demo Confirm on an emulator. Real biometric comes on a real phone.
- Browser demo notifications show while open. Background notifications need the full app.
- Multi-phone sync in the demo is simulated on one phone. Real sync needs teacher hotspot.
- Videos still say PresentProof / face / WiFi inside and need a full rebuild to DETAIN + biometric + no-WiFi.
- Do not claim DETAIN is unique worldwide as a QR product. Its distinction is the combination: Double Loss + receipt + locked sheet + private box + timetable + progress, offline and simple.
