import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitworld_app/providers/user_provider.dart';
import 'package:fitworld_app/responsive/responsive_layout_screen.dart';
import 'package:fitworld_app/screens/login_screen.dart';
import 'package:fitworld_app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'responsive/mobile_screen_layout.dart';
import 'package:provider/provider.dart';
import 'responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitworld_app/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyASpaTNs1XsdJr3rSLZX7JjdEUdWAQKIow",
            appId: '1:887969804090:web:e40ae4663558c79ce86a03',
            messagingSenderId: '887969804090',
            projectId: 'fitworld-ae32e',
            storageBucket: 'fitworld-ae32e.appspot.com'));
  }

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Fit World',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
