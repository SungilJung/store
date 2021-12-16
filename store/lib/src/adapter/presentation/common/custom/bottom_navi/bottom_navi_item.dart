import 'package:flutter/material.dart';

class BottomNaviItem {
  final Icon icon;
  final Icon activeIcon;
  final String label;

  BottomNaviItem({
    Key? key,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
