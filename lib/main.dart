import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/chat.dart';
import 'screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // initialize the app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // initialize Firebase
  await FirebaseAppCheck.instance.activate();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          brightness: Brightness.light, // hoặc Brightness.dark
          primary: const Color.fromARGB(
              255, 0, 180, 216), //Màu nền: Sử dụng màu primary.
          onPrimary: Colors.white, //Màu chữ: Sử dụng màu onPrimary.
          secondary: const Color.fromARGB(255, 202, 240, 248),
          onSecondary: Colors.white,
          background: Colors.grey[200]!,
          onBackground: Colors.black,
          surface: const Color.fromARGB(255, 0, 119, 182),
          onSurface: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance
              .authStateChanges(), // listen to auth state changes
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }

            if (snapshot.hasData) {
              return const ChatScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}
