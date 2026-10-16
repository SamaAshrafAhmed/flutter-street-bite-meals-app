import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/meal_model.dart';

/// Singleton gateway for user-owned Firestore data.
class FirestoreService {
  FirestoreService._();
  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<void> saveOrder({
    required List<MealModel> meals,
    required int itemCount,
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
          'meals': meals.map((meal) => meal.toJson()).toList(),
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
