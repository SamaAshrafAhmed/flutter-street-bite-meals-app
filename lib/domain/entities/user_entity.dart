class UserEntity {
  final String id;
  final String email;
  final String? displayName;

  const UserEntity({required this.id, required this.email, this.displayName});
}

/// Builder keeps user construction explicit as profile fields grow.
/// Builder keeps optional Firebase profile fields explicit while constructing
/// the immutable domain user entity.
class UserEntityBuilder {
  String? _id;
  String? _email;
  String? _displayName;

  UserEntityBuilder id(String value) {
    _id = value;
    return this;
  }

  UserEntityBuilder email(String value) {
    _email = value;
    return this;
  }

  UserEntityBuilder displayName(String? value) {
    _displayName = value;
    return this;
  }

  UserEntity build() {
    final id = _id;
    final email = _email;
    if (id == null || email == null) {
      throw StateError('User id and email are required');
    }
    return UserEntity(id: id, email: email, displayName: _displayName);
  }
}
