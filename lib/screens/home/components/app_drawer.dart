import 'package:flutter/material.dart';
import '../../../models/user.dart';

class AppDrawer extends StatelessWidget {
  final User? user;
  final VoidCallback? onThemeChanged;
  final VoidCallback? onLanguageChanged;

  const AppDrawer({
    super.key,
    this.user,
    this.onThemeChanged,
    this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF8B4513),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                user?.gender == 'male' ? Icons.male : Icons.female,
                color: const Color(0xFF8B4513),
                size: 40,
              ),
            ),
            accountName: Text(
              user?.firstName ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user?.level ?? '',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Accueil'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement notifications
            },
          ),
          _buildLanguageListTile(context),
          _buildThemeListTile(context),
          _buildAboutListTile(context),
        ],
      ),
    );
  }

  Widget _buildLanguageListTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: const Text('Changer de langue'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Choisir la langue'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Français'),
                  onTap: () {
                    Navigator.pop(context);
                    onLanguageChanged?.call();
                  },
                ),
                ListTile(
                  title: const Text('Malagasy'),
                  onTap: () {
                    Navigator.pop(context);
                    onLanguageChanged?.call();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeListTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette),
      title: const Text('Changer le thème'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Choisir le thème'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Clair'),
                  onTap: () {
                    Navigator.pop(context);
                    onThemeChanged?.call();
                  },
                ),
                ListTile(
                  title: const Text('Sombre'),
                  onTap: () {
                    Navigator.pop(context);
                    onThemeChanged?.call();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAboutListTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info),
      title: const Text('À propos'),
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('À propos'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Franciscanum Quiz App',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Une application de quiz pour les membres des ordres franciscains séculiers.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
        );
      },
    );
  }
}
