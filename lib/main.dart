
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lca/api/api.dart';
import 'package:lca/api/complaints.dart';
import 'package:lca/api/device_status_api.dart';
import 'package:lca/screens/splash_screen.dart';
import 'package:lca/widgets/theme_helper.dart';
import 'package:lca/widgets/utils/notification.dart';
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
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // HttpOverrides.global = MyHttpOverrides();
  await Future.delayed(Duration(milliseconds: 1500));
  ThemeHelper().changeTheme('primary');
  String? jsonString;
  void storedevice() async {
    final prefs = await SharedPreferences.getInstance();
    jsonString = prefs.getString('devicelist');
    print('stored data:${jsonString}');
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    if (message.notification != null) {
      print('Notification Title: ${message.notification!.title}');
      print('Notification Body: ${message.notification!.body}');
      NotificationService().showNotification(
          title: message.notification!.title, body: message.notification!.body);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  
firebaseCloudMessaging_Listeners();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IssueProvider()),
        ChangeNotifierProvider(create: (context) => DeviceProvider()),  ChangeNotifierProvider(create: (context) => RegisterNotifier()),
    
      ],
      child: MyApp(
        token: prefs.getString('token'),
        devices: prefs.getInt('device'),
      )));
}

  void firebaseCloudMessaging_Listeners() async{
    
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
      await FirebaseMessaging.instance.requestPermission(provisional: true);
  final apnsToken = await FirebaseMessaging.instance.getToken();
  if (apnsToken != null) {
    print(apnsToken);
  }
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
          locale: Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FrameFiveScreen(
            token: token,
            devices: devices,
          ));
    });
  }
}

final List locale = [
  {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
  {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
];

updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
}
