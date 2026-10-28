// DETAIN - Digital Education Tracking Attendance Identification Network
// One Student. One Phone. One Chance.
// FREE starter: Flutter, offline storage, no server, no paid service.
// Prepared by Zahid Ahmed. Watermark: ZAHID AHMED on every screen.
//
// How to run (see README.md):
//   flutter pub get
//   flutter run
//
// Rules locked in this starter:
// - One QR/code per class. Code dies when the teacher closes the session.
// - Room check: in this starter a tick box stands in for phone GPS.
//   Full app: replace the tick with geolocator GPS, no college WiFi needed.
// - Phone biometric: fingerprint / phone Face ID via local_auth.
//   No face photo is stored by the app. On an emulator, use Demo Confirm.
// - Double Loss Rule: a confirmed proxy attempt costs the attempter
//   his own attendance for that class. A failed scan is only a retry.
// - Receipt, locked sheet, private messages (no sender saved), teacher updates.
// - Progress zones are DEMO thresholds only, not a verified college rule:
//   Green 85%+, Yellow 75-84%, Red below 75%.

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const DetainApp());

const students = [
  'Zahid Ahmed',
  'Arjun Kumar',
  'Rohan Sharma',
  'Priya Nair',
  'Kiran Rao',
  'Sneha Patel',
];

const subjects = ['SE - BCS501', 'CN - BCS502', 'TOC - BCS503', 'AI - BCS515B', 'RMI - BRMK557', 'EVS - BCS508'];
const messageCategories = ['Class information', 'Doubt in class', 'Attendance problem', 'Problem in class', 'Other'];
const updateTypes = ['Book checking', 'Record correction', 'Class test', 'Assignment', 'Other update'];

class DetainApp extends StatelessWidget {
  const DetainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DETAIN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A1226)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

