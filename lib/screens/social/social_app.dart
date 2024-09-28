import 'package:flutter/material.dart';
import 'package:flutter_master_dio/models/social/user.dart';
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
              List<User>? allUsers = snapshot.data;
              return ListView.builder(
                  itemCount: allUsers?.length,
                  itemBuilder: (context, index) {
                    User? user = allUsers?[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/droidcon_logo.png"),
                      ),
                      title: Text(user?.name ?? ''),
                      subtitle: Text(user?.email ?? ''),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostList(user: user!)));
                      },
                    );
                  });
            }
          }),
    );
  }
}
