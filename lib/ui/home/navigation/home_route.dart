import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:numbers_light/ui/home/home_bloc.dart';
import 'package:numbers_light/ui/home/home_event.dart';
import 'package:numbers_light/ui/home/home_screen.dart';

class HomeRoute {
  static const home = '/';

  Map<String, WidgetBuilder> get routes => {
        home: (context) => BlocProvider(
              create: (_) => GetIt.I.get<HomeBloc>()..add(HomeCreated()),
              child: const HomeScreen(),
            )
      };
}
