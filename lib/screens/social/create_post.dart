import 'package:flutter/material.dart';
import 'package:flutter_master_dio/models/social/post.dart';
import 'package:flutter_master_dio/models/social/user.dart';

import '../../services/social_api.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key, required this.user});

  final User user;

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create a Post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Title",
              ),
              maxLines: 2,
              minLines: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: "Body",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _createPost,
                    child: const Text("Create Post"),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> _createPost() async {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Title or Body cannot be empty")));
      return;
    }
    setState(() {
      _isLoading = false;
    });

    Post response = await SocialApi().createPostNew(
        post: Post(
            userId: widget.user.id,
            title: _titleController.text,
            body: _bodyController.text));
    if (context.mounted) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Post created successfully with Id ${response.id}")));

      setState(() {
        _titleController.clear();
        _bodyController.clear();
        _isLoading = false;
      });
    }
  }
}
