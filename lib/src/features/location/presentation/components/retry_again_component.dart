import 'package:flutter/material.dart';
import 'package:super_to_do/src/common_widgets/custom_text.dart';
import 'package:super_to_do/src/constants/app_sizes.dart';

class RetryAgainComponent extends StatelessWidget {
  final String description;
  final VoidCallback onPressed;

  const RetryAgainComponent({
    required this.description,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomText.f18(
            context,
            description,
            textAlign: TextAlign.center,
          ),
          gapH20,
          ElevatedButton(onPressed: onPressed, child: const Text('Try again'))
        ],
      ),
    );
  }
}
