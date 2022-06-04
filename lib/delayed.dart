import 'package:flutter/material.dart';
import 'dart:async';

class Delayed_A extends StatefulWidget {
  final Widget child;
  final int delay;
  const Delayed_A({required this.delay, required this.child});

  @override
  State<Delayed_A> createState() => _Delayed_AState();
}

class _Delayed_AState extends State<Delayed_A>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animeOffset;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    final curve =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _animeOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(curve);
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animeOffset,
        child: widget.child,
      ),
    );
  }
}
