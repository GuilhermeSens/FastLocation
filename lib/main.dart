import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/modules/initial/page/initial_page.dart';
import 'src/shared/storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await LocalStorage.init();
  runApp(const FastLocationApp());
}

class FastLocationApp extends StatelessWidget {
  const FastLocationApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FastLocation', debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)), useMaterial3: true),
    home: const InitialPage(),
  );
}
