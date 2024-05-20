import 'package:cupcake_challenge/screens/main_screen.dart';
import 'package:cupcake_challenge/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
}

Future<void> main() async {
  await initApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      theme: Style.appTheme(context),
      home: const HomeScreen(),
    );
  }
}
