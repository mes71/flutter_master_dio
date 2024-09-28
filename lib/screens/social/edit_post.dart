import 'package:flutter/material.dart';
import 'package:flutter_master_dio/models/social/post.dart';
import 'package:flutter_master_dio/services/social_api.dart';

class EditPost extends StatefulWidget {
  const EditPost({super.key, required this.post});

  final Post post;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.title!;
    _bodyController.text = widget.post.body!;
  }

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
        title: const Text("Edit a Post"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await SocialApi().deletePost(id: widget.post.id!);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Post deleted successfully")));
                    Navigator.pop(context);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Post deleted failure ${e.toString()}"),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ))
        ],
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
                    onPressed: _updatePost,
                    child: const Text("Update Post"),
                  )
          ],
        ),
      ),
    );
  }

  Future<void> _updatePost() async {
    if (_titleController.text.isEmpty || _bodyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Title or Body cannot be empty")));
      return;
    }
    setState(() {
      _isLoading = false;
    });

    Post response = await SocialApi().updatePost(
        post: Post(
            id: widget.post.id,
            userId: widget.post.userId,
            title: _titleController.text,
            body: _bodyController.text));
    if (context.mounted) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Post updated successfully with Id ${response.id}")));

      setState(() {
        _isLoading = false;
      });
    }
  }
}
