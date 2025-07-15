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
    final currentTime = TimeOfDay.now().format(context);
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account & Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                currentTime,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Account & Settings',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            _buildSectionHeader('ACCOUNT'),
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
            _buildSectionHeader('APP SETTINGS'),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.1),
          width: 1,
        ),
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