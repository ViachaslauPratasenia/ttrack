import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.sports_tennis,
            size: 50,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 24),

        // App Name
        Text(
          'Spin Track',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),

        // Welcome Text
        Text(
          'Добро пожаловать',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textSecondary,
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
        child: Text(
          'Забыли пароль?',
          style: TextStyle(
            color: AppColors.primary,
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
        Text(
          'Нет аккаунта? ',
          style: TextStyle(
            color: AppColors.textSecondary,
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
          child: Text(
            'Создайте',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

