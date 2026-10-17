import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/meal_model.dart';

/// Singleton gateway for user-owned Firestore data.
class FirestoreService {
  FirestoreService._();
  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>>? get _profile {
    final user = _auth.currentUser;
    return user == null ? null : _firestore.collection('users').doc(user.uid);
  }

  CollectionReference<Map<String, dynamic>>? get _favorites {
    final user = _auth.currentUser;
    return user == null
        ? null
        : _firestore.collection('users').doc(user.uid).collection('favorites');
  }

  Future<List<MealModel>> loadFavorites() async {
    final snapshot = await _favorites?.get();
    return snapshot?.docs
            .map((doc) => MealModel.fromJson(doc.data()))
            .toList() ??
        [];
  }

  Future<void> toggleFavorite(MealModel meal) async {
    final favorites = _favorites;
    if (favorites == null) return;
    final doc = favorites.doc(meal.id);
    if ((await doc.get()).exists) {
      await doc.delete();
    } else {
      await doc.set(meal.toJson());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchFavorites() {
    final favorites = _favorites;
    return favorites?.snapshots() ?? const Stream.empty();
  }

  Future<String?> loadProfilePhoto() async {
    final snapshot = await _profile?.get();
    return snapshot?.data()?['photoBase64'] as String?;
  }

  Future<void> saveProfilePhoto(String base64Image) async {
    await _profile?.set({
      'displayName': _auth.currentUser?.displayName,
      'email': _auth.currentUser?.email,
      'photoBase64': base64Image,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> saveOrder({
    required List<Map<String, dynamic>> items,
    required int itemCount,
    required String paymentMethod,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .add({
          'createdAt': FieldValue.serverTimestamp(),
          'itemCount': itemCount,
          'paymentMethod': paymentMethod,
          'items': items,
        });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchOrders() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
