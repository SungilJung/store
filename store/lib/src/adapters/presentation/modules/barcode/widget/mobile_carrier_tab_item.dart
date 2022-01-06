import 'package:flutter/material.dart';

import '../model/mobile_carrier.dart';
import '../model/mobile_carrier_type.dart';

class MobileCarrierTabItem extends StatelessWidget {
  final MobileCarrier carrier;
  final double width;
  final double height;
  final Color color;
  final ValueChanged<int>? onTap;
  final TextStyle textStyle;

  const MobileCarrierTabItem({
    Key? key,
    required this.carrier,
    required this.width,
    this.height = 30,
    required this.color,
    required this.onTap,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(carrier.index);
        }
        ;
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: color,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            '${carrier.type.name}',
            style: textStyle.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}
