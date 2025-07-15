import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTime = TimeOfDay.now().format(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
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
            const SizedBox(height: 24),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 56,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/women/65.jpg',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _showChangePhotoOptions(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Safa Wanen',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'safawanene@gmail.com',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileRow(
                      context,
                      label: 'Full Name',
                      value: 'Safa Wanen',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, thickness: 0.5),
                    ),
                    _buildProfileRow(
                      context,
                      label: 'Username',
                      value: 'safawanene',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, thickness: 0.5),
                    ),
                    _buildProfileRow(
                      context,
                      label: 'Email Address',
                      value: 'safawanene@gmail.com',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(height: 1, thickness: 0.5),
                    ),
                    _buildProfileRow(
                      context,
                      label: 'Password',
                      value: '••••••••',
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => print('Edit Profile button pressed'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileRow(
      BuildContext context, {
        required String label,
        required String value,
        bool isPassword = false,
      }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isPassword
                  ? Colors.grey
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        if (!isPassword)
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
      ],
    );
  }

  void _showChangePhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement camera functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement gallery functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}