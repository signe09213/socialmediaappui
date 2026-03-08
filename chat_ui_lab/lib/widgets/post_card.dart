import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';
import '../models/post_model.dart';
import '../screens/comments_screen.dart'; // Import the new comments screen

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _heartAnimation;
  bool _isHeartAnimating = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _heartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isHeartAnimating = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      if (widget.post.isLiked) {
        widget.post.likes -= 1;
        widget.post.isLiked = false;
      } else {
        widget.post.likes += 1;
        widget.post.isLiked = true;
      }
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _isHeartAnimating = true;
      if (!widget.post.isLiked) {
        _toggleLike();
      }
      _animController.forward(from: 0.0);
    });
  }

  void _sharePost() {
    Share.share('Check out this post from ${widget.post.userName}: ${widget.post.caption}');
  }

  void _navigateToComments() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentsScreen(
          postUserName: widget.post.userName,
          postCaption: widget.post.caption,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildMedia(context),
          _buildActionButtons(),
          _buildPostDetails(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(widget.post.userAvatarUrl),
              ),
              const SizedBox(width: 10.0),
              Text(
                widget.post.userName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ],
          ),
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildMedia(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.post.mediaType == MediaType.image)
            Image.asset(
              widget.post.mediaUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            )
          else
            VideoPost(videoUrl: widget.post.mediaUrl),
          if (_isHeartAnimating)
            ScaleTransition(
              scale: _heartAnimation,
              child: const Icon(Icons.favorite, color: Colors.white, size: 100.0),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: widget.post.isLiked ? Colors.red : Colors.black,
                  size: 28.0,
                ),
                onPressed: _toggleLike,
              ),
              IconButton(icon: const Icon(Icons.chat_bubble_outline, size: 28.0), onPressed: _navigateToComments),
              IconButton(icon: const Icon(Icons.send_outlined, size: 28.0), onPressed: _sharePost),
            ],
          ),
          IconButton(icon: const Icon(Icons.bookmark_border, size: 28.0), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildPostDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.post.likes} likes',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          const SizedBox(height: 6.0),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 13.0),
              children: [
                TextSpan(
                  text: '${widget.post.userName} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: widget.post.caption,
                ),
                TextSpan(
                  text: ' ...more',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6.0),
          GestureDetector(
            onTap: _navigateToComments,
            child: Text(
              widget.post.comments,
              style: TextStyle(color: Colors.grey[700], fontSize: 13.0),
            ),
          ),
          const SizedBox(height: 6.0),
          Row(
            children: [
              const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1')),
              const SizedBox(width: 8.0),
              Text("Add a comment...", style: TextStyle(color: Colors.grey[700], fontSize: 13.0)),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            widget.post.timestamp,
            style: TextStyle(color: Colors.grey[600], fontSize: 11.0),
          ),
        ],
      ),
    );
  }
}

class VideoPost extends StatefulWidget {
  final String videoUrl;

  const VideoPost({super.key, required this.videoUrl});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                _controller.value.volume == 0
                    ? _controller.setVolume(1.0)
                    : _controller.setVolume(0);
              });
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          );
  }
}
