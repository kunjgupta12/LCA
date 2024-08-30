// Common widget
  import 'package:flutter/material.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';

Widget buildLoranInfo(
    BuildContext context, {
    required String dynamicText1,
    required String dynamicText2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dynamicText1,
          style: theme.textTheme.headlineSmall!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
        SizedBox(height: 6.v),
        Text(
          dynamicText2,
          style: theme.textTheme.titleMedium!.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        )
      ],
    );
  }