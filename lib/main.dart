import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FlutterLocalNotificationsPlugin localNotifications;

  @override
  void initState() {
    super.initState();
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOSInitialize = const IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: IOSInitialize);
    localNotifications = FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      "ID",
      "Spider man",
      importance: Importance.high,
      channelDescription: "Отличная работа, Кэп",
    );
    var iosDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotifications.show(
        0, "Spider man", "Отличная работа, Кэп", generalNotificationDetails);
  }

  Future _shadleNotification() async {
    var interval = RepeatInterval.everyMinute;
    var androidDetails = const AndroidNotificationDetails("ID", "Spider man",
        importance: Importance.high,
        channelDescription:
            "Срочно нужна помощь супергероя для решения проблемы в приложении!",
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'));
    var iosDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotifications.periodicallyShow(
        0,
        "Spider man",
        "Срочно нужна помощь супергероя для решения проблемы в приложении!",
        interval,
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 72, 184),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Column(
          children: const [
            SizedBox(
              height: 300,
              width: 300,
              child: Image(
                image: AssetImage('assets/images/Marvel2.png'),
              ),
            ),
            Text(
              'Flutter',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              'Notifications',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
        Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.notifications),
                    TextButton(
                        onPressed: _showNotification,
                        child: const Text(
                          'Simple Notification',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ))
                  ]),
            ),
          ),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.notifications_active),
                    TextButton(
                        onPressed: _shadleNotification,
                        child: const Text(
                          'Scheduled Notification',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ))
                  ]),
            ),
          ),
        ]),
      ]),
    );
  }
}
