import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'en';
  bool _receiveNotifications = true;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _changeLanguage(String? language) {
    setState(() {
      _selectedLanguage = language!;
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _receiveNotifications = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Тема',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SwitchListTile(
                    title: const Text('Темная тема'),
                    value: _isDarkMode,
                    onChanged: _toggleDarkMode,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Язык',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: _selectedLanguage,
                    onChanged: _changeLanguage,
                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'ru',
                        child: Text('Русский'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Уведомления',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SwitchListTile(
                    title: const Text('Получать уведомления'),
                    value: _receiveNotifications,
                    onChanged: _toggleNotifications,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
