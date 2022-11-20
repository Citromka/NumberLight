import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_light/ui/details/details_bloc.dart';
import 'package:numbers_light/ui/details/details_state.dart';
import 'package:numbers_light/ui/home/home_bloc.dart';
import 'package:numbers_light/ui/home/home_state.dart';
import 'package:numbers_light/ui/home/model/number_light_selection_state.dart';
import 'package:numbers_light/ui/home/widgets/number_list_item.dart';
import 'package:numbers_light/ui/orientation/orientation_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../util/ui_test_utils.dart';
import 'home_screen_golden_test.mocks.dart';
import 'test_cache_manager.dart';

@GenerateMocks([DetailsBloc, OrientationBloc, HomeBloc])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  DetailsBloc? detailsBloc;
  OrientationBloc? orientationBloc;
  HomeBloc? homeBloc;

  setUp(() async {
    detailsBloc = MockDetailsBloc();
    orientationBloc = MockOrientationBloc();
    homeBloc = MockHomeBloc();
    GetIt.instance.registerSingleton<BaseCacheManager>(
      MockCacheManager(),
    );
    when(orientationBloc!.stream)
        .thenAnswer((_) => Stream.fromIterable([OrientationInitial()]));
    when(detailsBloc!.stream)
        .thenAnswer((_) => Stream.fromIterable([DetailsInitialState()]));
    when(homeBloc!.stream)
        .thenAnswer((_) => Stream.fromIterable([HomeInitialState()]));
    await loadFonts();
  });

  Future<void> _testWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              return NumberListItem(
                name: "1",
                imageUrl: "",
                state: NumberLightSelectionState.normal,
                onSelect: (item) {},
              );
            },
          ),
        ),
      ),
    );
  }

  testWidgets('Home list test', (WidgetTester tester) async {
    await configureScreenSize(tester);
    await tester.runAsync(() async {
      await _testWidget(tester);
      // Wait for the image to be loaded.
      await Future<void>.delayed(const Duration(seconds: 5));
      await tester.pump();
    });

    await tester.pump();

    final element = tester.element(find.byType(Image));
    final Image widget = element.widget as Image;

    await precacheImage(widget.image, element);

    await tester.pumpAndSettle();
    await expectLater(
        find.byType(NumberListItem), matchesGoldenFile('number_list_item.png'));
  });
}
