import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicknoms/controller/provider/authProvider/authProvider.dart';
import 'package:quicknoms/firebase_options.dart';
import 'package:quicknoms/view/bottomNavigationBar/bottomNavigationBar.dart';
import 'package:quicknoms/view/signInLogicScreen/signInLogicScreen.dart';
import 'package:sizer/sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const QuickNoms());
}

class QuickNoms extends StatelessWidget {
  const QuickNoms({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, _, __) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider<MobileAuthProvider>(
                  create: (_) => MobileAuthProvider())
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(),
                home: const SignInLogicScreen()));
      },
    );
  }
}
