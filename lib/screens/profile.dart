import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: currentUser != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: constraints.maxWidth < 600 ? 50 : 100,
                          backgroundImage: currentUser.photoURL != null
                              ? NetworkImage(currentUser.photoURL!)
                              : null,
                          child: currentUser.photoURL == null
                              ? Icon(
                                  Icons.person,
                                  size: constraints.maxWidth < 600 ? 50 : 100,
                                )
                              : null,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Email: ${currentUser.email}',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 600 ? 20 : 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Имя: ${currentUser.displayName ?? 'Не указано'}',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 600 ? 20 : 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(context, '/catalog');
                          },
                          child: const Text('Выйти'),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Вы не вошли в аккаунт',
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 600 ? 20 : 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text('Войти'),
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
