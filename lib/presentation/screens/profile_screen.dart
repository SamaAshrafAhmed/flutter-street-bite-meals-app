import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:street_bite/core/dependency_injection/injection.dart';
import 'package:street_bite/core/utils/localization.dart';
import 'package:street_bite/presentation/cubit/auth_cubit.dart';
import 'package:street_bite/presentation/cubit/auth_state.dart';
import 'package:street_bite/presentation/cubit/cart_cubit.dart';
import 'package:street_bite/presentation/screens/login_screen.dart';

import '../../core/theming/cubit/theme_cubit.dart';
import '../../data/services/firestore_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: const _BiometricProfileGate(),
    );
  }
}

class _BiometricProfileGate extends StatefulWidget {
  const _BiometricProfileGate();

  @override
  State<_BiometricProfileGate> createState() => _BiometricProfileGateState();
}

class _BiometricProfileGateState extends State<_BiometricProfileGate> {
  final _auth = LocalAuthentication();
  bool _authenticated = false;
  bool _checking = true;
  String? _message;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _authenticate();
    });
  }

  Future<void> _authenticate() async {
    var authenticated = false;
    final reason = context.l10n.biometricReason;
    final unavailableMessage = context.l10n.biometricUnavailable;
    final failedMessage = context.l10n.biometricFailed;
    String? message;
    try {
      final supported = await _auth.isDeviceSupported();
      final available = await _auth.canCheckBiometrics;
      final biometrics = await _auth.getAvailableBiometrics();
      if (!supported || !available || biometrics.isEmpty) {
        message = unavailableMessage;
      } else {
        authenticated = await _auth.authenticate(
          localizedReason: reason,
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );
        if (!authenticated) message = failedMessage;
      }
    } on PlatformException {
      authenticated = false;
      message = failedMessage;
    }
    if (mounted) {
      setState(() {
        _authenticated = authenticated;
        _checking = false;
        _message = message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!_authenticated) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_message != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(_message!, textAlign: TextAlign.center),
              ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                setState(() {
                  _checking = true;
                  _message = null;
                });
                _authenticate();
              },
              icon: const Icon(Icons.fingerprint_rounded),
              label: Text(context.l10n.authenticateProfile),
            ),
          ],
        ),
      );
    }
    return const _ProfileBody();
  }
}

class _ProfileBody extends StatefulWidget {
  const _ProfileBody();

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody> {
  final _picker = ImagePicker();
  final _deviceInfo = DeviceInfoPlugin();
  String? _photoBase64;
  Map<String, String>? _deviceDetails;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _loadPhoto();
    _loadDeviceDetails();
  }

  Future<void> _loadPhoto() async {
    final photo = await FirestoreService.instance.loadProfilePhoto();
    if (mounted) setState(() => _photoBase64 = photo);
  }

