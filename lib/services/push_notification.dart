import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/utils/notification.dart';
class Firebaseservices{
  void startservices(){
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    if (message.notification != null) {
      print('Notification Title: ${message.notification!.title}');
      print('Notification Body: ${message.notification!.body}');
      NotificationService().showNotification(
          title: message.notification!.title, body: message.notification!.body);
    }
  });
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
  }}