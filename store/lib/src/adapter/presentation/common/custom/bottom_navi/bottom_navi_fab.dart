import 'package:flutter/material.dart';

class BottomNaviFAB extends StatelessWidget {
  final Size fabSize;
  final Color borderColor;
  final VoidCallback? onFabTap;
  final Color bgColor;
  final Icon icon;
  final double outterBorder;
  final double innerBorder;

  const BottomNaviFAB({
    Key? key,
    required this.icon,
    this.fabSize = const Size(70, 70),
    this.borderColor = Colors.deepOrange,
    this.onFabTap,
    this.bgColor = Colors.white,
    this.outterBorder = 5,
    this.innerBorder = 2.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.4,
      child: Container(
        height: fabSize.height,
        width: fabSize.width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          border: Border.all(
            width: outterBorder,
            color: bgColor,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: Offset(0.5, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: GestureDetector(
          onTap: onFabTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: innerBorder,
                color: borderColor,
              ),
            ),
            child: icon,
          ),
        ),
      ),
    );
  }
}
