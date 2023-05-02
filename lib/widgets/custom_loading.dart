import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key});

  @override
  CustomLoadingState createState() => CustomLoadingState();
}

class CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller!),
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}