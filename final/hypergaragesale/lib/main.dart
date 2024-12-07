import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/browse_posts_activity.dart';
import 'screens/new_post_activity.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(HyperGarageSaleApp());
}

class HyperGarageSaleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperGarageSale',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BrowsePostsActivity(),
      routes: {
        '/browse': (context) => BrowsePostsActivity(),
        '/newPost': (context) => NewPostActivity(),
      },
    );
  }
}
