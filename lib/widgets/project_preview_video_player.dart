// Separate stateful widget for video playback
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProjectPreviewVideoPlayer extends StatefulWidget {
  const ProjectPreviewVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.borderRadius,
    required this.thumbnailAsset,
  });

  final String videoUrl;
  final BorderRadius borderRadius;
  final String thumbnailAsset;

  @override
  State<ProjectPreviewVideoPlayer> createState() =>
      _ProjectPreviewVideoPlayerState();
}

class _ProjectPreviewVideoPlayerState extends State<ProjectPreviewVideoPlayer>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool _hasError = false;
  String? _errorMessage;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _createVideoController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createVideoController() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..setLooping(true)
      ..setVolume(0.0); // Mute for autoplay on web
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _controller.initialize();
      if (mounted) {
        setState(() {}); // Trigger rebuild to show video
        await _controller.play();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: _hasError
          ? _buildErrorWidget()
          : _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : _buildLoadingWidget(),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      height: 200,
      color: Colors.black26,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Failed to load video',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    if (widget.thumbnailAsset != null) {
      return _buildThumbnailWidget();
    }

    return Container(
      height: 200,
      color: Colors.black26,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildThumbnailWidget() {
    return SizedBox(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail image
          Image.asset(
            widget.thumbnailAsset!,
            fit: BoxFit.cover,
          ),
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Loading indicator on top
          const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
