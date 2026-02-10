import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketing_app/theme/background_scaffold.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isLogin = true;

  void _submit() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();

      try {
        if (_isLogin) {
          final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail,
            password: _enteredPassword,
          );
          print(userCredential);
        } else {
          final userCredential = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail,
            password: _enteredPassword,
          );
          print(userCredential);
        }
      } on FirebaseAuthException catch (error) {
        if (error.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (error.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Example content - in a real app, this would be your login/register UI
              Container(
                margin: const EdgeInsets.all(20),
                width: 140,
                height: 100,
                child: Image.asset('assets/images/coco_logo.png'),
              ),

              Card(
                color: Colors.transparent,
                margin: const EdgeInsets.all(20),

                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFFE98A57),
                          ),
                          child: Text(_isLogin ? 'Login' : 'Sign Up'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF45AE67),
                          ),
                          child: Text(
                            _isLogin
                                ? 'Create new account'
                                : 'I already have an account',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
