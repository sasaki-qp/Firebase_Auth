// ignore_for_file: use_key_in_widget_constructors

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sns_auth_demo/helper/global_context.dart';
import 'package:sns_auth_demo/helper/initial_setting.dart';
import 'package:sns_auth_demo/view/screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('box');
  await dotenv.load(fileName: '.env');
  InitialSetting();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorKey: navigatorKey,
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}
