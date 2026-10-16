import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/presentation/cubit/auth_cubit.dart';
import 'package:street_bite/presentation/cubit/auth_state.dart';
import 'package:street_bite/presentation/cubit/cart_cubit.dart';
import 'package:street_bite/presentation/screens/login_screen.dart';
import 'package:street_bite/core/utils/localization.dart';
import '../../core/dependency_injection/injection.dart';
import '../../core/theming/cubit/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: const ProfileBodyWidget(),
    );
  }
}

class ProfileBodyWidget extends StatelessWidget {
  const ProfileBodyWidget({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.logoutConfirmTitle),
        content: Text(context.l10n.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthCubit>().logout();
            },
            child: Text(
              context.l10n.confirm,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          context.read<CartCubit>().clearAll();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            context.l10n.profileTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),

          // Theme selector
          Text(
            context.l10n.themeLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) {
              return SegmentedButton<ThemeMode>(
                segments: [
                  ButtonSegment(
                    value: ThemeMode.light,
                    label: Text(context.l10n.themeLight),
                    icon: const Icon(Icons.light_mode_outlined),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    label: Text(context.l10n.themeSystem),
                    icon: const Icon(Icons.settings_suggest_outlined),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    label: Text(context.l10n.themeDark),
                    icon: const Icon(Icons.dark_mode_outlined),
                  ),
                ],
                selected: {mode},
                onSelectionChanged: (selected) =>
                    context.read<ThemeCubit>().setTheme(selected.first),
              );
            },
          ),
          const SizedBox(height: 32),

          // Language selector
          Text(
            context.l10n.languageLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'en', label: Text(context.l10n.languageEnglish)),
              ButtonSegment(value: 'ar', label: Text(context.l10n.languageArabic)),
            ],
            selected: {localeNotifier.value.languageCode},
            onSelectionChanged: (selected) =>
                context.setAppLocale(Locale(selected.first)),
          ),
          const SizedBox(height: 48),

          // Logout
          OutlinedButton.icon(
            onPressed: () => _showLogoutDialog(context),
            icon: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).colorScheme.error,
            ),
            label: Text(
              context.l10n.logoutButton,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).colorScheme.error),
              minimumSize: const Size(double.infinity, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
