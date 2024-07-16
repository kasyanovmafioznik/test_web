// ignore_for_file: deprecated_member_use, unused_local_variable, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_task_web/generated/l10n.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/catalog');
  }

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;
    final double iconSize = isWideScreen ? 32 : 26;
    final double fontSize = isWideScreen ? 20 : 18;
    final double drawerHeaderHeight = isWideScreen ? 200 : 160;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.store,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Text(
                    'Fashion Store',
                    style: GoogleFonts.montserrat(
                      fontSize: isWideScreen ? 28 : 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.category,
              size: iconSize,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              S.of(context).catalog,
              style: GoogleFonts.montserrat(
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/catalog');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              size: iconSize,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              S.of(context).garbage,
              style: GoogleFonts.montserrat(
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/cart');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: iconSize,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              S.of(context).profile,
              style: GoogleFonts.montserrat(
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: iconSize,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              S.of(context).setings,
              style: GoogleFonts.montserrat(
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: iconSize,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              S.of(context).exit,
              style: GoogleFonts.montserrat(
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }
}
