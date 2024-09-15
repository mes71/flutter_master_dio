import 'package:flutter/material.dart';
import 'package:flutter_master_dio/services/social_api.dart';

import 'post_list.dart';

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("The Social"),
        centerTitle: true,
        elevation: 1,
      ),
      body: FutureBuilder(
          future: SocialApi().getAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/droidcon_logo.png"),
                        ),
                        title: Text(snapshot.data[index]['name']),
                        subtitle: Text(snapshot.data[index]['email']),
                        trailing: const Icon(Icons.navigate_next),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PostList()));
                        },
                      ));
            }
          }),
    );
  }
}
