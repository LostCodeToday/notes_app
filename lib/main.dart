import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/theme_settings_screen.dart';
import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/daily_tasks_screen.dart';
import 'services/note_service.dart';
import 'services/task_service.dart';
import 'utils/theme_manager.dart';
import 'package:provider/provider.dart';

// Убедитесь, что в pubspec.yaml есть:
// dependencies:
//   table_calendar: ^3.0.9
//   provider: ^6.0.0
//   date_picker_timeline: ^1.2.3

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteService()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => TaskService()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Notes App',
            theme: themeManager.getTheme(context),
            themeMode: themeManager.themeMode,
            home: NotesPlannerHome(),
          );
        },
      ),
    );
  }
}

class NotesPlannerHome extends StatefulWidget {
  @override
  _NotesPlannerHomeState createState() => _NotesPlannerHomeState();
}

class _NotesPlannerHomeState extends State<NotesPlannerHome> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const CalendarScreen(),
    const DailyTasksScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Notes Planner'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 80.0,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blue),
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            ListTile(
              title: const Text('Theme'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ThemeSettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}