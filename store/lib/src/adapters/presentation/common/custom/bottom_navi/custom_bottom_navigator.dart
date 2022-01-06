import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_navi_fab.dart';
import 'bottom_navi_item.dart';

class CustomBottomBar extends StatefulWidget {
  final ValueChanged<int>? onTap;
  final Color fabColor;
  final Size fabSize;
  final BottomNaviFAB fab;
  final List<BottomNaviItem> items;
  final double height;
  final int currentIndex;
  final double iconSize;
  final double labelSize;
  final Color backgroundColor;

  CustomBottomBar({
    Key? key,
    required this.fab,
    required this.items,
    required this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.height = 70,
    this.fabColor = Colors.orange,
    this.fabSize = const Size(70, 70),
    this.labelSize = 14,
    this.iconSize = 24,
  })  : assert(items.length == 4),
        super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final double tabWidth = Get.width * 0.16;

  late int currentIndex;

  _setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant CustomBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentIndex != currentIndex) {
      currentIndex = widget.currentIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.height,
        width: Get.width,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border(
              top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          )),
        ),
        child: Stack(
          children: [
            widget.fab,
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TabItem(
                    minWidth: tabWidth,
                    icon: _getTabIcon(0),
                    text: _getText(context, 0),
                    onTap: () {
                      _setBottomBarIndex(0);
                      _onTap();
                    },
                  ),
                  _TabItem(
                    minWidth: tabWidth,
                    icon: _getTabIcon(1),
                    text: _getText(context, 1),
                    onTap: () {
                      _setBottomBarIndex(1);
                      _onTap();
                    },
                  ),
                  Container(
                    width: Get.width * 0.15,
                  ),
                  _TabItem(
                    minWidth: tabWidth,
                    icon: _getTabIcon(2),
                    text: _getText(context, 2),
                    onTap: () {
                      _setBottomBarIndex(2);
                      _onTap();
                    },
                  ),
                  _TabItem(
                    minWidth: tabWidth,
                    icon: _getTabIcon(3),
                    text: _getText(context, 3),
                    onTap: () {
                      _setBottomBarIndex(3);
                      _onTap();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getTabIcon(int index) {
    var tabIcon = currentIndex == index
        ? widget.items[index].activeIcon
        : widget.items[index].icon;

    return IconTheme(
        data: IconThemeData(size: widget.iconSize), child: tabIcon);
  }

  Widget _getText(BuildContext context, int index) {
    var textScale = MediaQuery.of(context).textScaleFactor;

    return Visibility(
      visible: textScale >= 1.0 && textScale <= 1.5,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          widget.items[index].label,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: widget.labelSize,
              fontWeight: currentIndex == index ? FontWeight.bold : null),
        ),
      ),
    );
  }

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap!(currentIndex);
    }
  }
}

class _TabItem extends StatelessWidget {
  final Widget icon;
  final Widget? text;
  final VoidCallback onTap;
  final double minWidth;

  const _TabItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    required this.minWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: icon,
            ),
            if (text != null) text!,
          ],
        ),
      ),
    );
  }
}
