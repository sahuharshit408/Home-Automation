import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;
  String _username = 'User';
  String _selectedTheme = 'Light';

  void _changeTheme(String? newTheme) {
    if (newTheme != null) {
      setState(() {
        _selectedTheme = newTheme;
        // Implement theme change logic here
      });
    }
  }

  void _changeUsername() async {
    String? newUsername = await showDialog(
      context: context,
      builder: (context) {
        String? tempUsername = _username;
        return AlertDialog(
          title: const Text('Change Username'),
          content: TextField(
            onChanged: (value) {
              tempUsername = value;
            },
            decoration: const InputDecoration(hintText: "Enter new username"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(tempUsername);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (newUsername != null && newUsername.isNotEmpty) {
      setState(() {
        _username = newUsername;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/user.png'), // Replace with your profile picture asset
                ),
                const SizedBox(height: 8),
                Text(
                  _username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: _changeUsername,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Edit Profile', style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSettingsCard(
            title: 'Theme',
            child: ListTile(
              title: const Text('Change Theme'),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedTheme,
                  items: ['Light', 'Dark'].map((theme) {
                    return DropdownMenuItem<String>(
                      value: theme,
                      child: Text(theme),
                    );
                  }).toList(),
                  onChanged: _changeTheme,
                  dropdownColor: Colors.grey[800],
                  style: const TextStyle(color: Colors.white),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                ),
              ),
            ),
          ),
          _buildSettingsCard(
            title: 'Notifications',
            child: SwitchListTile(
              title: const Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
          ),
          _buildSettingsCard(
            title: 'Add a Device',
            child: ListTile(
              title: const Text('Add New Device'),
              subtitle: const Text('Tap to add a new device'),
              onTap: () {
                // Implement add device logic here
              },
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Implement logout logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Logout', style: TextStyle(fontSize: 16 , color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required String title, required Widget child}) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
