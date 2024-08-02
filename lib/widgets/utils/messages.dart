import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showmessages(BuildContext context) {
  final materialBanner = SnackBar(
    backgroundColor: const Color.fromARGB(0, 248, 246, 246),
    duration: Duration(seconds: 15),

    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 2,
    //  forceActionsBelow: true,
    content: SizedBox(
      height: 140,
      child: AwesomeSnackbarContent(
        title: 'Success',
        message:
            'We have sent this schedule to your device.. Please wait for upto 9 minutes.\nWill Notify you',
        messageFontSize: 13,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
        // to configure for material banner
        inMaterialBanner: true,
      ),
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentMaterialBanner()
    ..showSnackBar(materialBanner);

  /**/
  Navigator.of(context).pop();
}
