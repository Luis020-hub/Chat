import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  final void Function(AuthFormData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authFormData = AuthFormData();

  void _handleImagePick(File image) {
    _authFormData.image = image;
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    void _showError(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }

    if (_authFormData.image == null && _authFormData.isSignup) {
      return _showError('Image not selected');
    }

    widget.onSubmit(_authFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authFormData.isSignup)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_authFormData.isSignup)
                TextFormField(
                  key: const ValueKey('Name'),
                  initialValue: _authFormData.name,
                  onChanged: (name) => _authFormData.name = name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'You must have at least 5 characters.';
                    } else {
                      return null;
                    }
                  },
                ),
              TextFormField(
                key: const ValueKey('E-mail'),
                initialValue: _authFormData.email,
                onChanged: (email) => _authFormData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'Invalid e-mail.';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                key: const ValueKey('Password'),
                initialValue: _authFormData.password,
                onChanged: (password) => _authFormData.password = password,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.length < 6) {
                    return 'Password must have at least 6 characters.';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text(
                      _authFormData.isLogin
                          ? 'Create a new account'
                          : 'Already have an account?',
                    ),
                    onPressed: () {
                      setState(() {
                        _authFormData.toggleAuthMode();
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_authFormData.isLogin ? 'Login' : 'Sign up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
