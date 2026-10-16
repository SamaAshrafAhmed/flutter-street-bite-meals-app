import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  const FirebaseAuthDataSource(this._auth);

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;
    return UserEntityBuilder()
        .id(user.uid)
        .email(user.email!)
        .displayName(user.displayName)
        .build();
  }

  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;
    await user.updateDisplayName(name);
    return UserEntityBuilder()
        .id(user.uid)
        .email(user.email!)
        .displayName(name)
        .build();
  }

  Future<void> logout() => _auth.signOut();
}
