// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';
  String _name = '';
  String _photoURL = '';
  String _errorMessage = '';
  bool _isLoginMode = true;

  void _switchAuthMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _errorMessage = '';
      _email = '';
      _password = '';
      _name = '';
      _photoURL = '';
    });
  }

  Future<void> _signInWithEmailAndPassword() async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      try {
        if (_isLoginMode) {
          final userCredential = await _auth.signInWithEmailAndPassword(
            email: _email.trim(),
            password: _password,
          );
          Navigator.pushReplacementNamed(context, '/catalog');
        } else {
          final userCredential = await _auth.createUserWithEmailAndPassword(
            email: _email.trim(),
            password: _password,
          );

          await userCredential.user?.updateDisplayName(_name);
          await userCredential.user?.updatePhotoURL(_photoURL);

          Navigator.pushReplacementNamed(context, '/catalog');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Окно авторизации'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth < 600 ? constraints.maxWidth * 0.9 : 400,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Пароль',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите пароль';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      if (!_isLoginMode) ...[
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Имя',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите имя';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'URL фото',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите URL фото';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _photoURL = value!;
                          },
                        ),
                      ],
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: _signInWithEmailAndPassword,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: Text(_isLoginMode ? 'Вход' : 'Зарегистрироваться'),
                      ),
                      TextButton(
                        onPressed: _switchAuthMode,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        child: Text(
                          _isLoginMode ? 'Перейти на регистрацию' : 'Перейти на вход',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
