import 'package:flutter/material.dart';
import 'package:lca/widgets/utils/size_utils.dart';

import '../../../widgets/theme_helper.dart';

// ignore: must_be_immutable
class DaysgridItemWidget extends StatefulWidget {
  String day;
  DaysgridItemWidget({required this.day, Key? key})
      : super(
          key: key,
        );

  @override
  State<DaysgridItemWidget> createState() => _DaysgridItemWidgetState();
}

class _DaysgridItemWidgetState extends State<DaysgridItemWidget> {

  Color _colorContainer = Colors.white;
  @override
  Widget build(BuildContext context) {
    bool color = false;
    return Sizer(builder: (context, orientation, deviceType) {
      return Align(
        alignment: Alignment.center,
        child: Ink(
          child: InkWell(
            onTap: () {
              setState(() {
                _colorContainer =
                    _colorContainer == Colors.white ? Colors.red : Colors.white;
              });
            },
            child: Container(
              height: 250.v,
              width: 1552.h,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.day,
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 16,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _colorContainer),
                    )
                  ],
                ),
              )),
              decoration: BoxDecoration(
                color: Color.fromRGBO(180, 246, 202, 1),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
