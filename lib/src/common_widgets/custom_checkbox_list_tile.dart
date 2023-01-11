import 'package:flutter/material.dart';

class CustomCheckBoxListTile extends StatelessWidget {
  const CustomCheckBoxListTile({super.key, required this.title1});
  final String title1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final oldCheckboxTheme = theme.checkboxTheme;

    final newCheckBoxTheme = oldCheckboxTheme.copyWith(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    );

    return Theme(
      data: theme.copyWith(checkboxTheme: newCheckBoxTheme),
      child: CheckboxListTile(
        title: Text(
          title1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: title1 == 'Wash face' ? Colors.grey : null),
        ),
        subtitle: const Divider(
          thickness: 1,
        ),
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (_) {},
        value: title1 == 'Wash face' ? true : false,
      ),
    );
  }
}
