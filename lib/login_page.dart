import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_page.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await supabase.auth.signUp(
                          phone: phoneController.text.isEmpty
                              ? null
                              : phoneController.text,
                          email: emailController.text.isEmpty
                              ? null
                              : emailController.text,
                          password: passwordController.text,
                          saveSession: false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Success')));
                      } catch (e, st) {
                        log('$e $st');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('$e')));
                      }
                    },
                    child: const Text('Register'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await supabase.auth.signInWithPassword(
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Success')));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomePage();
                        }));
                      } catch (e, st) {
                        log('$e $st');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('$e')));
                      }
                    },
                    child: const Text('Login'),
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
