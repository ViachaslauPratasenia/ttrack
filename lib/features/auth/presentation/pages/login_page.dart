import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),

              // Header with Logo and Welcome Text
              _buildHeader(),

              const SizedBox(height: 48),

              // Login Form
              const LoginForm(),

              const SizedBox(height: 24),

              // Forgot Password Link
              _buildForgotPasswordLink(context),

              const SizedBox(height: 32),

              // Sign Up Link
              _buildSignUpLink(context),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App Logo (можно заменить на Image.asset когда будет логотип)
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.sports_tennis,
            size: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),

        // App Name
        const Text(
          'Spin Track',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),

        // Welcome Text
        const Text(
          'Добро пожаловать',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Navigate to forgot password screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Функция восстановления пароля в разработке'),
            ),
          );
        },
        child: const Text(
          'Забыли пароль?',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Нет аккаунта? ',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to sign up screen
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Переход на экран регистрации'),
              ),
            );
          },
          child: const Text(
            'Создайте',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

