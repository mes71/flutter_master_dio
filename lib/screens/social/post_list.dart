import 'package:flutter/material.dart';
import 'package:flutter_master_dio/models/social/post.dart';
import 'package:flutter_master_dio/models/social/user.dart';
import 'package:flutter_master_dio/screens/social/edit_post.dart';
import 'package:flutter_master_dio/services/social_api.dart';

import 'create_post.dart';

class PostList extends StatelessWidget {
  final User user;

  const PostList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${user.name} Posts"),
        centerTitle: true,
        elevation: 1,
      ),
      body: FutureBuilder(
          future: SocialApi().getPostsByUserId(user.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "Error: ${snapshot.error}  \n please try again later",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.redAccent),
              ));
            } else {
              List<Post>? posts = snapshot.data;
              return ListView.builder(
                  itemCount: posts?.length,
                  itemBuilder: (context, index) {
                    Post? post = posts?[index];
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    post?.title ?? '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditPost(post: post!)));
                                    },
                                    icon: Icon(Icons.edit))
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              post?.body ?? '',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreatePost(
                          user: user,
                        )));
          }),
    );
  }
}
