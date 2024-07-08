import 'package:flutter/material.dart';
import 'package:lca/widgets/utils/size_utils.dart';

import '../../../widgets/theme_helper.dart';

class GridvalvecounteItemWidget extends StatelessWidget {
  const GridvalvecounteItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Valve 3",
          style: theme.textTheme.bodyLarge,
        ),
        Container(
          height: 13.v,
          width: 148.h,
          decoration: BoxDecoration(
            color: appTheme.blueGray100.withOpacity(0.59),
            borderRadius: BorderRadius.circular(
              5.h,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              5.h,
            ),
            child: LinearProgressIndicator(
              value: 0.99,
              backgroundColor: appTheme.blueGray100.withOpacity(0.59),
              valueColor: AlwaysStoppedAnimation<Color>(
                appTheme.green600,
              ),
            ),
          ),
        )
      ],
    );
  }
}
