
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lca/api/api.dart';
import 'package:lca/api/auth/auth_repository.dart';
import 'package:lca/api/complaints.dart';
import 'package:lca/api/device/device_status_api.dart';
import 'package:lca/api/issues_des/issue_repository.dart';
import 'package:lca/api/schedule.dart';
import 'package:lca/api/token_shared_pref.dart';
import 'package:lca/screens/language_select/language_page.dart';
import 'package:lca/screens/splash_screen.dart';
import 'package:lca/services/push_notification.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/size_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'screens/language_select/locateregister.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message: ${message.messageId}");
}
String? locale_stored;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Future.delayed(const Duration(milliseconds: 1500));
  ThemeHelper().changeTheme('primary');
  locale_stored=await getlang();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  
  
Firebaseservices().firebaseCloudMessaging_Listeners();
Firebaseservices().startservices();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IssueProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider()),  ChangeNotifierProvider(create: (context) => RegisterNotifier()),
     ChangeNotifierProvider(create: (context) => CreateSchedule()),
       
      ],
      child: MyApp(
        token: prefs.getString('token'),
        devices: prefs.getInt('device'),
      )));
}

  
class MyApp extends StatelessWidget {
  final token;
  final devices;
  const MyApp({
    @required this.token,
    this.devices,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
          title: 'LCA',
          translations: LocaleString(),
          locale:Locale(locale_stored=='null' ? 'en':locale_stored!.split("_")[0].toString(), locale_stored =='null' ? 'US':locale_stored!.split("_")[1]),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FrameFiveScreen(
            token: token,
           
          ));
    });
  }
}

