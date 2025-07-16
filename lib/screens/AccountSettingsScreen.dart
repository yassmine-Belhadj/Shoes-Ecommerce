import 'package:aftercode/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _faceIdEnabled = false;
  bool _pushNotificationsEnabled = true;
  bool _locationServicesEnabled = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account & Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Explicitly set to black for visibility
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Explicitly set to black
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  context,
                  title: 'Profile',
                  icon: Icons.person_outline,
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSettingsItem(
                  context,
                  title: 'Notification Setting',
                  icon: Icons.notifications_none,
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSettingsItem(
                  context,
                  title: 'Shipping Address',
                  icon: Icons.location_on_outlined,
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildSettingsItem(
                  context,
                  title: 'Payment Info',
                  icon: Icons.credit_card_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildSettingsItem(
              context,
              title: 'Logout',
              icon: Icons.logout,
              isLogout: true,
              onTap: _showLogoutDialog,
              isCard: false,
            ),
            const SizedBox(height: 32),
            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              children: [
                _buildToggleItem(
                  'Enable Face ID For Log In',
                  _faceIdEnabled,
                      (value) => setState(() => _faceIdEnabled = value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildToggleItem(
                  'Enable Push Notifications',
                  _pushNotificationsEnabled,
                      (value) => setState(() => _pushNotificationsEnabled = value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildToggleItem(
                  'Enable Location Services',
                  _locationServicesEnabled,
                      (value) => setState(() => _locationServicesEnabled = value),
                ),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildToggleItem(
                  'Dark Mode',
                  themeProvider.isDarkMode,
                      (value) => themeProvider.toggleTheme(value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsItem(
      BuildContext context, {
        required String title,
        required IconData icon,
        bool isLogout = false,
        bool isCard = true,
        required VoidCallback onTap,
      }) {
    Widget content = ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : Theme.of(context).textTheme.bodyLarge?.color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isLogout ? null : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );

    return isCard ? content : _buildSettingsCard(children: [content]);
  }

  Widget _buildToggleItem(String title, bool value, Function(bool) onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                // Add logout logic here
              },
            ),
          ],
        );
      },
    );
  }
}