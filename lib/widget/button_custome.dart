import 'package:flutter/material.dart';

class ButtonCustome extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final bool isIcon;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;

  const ButtonCustome({
    super.key,
    required this.onPressed,
    this.title,
    this.isIcon = false,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcon ? (icon ?? Container()) : Container(),
            Text(
              title ?? "-",
            )
          ],
        ),
      ),
    );
  }
}
