import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_task_web/generated/l10n.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String lang)? onSelectedLanguages;
  final String? currentLang;
  final void Function(String searchQuery)? onSearch;

  const CustomAppBar({
    super.key,
    this.currentLang,
    this.onSelectedLanguages,
     this.onSearch,
  });

  void _changeLanguage(String lang) {
    onSelectedLanguages!(lang);
  }

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/catalog');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildWideAppBar(context);
              } else {
                return _buildNarrowAppBar(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWideAppBar(BuildContext context) {
    return Row(
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text(
            S.of(context).colect,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/catalog');
          },
          child: Text(
            S.of(context).catalog,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: S.of(context).enter,
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xFFE0E0E0),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        TextButton(
          onPressed: () {
            _changeLanguage('ru');
          },
          child: Text(
            'RU',
            style: TextStyle(
              color: currentLang == 'ru' ? Colors.blue : Colors.black,
            ),
          ),
        ),
        const Text(' | ', style: TextStyle(color: Colors.black)),
        TextButton(
          onPressed: () {
            _changeLanguage('en');
          },
          child: Text(
            'EN',
            style: TextStyle(
              color: currentLang == 'en' ? Colors.blue : Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushNamed('/cart');
          },
        ),
        const SizedBox(width: 10.0),
        FirebaseAuth.instance.currentUser != null
            ? TextButton(
                onPressed: () {
                  _logout(context);
                },
                child: Text(
                  S.of(context).logout,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            : TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: Text(
                  S.of(context).login,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
      ],
    );
  }

  Widget _buildNarrowAppBar(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text(
            S.of(context).colect,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/catalog');
          },
          child: Text(
            S.of(context).catalog,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 150,
          child: TextField(
            onChanged: onSearch,
            decoration: InputDecoration(
              hintText: S.of(context).enter,
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xFFE0E0E0),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        TextButton(
          onPressed: () {
            _changeLanguage('ru');
          },
          child: Text(
            'RU',
            style: TextStyle(
              color: currentLang == 'ru' ? Colors.blue : Colors.black,
            ),
          ),
        ),
        const Text(' | ', style: TextStyle(color: Colors.black)),
        TextButton(
          onPressed: () {
            _changeLanguage('en');
          },
          child: Text(
            'EN',
            style: TextStyle(
              color: currentLang == 'en' ? Colors.blue : Colors.black,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushNamed('/cart');
          },
        ),
        FirebaseAuth.instance.currentUser != null
            ? TextButton(
                onPressed: () {
                  _logout(context);
                },
                child: Text(
                  S.of(context).logout,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            : TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: Text(
                  S.of(context).login,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