/// Light diagonal watermark, behind the content, on every screen.
class Watermark extends StatelessWidget {
  const Watermark({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Center(
        child: Opacity(
          opacity: 0.07,
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(
              'ZAHID AHMED',
              style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  SharedPreferences? _prefs;

  // Session
  String _subject = subjects[0];
  String _room = 'Room 304';
  String _code = '';
  String _sessionId = '';
  bool _sessionActive = false;
  bool _sessionClosed = false;

  // Records: student -> 'Present' | 'Desk verified' | 'Blocked'
  Map<String, String> _records = {};
  Map<String, String> _receipts = {};
  List<String> _flags = [];

  // History: one entry per closed session: {subject, per: {student: bool}}
  List<Map<String, dynamic>> _history = [];
  List<Map<String, dynamic>> _messages = [];
  List<Map<String, dynamic>> _updates = [];

  String _timetable = '09:00-10:00 SE - BCS501\n10:00-11:00 CN - BCS502\n11:00-11:15 Break\n11:15-12:15 TOC - BCS503\n12:15-13:15 AI - BCS515B\n13:15-14:00 Lunch\n14:00-15:00 RMI - BRMK557\n15:00-16:00 EVS - BCS508';

  // Student form
  String _owner = students[0];
  String _target = students[0];
  String _enteredCode = '';
  bool _roomTick = false;
  bool _biometricOk = false;

  String _messageCategory = messageCategories[0];
  String _messageText = '';
  String _updateType = updateTypes[0];
  String _updateTitle = '';
  String _updateText = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs!.getString('detain_state_v1');
    if (raw == null) return;
    try {
      final data = jsonDecode(raw) as Map<String, dynamic>;
      setState(() {
        _subject = data['subject'] ?? subjects[0];
        _room = data['room'] ?? 'Room 304';
        _code = data['code'] ?? '';
        _sessionId = data['sessionId'] ?? '';
        _sessionActive = data['sessionActive'] ?? false;
        _sessionClosed = data['sessionClosed'] ?? false;
        _records = Map<String, String>.from(data['records'] ?? {});
        _receipts = Map<String, String>.from(data['receipts'] ?? {});
        _flags = List<String>.from(data['flags'] ?? []);
        _history = List<Map<String, dynamic>>.from((data['history'] ?? []).map((e) => Map<String, dynamic>.from(e)));
        _messages = List<Map<String, dynamic>>.from((data['messages'] ?? []).map((e) => Map<String, dynamic>.from(e)));
        _updates = List<Map<String, dynamic>>.from((data['updates'] ?? []).map((e) => Map<String, dynamic>.from(e)));
        _timetable = data['timetable'] ?? _timetable;
      });
    } catch (_) {
      // Corrupt saved state: start fresh, do not crash.
    }
  }

  Future<void> _save() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setString('detain_state_v1', jsonEncode({
      'subject': _subject,
      'room': _room,
      'code': _code,
      'sessionId': _sessionId,
      'sessionActive': _sessionActive,
      'sessionClosed': _sessionClosed,
      'records': _records,
      'receipts': _receipts,
      'flags': _flags,
      'history': _history,
      'messages': _messages,
      'updates': _updates,
      'timetable': _timetable,
    }));
  }

  String _code6() => (100000 + Random().nextInt(900000)).toString();

  String _receiptFor(String name) {
    var h = 0;
    for (final c in (name + _sessionId).codeUnits) {
      h = (h * 31 + c) % 100000;
    }
    return 'DT-${h.toString().padLeft(5, '0')}';
  }

  int _properCount() => students.where((n) => _records[n] == 'Present').length;

  void _startSession() {
    setState(() {
      _code = _code6();
      _sessionId = 'DT-${DateTime.now().toIso8601String().substring(0, 10)}-$_code';
      _sessionActive = true;
      _sessionClosed = false;
      _records = {};
      _receipts = {};
      _flags = [];
      _biometricOk = false;
    });
    _save();
  }

  void _closeSession() {
    if (!_sessionActive) return;
    final per = <String, bool>{};
    for (final n in students) {
      per[n] = _records[n] == 'Present' || _records[n] == 'Desk verified';
    }
    setState(() {
      _history.add({'subject': _subject, 'per': per});
      _sessionActive = false;
      _sessionClosed = true;
    });
    _save();
  }

  void _resetAll() {
    setState(() {
      _sessionActive = false;
      _sessionClosed = false;
      _code = '';
      _sessionId = '';
      _records = {};
      _receipts = {};
      _flags = [];
      _history = [];
      _messages = [];
      _updates = [];
    });
    _save();
  }

  Future<void> _doBiometric() async {
    try {
      final auth = LocalAuthentication();
      final can = await auth.canCheckBiometrics;
      if (!can) throw Exception('No biometric on this device');
      final ok = await auth.authenticate(
        localizedReason: 'Confirm you are in $_room for $_subject',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (ok) setState(() => _biometricOk = true);
    } catch (_) {
      // Emulator / no fingerprint: offer a demo confirm, labelled as demo.
      if (!mounted) return;
      final demo = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Biometric not available here'),
          content: const Text('This device or emulator has no fingerprint set up. Use Demo Confirm for testing only. On a real phone, fingerprint / Face ID must pass.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
            ElevatedButton(onPressed: () => Navigator.pop(c, true), child: const Text('Demo Confirm')),
          ],
        ),
      );
      if (demo == true) setState(() => _biometricOk = true);
    }
  }

  void _markAttendance() {
    if (!_sessionActive) {
      _snack('No session is live. Teacher must start a session first.');
      return;
    }
    if (_enteredCode.trim() != _code) {
      _snack('Wrong code. Enter the code for this class only.');
      return;
    }
    if (!_roomTick) {
      _snack('Tick "I am in $_room" first. In the full app this is phone GPS.');
      return;
    }
    if (!_biometricOk) {
      _snack('Confirm with phone biometric first.');
      return;
    }
    if (_records[_target] == 'Present') {
      _snack('$_target is already marked present for this class.');
      return;
    }
    // Double Loss Rule: confirmed proxy = owner != target.
    if (_owner != _target) {
      setState(() {
        _records[_target] = 'Blocked';
        _records[_owner] = 'Blocked';
        _flags.add('$_owner tried for $_target');
      });
      _save();
      _snack('Proxy blocked. Double Loss: $_owner also loses this class.');
      return;
    }
    setState(() {
      _records[_target] = 'Present';
      _receipts[_target] = _receiptFor(_target);
    });
    _save();
    _snack('Present! Receipt: ${_receipts[_target]}');
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final screens = [_teacherScreen(), _studentScreen(), _progressScreen(), _messagesScreen(), _updatesScreen()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIN'),
        backgroundColor: const Color(0xFF0A1226),
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetAll, tooltip: 'Reset demo'),
        ],
      ),
      body: Stack(children: [const Watermark(), screens[_tab]]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tab,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Teacher'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Student'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.announcement), label: 'Updates'),
        ],
      ),
    );
  }

  Widget _wrap(List<Widget> children) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }

  Widget _teacherScreen() {
    return _wrap([
      const Text('Made for a real classroom, not a smart classroom', style: TextStyle(fontWeight: FontWeight.bold)),
      const Text('No college WiFi needed. No projector needed. No new machine to buy.'),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: _subject,
        items: subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => _subject = v!),
        decoration: const InputDecoration(labelText: 'Subject'),
      ),
      TextField(
        controller: TextEditingController(text: _room),
        onChanged: (v) => _room = v,
        decoration: const InputDecoration(labelText: 'Room'),
      ),
      const SizedBox(height: 12),
      ElevatedButton(onPressed: _startSession, child: const Text('Start session - one QR / code per class')),
      if (_sessionActive) ...[
        const SizedBox(height: 16),
        const Text('One QR for this whole class. No projector? Say the code aloud, or write it on the board.', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Center(child: QrImageView(data: 'DETAIN|$_sessionId|$_room|$_code', version: QrVersions.auto, size: 200)),
        Center(child: Text('Code: $_code', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
        const SizedBox(height: 8),
        Text('Properly marked: $_properCount() / ${students.length}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text('Blocked attempts: ${_flags.length}'),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: _closeSession, child: const Text('Close session - lock sheet')),
      ],
      if (_sessionClosed) ...[
        const SizedBox(height: 12),
        const Text('Session CLOSED. Sheet is locked. No silent edits.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        ...students.map((n) => ListTile(title: Text(n), trailing: Text(_records[n] ?? 'Not yet marked'))),
        if (_flags.isNotEmpty) Text('Flags (teacher only): ${_flags.join(' | ')}'),
      ],
      const SizedBox(height: 20),
      const Text('Timetable (creator provides it)', style: TextStyle(fontWeight: FontWeight.bold)),
      TextField(
        controller: TextEditingController(text: _timetable),
        maxLines: 8,
        onChanged: (v) => _timetable = v,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () {
          _save();
          _snack('NOW IS YOUR SE class from 9 am to 10 am');
        },
        child: const Text('Test 9 am notification'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () => _snack('You have 5 more minutes to mark SE attendance. Now from 10 am to 11 am, it is CN class.'),
        child: const Text('Test 10 am grace + next class'),
      ),
    ]);
  }

  Widget _studentScreen() {
    return _wrap([
      const Text('Warning: Try proxy, lose your own attendance. This is the Double Loss Rule.', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
      DropdownButtonFormField<String>(
        value: _owner,
        items: students.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => _owner = v!),
        decoration: const InputDecoration(labelText: 'Phone owner (you)'),
      ),
      DropdownButtonFormField<String>(
        value: _target,
        items: students.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => _target = v!),
        decoration: const InputDecoration(labelText: 'Mark attendance for'),
      ),
      CheckboxListTile(
        value: _roomTick,
        onChanged: (v) => setState(() => _roomTick = v ?? false),
        title: Text('I am in $_room (GPS stand-in in this starter)'),
      ),
      TextField(
        onChanged: (v) => _enteredCode = v,
        decoration: const InputDecoration(labelText: 'Enter class code (or scan QR in full app)'),
        keyboardType: TextInputType.number,
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: _doBiometric,
        child: Text(_biometricOk ? 'Biometric confirmed ✓' : 'Confirm with phone biometric'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(onPressed: _markAttendance, child: const Text('Mark my attendance')),
      if (_receipts[_target] != null) ...[
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text('Receipt for $_target\nSubject: $_subject\nRoom: $_room\nReceipt code: ${_receipts[_target]}'),
          ),
        ),
      ],
      const SizedBox(height: 12),
      const Text('Desk verified: phone dead or no internet? Go to the teacher desk with ID. Teacher marks Desk verified separately.'),
    ]);
  }

  Widget _progressScreen() {
    return _wrap([
      const Text('Progress counts only closed classes, not a live session.', style: TextStyle(fontWeight: FontWeight.bold)),
      const Text('Zones (demo only, not a college rule): Green 85%+, Yellow 75-84%, Red below 75%.'),
      const SizedBox(height: 12),
      ...students.map((n) {
        var held = 0;
        var attended = 0;
        for (final h in _history) {
          held++;
          if (h['per'][n] == true) attended++;
        }
        final pct = held == 0 ? 0 : (attended * 100 ~/ held);
        final zone = pct >= 85 ? 'GREEN' : (pct >= 75 ? 'YELLOW' : 'RED');
        final color = pct >= 85 ? Colors.green : (pct >= 75 ? Colors.orange : Colors.red);
        return ListTile(title: Text(n), subtitle: Text('$attended / $held closed classes'), trailing: Text('$pct% $zone', style: TextStyle(color: color, fontWeight: FontWeight.bold)));
      }),
    ]);
  }

  Widget _messagesScreen() {
    return _wrap([
      const Text('Private message to teacher', style: TextStyle(fontWeight: FontWeight.bold)),
      const Text('Teacher sees ONLY category, text, and time. No name, no phone, no device is saved.'),
      DropdownButtonFormField<String>(
        value: _messageCategory,
        items: messageCategories.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => _messageCategory = v!),
        decoration: const InputDecoration(labelText: 'Category'),
      ),
      TextField(onChanged: (v) => _messageText = v, decoration: const InputDecoration(labelText: 'Message'), maxLines: 3),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () {
          if (_messageText.trim().isEmpty) return;
          setState(() {
            _messages.add({'category': _messageCategory, 'text': _messageText.trim(), 'time': DateTime.now().toIso8601String().substring(11, 16)});
            _messageText = '';
          });
          _save();
          _snack('Message sent privately.');
        },
        child: const Text('Send privately'),
      ),
      const SizedBox(height: 12),
      const Text('Teacher view (demo only - full app: teacher only)', style: TextStyle(fontWeight: FontWeight.bold)),
      ..._messages.map((m) => ListTile(title: Text(m['text']), subtitle: Text('${m['category']} • ${m['time']}'))),
    ]);
  }

  Widget _updatesScreen() {
    return _wrap([
      const Text('Teacher updates for the class', style: TextStyle(fontWeight: FontWeight.bold)),
      DropdownButtonFormField<String>(
        value: _updateType,
        items: updateTypes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => _updateType = v!),
        decoration: const InputDecoration(labelText: 'Type'),
      ),
      TextField(onChanged: (v) => _updateTitle = v, decoration: const InputDecoration(labelText: 'Title')),
      TextField(onChanged: (v) => _updateText = v, decoration: const InputDecoration(labelText: 'Details'), maxLines: 3),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: () {
          if (_updateTitle.trim().isEmpty) return;
          setState(() {
            _updates.add({'type': _updateType, 'title': _updateTitle.trim(), 'text': _updateText.trim()});
            _updateTitle = '';
            _updateText = '';
          });
          _save();
        },
        child: const Text('Post update (teacher only in full app)'),
      ),
      const SizedBox(height: 12),
      ..._updates.map((u) => ListTile(title: Text(u['title']), subtitle: Text('${u['type']} • ${u['text']}'))),
    ]);
  }
}
