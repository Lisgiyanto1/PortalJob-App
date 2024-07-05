import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/Models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(UserModel user, File selectedImage) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
      await FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(user.photoUrl!)
          .putFile(selectedImage);
    } catch (error) {
      throw Exception('Gagal mendaftarkan pengguna: $error');
    }
  }

  Future<bool> isAuthenticated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString("user-token");
    return userToken != null;
  }
}
