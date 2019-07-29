
import 'package:flutter/material.dart';

class AnimatedPlayButton extends StatefulWidget {
  final double size;

  const AnimatedPlayButton({
    Key key,
    this.size
  }) : super(key: key);

  @override
  _AnimatedPlayButtonState createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    isPlaying = false;
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _handleClick() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      color: Colors.grey[400],
      iconSize: widget.size,
      icon: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: _animationController,
      ),
      onPressed: _handleClick,
    );
  }
}
