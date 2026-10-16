import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite/presentation/screens/main_layout_screen.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../core/utils/localization.dart';

class AuthListenerWidget extends StatelessWidget {
  final Widget child;
  final bool replaceAll;

  const AuthListenerWidget({
    super.key,
    required this.child,
    this.replaceAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          if (replaceAll) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
              (route) => false,
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
            );
          }
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_message(context, state.message)),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: child,
    );
  }

  String _message(BuildContext context, String key) {
    return switch (key) {
      'errorUserNotFound' => context.l10n.errorUserNotFound,
      'errorWrongPassword' => context.l10n.errorWrongPassword,
      'errorEmailInUse' => context.l10n.errorEmailInUse,
      'errorWeakPassword' => context.l10n.errorWeakPassword,
      'errorNetworkRequest' => context.l10n.errorNetworkRequest,
      'errorTooManyRequests' => context.l10n.errorTooManyRequests,
      'errorInvalidCredential' => context.l10n.errorInvalidCredential,
      _ => context.l10n.errorUnknown,
    };
  }
}
