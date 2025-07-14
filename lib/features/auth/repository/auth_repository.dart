import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:facebook_clone_in_flutter/core/constants/storage_folder_names.dart';
import 'package:facebook_clone_in_flutter/core/utils/utils.dart';
import 'package:facebook_clone_in_flutter/features/auth/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/constants/firebaes_collection_names.dart';

class AuthRepository {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  // sign in
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      return null;
    }
  }

  // sign out
  Future<String?> signOut() async {
    try {
      _auth.signOut();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // create account
  Future<UserCredential?> createAccount({
    required String fullName,
    required DateTime birthday,
    required String gender,
    required String email,
    required String password,
    required File? image,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final path = _storage
          .ref(StorageFolderNames.profilePics)
          .child(_auth.currentUser!.uid);

      if (image == null) {
        return null;
      }

      final taskSnapshot = await path.putFile(image);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      UserModel user = UserModel(
        fullName: fullName,
        birthDay: birthday,
        gender: gender,
        email: email,
        password: password,
        profilePicUrl: downloadUrl,
        uid: _auth.currentUser!.uid,
        friends: const [],
        sentRequests: const [],
        receivedRequests: const [],
      );

      await _firestore
          .collection(FirebaseCollectionNames.users)
          .doc(_auth.currentUser!.uid)
          .set(user.toMap());

      return credential;
    } catch (e) {
      showToastMessage(text: e.toString());
      debugPrint('AuthRepository → createAccount: $e');

      return null;
    }
  }

  // verify email
  Future<String?> verifyEmail() async {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        await user.sendEmailVerification();
      }
      return null;
    } catch (e) {
      showToastMessage(text: e.toString());
      return e.toString();
    }
  }

  // ✅ FIX: put inside the class!
  Future<UserModel> getUserInfo() async {
    final userData = await _firestore
        .collection(FirebaseCollectionNames.users)
        .doc(_auth.currentUser!.uid)
        .get();

    final user = UserModel.fromMap(userData.data()!);
    return user;
  }
}
