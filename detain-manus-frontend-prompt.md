# DETAIN — Prompt to give Manus for FRONTEND LOOK ONLY
# Copy the prompt below into Manus. Upload the files listed under "What to upload" first.

## What to upload to Manus first (give these as input)
1. detain-master-notes.pdf — the full DETAIN idea, in simple words.
2. DETAIN_SPEC.md — or copy the spec text, if Manus does not accept PDF.
3. detain-offline-demo.html — the current working look, so Manus can improve it, not start blind.
4. If you have a colour or app you like, add one screenshot of it and say "I like this style" — Manus copies style much better from a picture than from words.

If you upload nothing, Manus will invent a random look. If you upload the spec + demo, it will keep your DETAIN rules and screens.

---

## COPY THIS PROMPT INTO MANUS:

Design only the frontend look for my DETAIN app. Do NOT build backend, database, or login logic. Frontend look only.

Project: DETAIN — Digital Education Tracking Attendance Identification Network.
Tagline: One Student. One Phone. One Chance.
Prepared by Zahid Ahmed.

What DETAIN is, in one line: An offline college attendance app that proves a student was in the room, with one QR/code per class, live teacher count, Double Loss Rule for proxy, student receipt, and locked sheet.

Screens I need, in order:
1. Login — Phone number, USN, Role: Teacher or Student, checkbox: Save my details on this phone, big Login button.
2. Teacher — Subject, Room 304, Start session button, QR + 6-digit code in large text, live count "Properly marked: X / 6", Close session button, final report.
3. Student — Phone owner, Mark for, "I am in Room 304" tick, code entry, biometric button, Mark attendance button, receipt card.
4. Progress — Green / Yellow / Red zones, percentage, attended / held classes.
5. Messages — Private message to teacher, category dropdown, message box, Send privately button. Note: teacher sees only category, text, time.
6. Updates — Teacher updates list, with types: Book checking, Record correction, Class test, Assignment, Other.

Look and style I want:
- Simple, clean, professional, for a real Indian college classroom, not a smart classroom.
- Dark blue #0A1226 for headers, teal green #0E9F7A for main buttons, white background, dark text.
- Big buttons, short words, one action at a time. A teacher must understand it in 2 minutes.
- Mobile-first design, for Android phones first, then laptop.
- Light diagonal ZAHID AHMED watermark on every screen, behind the content, never blocking a button.
- No word "demo" anywhere. This is a final project.
- No face photo, no complex English, no long forms.

What to deliver to me:
1. One HTML/CSS preview I can open in a browser, with all 6 screens, clickable tabs, and separate CSS files for each screen — not one big inline style file.
2. A short design note, in simple words: colours used, font used, button sizes, and why this look fits a low-end phone and a real classroom.
3. The same look as Flutter UI code, in separate files for each screen, so I can paste it into my Flutter project in Antigravity later. If you cannot do Flutter code in this task, give me the HTML/CSS first and say clearly what is missing for Flutter.

Do not change my features, do not add new features, do not remove Double Loss Rule, receipt, locked sheet, or watermark. Only improve the look.
