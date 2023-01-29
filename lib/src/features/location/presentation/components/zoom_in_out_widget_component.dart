import 'package:flutter/material.dart';

class ZoomInOutWidgetComponent extends StatelessWidget {
  const ZoomInOutWidgetComponent({
    Key? key,
    required this.zoomInCallback,
    required this.zoomOutCallback,
  }) : super(key: key);

  final VoidCallback zoomInCallback;
  final VoidCallback zoomOutCallback;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * .18,
      right: 10,
      child: Column(
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
      ),
    );
  }
}
