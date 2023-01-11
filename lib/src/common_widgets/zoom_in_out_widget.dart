import 'package:flutter/material.dart';

class ZoomInOutWidget extends StatelessWidget {
  const ZoomInOutWidget({
    Key? key,
    required this.zoomInCallback,
    required this.zoomOutCallback,
  }) : super(key: key);

  final VoidCallback zoomInCallback;
  final VoidCallback zoomOutCallback;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: "btn1",
          onPressed: zoomInCallback,
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8.0),
        FloatingActionButton(
          heroTag: "btn2",
          onPressed: zoomOutCallback,
          child: const Icon(Icons.zoom_out),
        ),
      ],
    );
  }
}