  Future<void> _loadDeviceDetails() async {
    try {
      final details = <String, String>{};
      if (kIsWeb) {
        final info = await _deviceInfo.webBrowserInfo;
        details['model'] = info.browserName.name;
        details['system'] = info.platform ?? '';
        details['version'] = info.appVersion ?? '';
      } else {
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            final info = await _deviceInfo.androidInfo;
            details['model'] = info.model;
            details['manufacturer'] = info.manufacturer;
            details['system'] = 'Android';
            details['version'] = info.version.release;
            details['id'] = info.id;
          case TargetPlatform.iOS:
            final info = await _deviceInfo.iosInfo;
            details['model'] = info.modelName;
            details['manufacturer'] = 'Apple';
            details['system'] = info.systemName;
            details['version'] = info.systemVersion;
            details['id'] = info.identifierForVendor ?? '';
          case TargetPlatform.windows:
            final info = await _deviceInfo.windowsInfo;
            details['model'] = info.computerName;
            details['system'] = 'Windows';
            details['version'] = info.displayVersion;
          case TargetPlatform.macOS:
            final info = await _deviceInfo.macOsInfo;
            details['model'] = info.model;
            details['system'] = info.osRelease;
            details['version'] = info.patchVersion.toString();
          case TargetPlatform.linux:
            final info = await _deviceInfo.linuxInfo;
            details['model'] = info.prettyName;
            details['system'] = info.name;
            details['version'] = info.version ?? '';
          case TargetPlatform.fuchsia:
            details['model'] = 'Fuchsia';
            details['system'] = 'Fuchsia';
            details['version'] = '';
        }
      }
      if (mounted) setState(() => _deviceDetails = details);
    } catch (_) {
      if (mounted) setState(() => _deviceDetails = <String, String>{});
    }
  }

  Future<void> _pickPhoto() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 720,
      maxHeight: 720,
      imageQuality: 75,
    );
    if (file == null) return;
    setState(() => _uploading = true);
    try {
      final encoded = base64Encode(await file.readAsBytes());
      await FirestoreService.instance.saveProfilePhoto(encoded);
      if (mounted) setState(() => _photoBase64 = encoded);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.profilePhotoError)));
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

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
            child: Text(context.l10n.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photo = _photoBase64;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          context.read<CartCubit>().clearAll();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (_) => false,
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
          const SizedBox(height: 24),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 54,
                  backgroundImage: photo == null
                      ? null
                      : MemoryImage(base64Decode(photo)),
                  child: photo == null
                      ? const Icon(Icons.person_rounded, size: 54)
                      : null,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton.filled(
                    onPressed: _uploading ? null : _pickPhoto,
                    icon: _uploading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.camera_alt_rounded),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              user?.displayName ?? context.l10n.guestUser,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Center(child: Text(user?.email ?? context.l10n.emailUnavailable)),
          const SizedBox(height: 32),
          _DeviceDetailsCard(details: _deviceDetails),
          const SizedBox(height: 24),
          Text(context.l10n.themeLabel),
          const SizedBox(height: 8),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) => SegmentedButton<ThemeMode>(
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
            ),
          ),
          const SizedBox(height: 24),
          Text(context.l10n.languageLabel),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(
                value: 'en',
                label: Text(context.l10n.languageEnglish),
              ),
              ButtonSegment(
                value: 'ar',
                label: Text(context.l10n.languageArabic),
              ),
            ],
            selected: {localeNotifier.value.languageCode},
            onSelectionChanged: (selected) =>
                context.setAppLocale(Locale(selected.first)),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: () => _showLogoutDialog(context),
            icon: const Icon(Icons.logout_rounded),
            label: Text(context.l10n.logoutButton),
          ),
        ],
      ),
    );
  }
}

class _DeviceDetailsCard extends StatelessWidget {
  final Map<String, String>? details;

  const _DeviceDetailsCard({required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: details == null
            ? const Center(child: CircularProgressIndicator())
            : details!.isEmpty
            ? Text(context.l10n.deviceDetailsUnavailable)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.deviceDetails,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _DeviceDetailRow(
                    icon: Icons.phone_android_rounded,
                    label: context.l10n.deviceModel,
                    value: details!['model'],
                  ),
                  if (details!.containsKey('manufacturer'))
                    _DeviceDetailRow(
                      icon: Icons.business_rounded,
                      label: context.l10n.deviceManufacturer,
                      value: details!['manufacturer'],
                    ),
                  _DeviceDetailRow(
                    icon: Icons.memory_rounded,
                    label: context.l10n.deviceSystem,
                    value: details!['system'],
                  ),
                  _DeviceDetailRow(
                    icon: Icons.info_outline_rounded,
                    label: context.l10n.deviceVersion,
                    value: details!['version'],
                  ),
                  if (details!.containsKey('id'))
                    _DeviceDetailRow(
                      icon: Icons.fingerprint_rounded,
                      label: context.l10n.deviceId,
                      value: details!['id'],
                    ),
                ],
              ),
      ),
    );
  }
}

class _DeviceDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;

  const _DeviceDetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value?.isNotEmpty == true ? value! : '-')),
        ],
      ),
    );
  }
}
