import 'package:flutter/material.dart';

// Ajoutez ces classes d'animation en haut de votre fichier
class PulsatingCircle extends StatefulWidget {
  final Color color;
  final double size;
  final Widget? child;

  const PulsatingCircle({
    Key? key,
    required this.color,
    this.size = 20.0,
    this.child,
  }) : super(key: key);

  @override
  _PulsatingCircleState createState() => _PulsatingCircleState();
}

class _PulsatingCircleState extends State<PulsatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.size * _animation.value,
          height: widget.size * _animation.value,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
          child: Center(child: widget.child),
        );
      },
    );
  }
}

class MovingDot extends StatefulWidget {
  final Color color;
  final double size;
  final bool reverse;

  const MovingDot({
    Key? key,
    required this.color,
    this.size = 12.0,
    this.reverse = false,
  }) : super(key: key);

  @override
  _MovingDotState createState() => _MovingDotState();
}

class _MovingDotState extends State<MovingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation =
        widget.reverse
            ? Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
            : Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          left: _animation.value * 100,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
