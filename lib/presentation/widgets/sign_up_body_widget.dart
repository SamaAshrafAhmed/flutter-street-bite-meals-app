import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/core/utils/validators.dart';
import 'auth_footer_widget.dart';
import 'auth_listener_widget.dart';
import 'auth_text_field_widget.dart';
import 'password_field_widget.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../core/utils/localization.dart';

class SignUpBodyWidget extends StatefulWidget {
  const SignUpBodyWidget({super.key});

  @override
  State<SignUpBodyWidget> createState() => _SignUpBodyWidgetState();
}

class _SignUpBodyWidgetState extends State<SignUpBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthListenerWidget(
      replaceAll: true,
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.signUpTitle)),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.restaurant_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        context.l10n.appName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.l10n.signUpSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AuthTextFieldWidget(
                    controller: _nameController,
                    label: context.l10n.nameLabel,
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    validator: (v) =>
                        Validators.required(v, context.l10n.nameRequired),
                  ),
                  const SizedBox(height: 16),
                  AuthTextFieldWidget(
                    controller: _emailController,
                    label: context.l10n.emailLabel,
                    prefixIcon: const Icon(Icons.alternate_email_rounded),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validators.email(value, context.l10n),
                  ),
                  const SizedBox(height: 16),
                  PasswordFieldWidget(
                    controller: _passwordController,
                    label: context.l10n.passwordLabel,
                    validator: (value) =>
                        Validators.password(value, context.l10n),
                  ),
                  const SizedBox(height: 16),
                  PasswordFieldWidget(
                    controller: _confirmController,
                    label: context.l10n.confirmPasswordLabel,
                    validator: (v) => Validators.confirmPassword(
                      v,
                      _passwordController.text,
                      context.l10n,
                    ),
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: _submit,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.person_add_alt_1_rounded),
                            const SizedBox(width: 8),
                            Text(context.l10n.signUpButton),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  AuthFooterWidget(
                    questionText: context.l10n.haveAccount,
                    linkText: context.l10n.loginLink,
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
