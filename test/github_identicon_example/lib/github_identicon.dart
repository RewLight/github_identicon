import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'github_identicon_generator.dart';

/// Flutter widget for displaying GitHub identicons
class GitHubIdenticon extends StatelessWidget {
  final String seed;
  final double size;
  final bool showGrid;

  /// Creates a GitHub-style identicon widget
  ///
  /// [seed] : Unique identifier for the avatar
  /// [size] : Display size in pixels
  /// [showGrid] : Whether to display grid lines (default: true)
  const GitHubIdenticon({
    super.key,
    required this.seed,
    required this.size,
    this.showGrid = true,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future:
          GitHubIdenticonGenerator(
            seed: seed,
            size: size,
            showGrid: showGrid,
          ).generate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return RawImage(
            image: snapshot.data!,
            width: size,
            height: size,
            fit: BoxFit.contain,
          );
        }
        return Container(
          width: size,
          height: size,
          color: Colors.grey[200],
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
