import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailActivity extends StatelessWidget {
  final DocumentSnapshot post;

  PostDetailActivity({required this.post});

  @override
  Widget build(BuildContext context) {
    List<dynamic> imageUrls = post['images'] ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(post['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${post['price']}', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Description:', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
            Text(post['description'], style: TextStyle(fontSize: 16, color: Colors.white)),
            SizedBox(height: 20),
            imageUrls.isNotEmpty
                ? Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: imageUrls
                        .map((url) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImageView(imageUrl: url),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  url,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))
                        .toList(),
                  )
                : Text('No images available', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  FullScreenImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
