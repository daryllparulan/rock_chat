import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_chat/provider/sign_in_provider.dart';
import 'package:rock_chat/provider/sign_up_provider.dart';
import 'package:rock_chat/service/auth/auth_service.dart';
import 'package:rock_chat/ui/colors/rock_colors.dart';
import 'package:rock_chat/ui/home_page.dart';
import 'package:rock_chat/ui/sign_in.dart';
import 'package:rock_chat/model/user.dart' as Model;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = AuthenticationService(FirebaseAuth.instance);

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(create: (_) => authService),
        ChangeNotifierProvider<SignInProvider>(
            create: (_) => SignInProvider(authService)),
        ChangeNotifierProvider<SignUpProvider>(
            create: (_) => SignUpProvider(authService)),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().userAuthStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Rock Chat',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: MaterialColor(
                        RockColors.colorPrimary.value, RockColors.primaryMap),
                    primaryColorDark: RockColors.colorPrimaryDark)
                .copyWith(secondary: RockColors.colorLightAccent)),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<Model.User?>();
    if (user != null) {
      return const HomePage();
    }
    return const SignInPage();
  }
}
