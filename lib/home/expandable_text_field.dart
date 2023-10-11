import 'package:dog_breeds/common/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableTextField extends StatefulWidget {
  final Widget child;

  const ExpandableTextField({
    super.key,
    required this.child,
  });

  @override
  State createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField> {
  double _layoutHeight = 300;
  double _maxHeight = 300;
  final double _minHeight = 60;
  double _height = 60;
  bool isTop = false;
  final double _dividerHeight = 30;
  final double _dividerSpace = 2;
  bool topDividerEnable = false;

  bool isKeyboard = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    if (!isKeyboard) {
      _height = _minHeight;
    }

    _maxHeight = _layoutHeight - MediaQuery.of(context).viewInsets.bottom - (2 * _dividerHeight);

    return LayoutBuilder(
      builder: (context, constraints) {
        _layoutHeight = constraints.maxHeight;
        return Stack(
          children: [
            IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                color: _height == _maxHeight ? Colors.white : Colors.transparent,
              ),
            ),
            buildBody(),
          ],
        );
      },
    );
  }

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: !isKeyboard ? BorderRadius.circular(12.0) : const BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero),
            side: _height == _maxHeight
                ? BorderSide.none
                : const BorderSide(
                    color: MyColors.divider,
                    width: 1.0,
                  ),
          ),
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.only(
              left: isKeyboard ? 0 : 12, right: isKeyboard ? 0 : 12, bottom: (isKeyboard ? MediaQuery.of(context).viewInsets.bottom : 110)),
          child: Column(
            children: [
              if (isKeyboard) ...[
                GestureDetector(
                  child: buildTopDrag(),
                  onPanDown: (details) {
                    setState(() {
                      isTop = !isTop;
                      if (isTop) {
                        _height = _minHeight;
                      } else {
                        _height = _maxHeight;
                      }
                    });
                  },
                ),
              ],
              SizedBox(height: _dividerSpace),
              AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                child: SizedBox(
                  height: _height,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTopDrag() {
    return Container(
      color: Colors.transparent,
      height: _dividerHeight,
      width: 0.9.sw,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
              height: 4,
              width: 32,
              decoration: const BoxDecoration(color: MyColors.settingsModelDivider, borderRadius: BorderRadius.all(Radius.circular(20)))),
        ],
      ),
    );
  }
}
