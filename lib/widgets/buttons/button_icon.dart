import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {

  final VoidCallback onPressed;
  final Widget icon;
  final Color backgroundColor;
  final Color overlayColor;
  final Color textColor;
  final Color? borderColor;
  final String text;

  const ButtonIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
    required this.overlayColor,
    required this.textColor,
    required this.text,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return overlayColor;
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return overlayColor;
            }
            return null;
            },
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 0)
        ),
        side: borderColor != null ? MaterialStateProperty.all(
          BorderSide(
            color: borderColor!,
            width: 1,
          )
        ) : null,
      ),
      icon: icon,
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
        ),
      )
    );
  }
}