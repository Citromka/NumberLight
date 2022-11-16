import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:numbers_light/getit_root.dart';
import 'package:numbers_light/navigation/app_navigation.dart';
import 'package:numbers_light/navigation/global_navigation_manager.dart';

late AppNavigation _appNavigation;
late GlobalNavigationManager _globalNavigationManager;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  _appNavigation = GetIt.I.get<AppNavigation>();
  _globalNavigationManager = GetIt.I.get<GlobalNavigationManager>();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _globalNavigationManager.setNavigatorKey(_navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: _navigatorKey,
      initialRoute: AppNavigation.initialRoute,
      routes: _appNavigation.routes,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}