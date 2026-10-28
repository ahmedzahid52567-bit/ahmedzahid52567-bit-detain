# DETAIN — QUICK MASTER PROMPT
# Copy this whole prompt into Antigravity. It is short on purpose.

Build DETAIN as a final project, not a demo. Do not mention the word "demo" anywhere in the app, website, or files.

Project: DETAIN — Digital Education Tracking Attendance Identification Network.
Tagline: One Student. One Phone. One Chance.
Prepared by Zahid Ahmed. Put a light diagonal ZAHID AHMED watermark on every screen.

What DETAIN does:
Teacher starts one session with one QR/code for the whole class. Student enters the code or scans the QR, with room GPS, one phone per student, and phone fingerprint confirmation. Teacher phone shows live properly-marked count. Double Loss Rule: if a student tries to mark for another student, the target gets no mark and the attempter also loses his own attendance for that class. Student gets a receipt with time, room, subject, and code. Teacher closes the session and the sheet locks, with no silent edits. Also: timetable notifications, progress Green/Yellow/Red, private student message box (teacher sees category, text, time only, no name/phone/device), and teacher updates box.

Rules:
1. Keep every screen and every style in separate files. No one big file. No inline CSS everywhere.
2. FREE ONLY. No paid server, no paid database, no paid OTP. Offline first, no college WiFi needed.
3. NO face photo, ever. Biometric is only the phone fingerprint / Face ID, yes or no only.
4. Make GPS, fingerprint, and camera QR scan REAL first. Do not just delete the word "demo" while keeping test buttons or stand-ins.
5. Login first screen: Phone number (10 digits, numbers only), USN, Role: Teacher or Student. Checkbox: Save my details on this phone. If ticked, next open must auto-fill or auto-login from phone storage only. If not ticked, ask every time. Keep phone numbers on the phone only for the pilot.
6. Simple words, big buttons, one action at a time.

Deliverables I need from you, in this order:
1. Fix all build errors. Run flutter pub get and flutter run, and confirm it opens.
2. Build the web version and DEPLOY it to a permanent free public URL (GitHub Pages or Netlify). A localhost link like http://127.0.0.1:8080/ is NOT enough — that works only on my PC. Give me the real public URL that works on a teacher's phone.
3. Build the Android APK with flutter build apk --release. Tell me the exact APK file path, and upload it to Google Drive or GitHub Releases and give me that download link.
4. Test and report, pass or fail for each: Teacher start, Student mark with receipt, Arjun tries for Rohan = both Blocked, Rohan marks himself later = Present, Wrong code = retry only, Close session = sheet locks, Login with phone + USN works, Save Details remembers after closing the app, Public URL opens on another phone.

When you finish, give me only: the public URL, the APK download link, what passed, what failed, and the next 3 steps. Do not add new features.
