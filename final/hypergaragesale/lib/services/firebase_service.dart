import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

   Future<void> addNewPost(String title, String price, String description, List<String> imageUrls) async {
    try {
      await _firestore.collection('posts').add({
        'title': title,
        'price': price,
        'description': description,
        'images': imageUrls,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> downloadUrls = [];
    try {
      for (File image in images) {
        String fileName = image.path.split('/').last;
        Reference storageReference = _storage.ref().child('post_images').child(fileName);
        await storageReference.putFile(image);
        String downloadURL = await storageReference.getDownloadURL();
        print('File Uploaded: $downloadURL');
        downloadUrls.add(downloadURL);
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
    return downloadUrls;
  }


  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('Error signing in anonymously: $e');
      return null;
    }
  }

  Stream<QuerySnapshot> getPostsStream() {
    return _firestore.collection('posts').orderBy('created_at', descending: true).snapshots();
  }

  Future<void> updatePost(String postId, String title, String price, String description, List<String> imageUrls) async {
    try {
      await _firestore.collection('posts').doc(postId).update({
        'title': title,
        'price': price,
        'description': description,
        'images': imageUrls,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating post: $e');
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}
