import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:numbers_light/getit_root.dart';
import 'package:numbers_light/navigation/app_navigation.dart';
import 'package:numbers_light/ui/details/details_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_widget.dart';

late AppNavigation _appNavigation;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  _appNavigation = GetIt.I.get<AppNavigation>();
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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I.get<OrientationBloc>(),),
        BlocProvider(create: (context) => GetIt.I.get<DetailsBloc>()),
      ],
      child: OrientationWidget(
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: _navigatorKey,
          initialRoute: AppNavigation.initialRoute,
          routes: _appNavigation.routes,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
  }
}