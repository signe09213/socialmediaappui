import 'package:flutter/material.dart';

class CommentsScreen extends StatefulWidget {
  final String postUserName;
  final String postCaption;

  const CommentsScreen({
    super.key,
    required this.postUserName,
    required this.postCaption,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final List<String> _comments = [
    'This is an amazing shot!',
    'Wow, great content!',
    'Love this! ❤️',
  ];

  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add(_commentController.text);
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length + 1, // +1 for the original post caption
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Display the original post as the first item
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: '${widget.postUserName} ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: widget.postCaption),
                        ],
                      ),
                    ),
                  );
                }
                // Display the comments
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=50'),
                  ),
                  title: Text(_comments[index - 1]),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
