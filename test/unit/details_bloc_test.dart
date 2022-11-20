import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_light/domain/use_case/get_detail_use_case.dart';
import 'package:numbers_light/ui/details/details_bloc.dart';
import 'package:numbers_light/ui/details/details_event.dart';
import 'package:numbers_light/ui/details/details_state.dart';
import 'package:numbers_light/ui/orientation/orientation_bloc.dart';
import 'package:numbers_light/ui/orientation/orientation_state.dart';

import 'details_bloc_test.mocks.dart';
import '../test_data/details_bloc_test_data.dart';
import '../util/extensions.dart';

@GenerateMocks([OrientationBloc, GetDetailUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testData = DetailsBlocTestData.instance;

  DetailsBloc? detailsBloc;
  MockOrientationBloc? mockOrientationBloc;
  MockGetDetailUseCase? mockGetDetailUseCase;

  setUp(() {
    mockOrientationBloc = MockOrientationBloc();
    mockGetDetailUseCase = MockGetDetailUseCase();
    when(mockOrientationBloc!.stream)
        .thenAnswer((_) => Stream.fromIterable([OrientationInitial()]));
    detailsBloc = DetailsBloc(
      mockOrientationBloc!,
      mockGetDetailUseCase!,
    );
  });

  tearDown(() {
    detailsBloc?.close();
    mockOrientationBloc?.close();
  });

  group('When bloc is created', () {
    blocTest<DetailsBloc, DetailsState>(
      'Then initial state is empty',
      build: () => detailsBloc!,
      expect: () => [],
    );
  });

  group('Given item is selected', () {
    group('When DetailsSelectedEvent is added', () {
      blocTest<DetailsBloc, DetailsState>(
        'Then the selected item is loaded',
        build: () => detailsBloc!,
        setUp: () {
          when(mockGetDetailUseCase!.execute(any))
              .thenAnswer((_) async => testData.selectionDomainResult);
        },
        act: (detailsBloc) => detailsBloc.add(DetailsSelectedEvent("1")),
        expect: () => [isA<DetailsLoadingState>(), isA<DetailsLoadedState>()],
      );
    });

    group('When DetailsSelectedEvent is added and some error happened', () {
      blocTest<DetailsBloc, DetailsState>(
        'Then the selected item could not be loaded and DetailsErrorState is shown',
        build: () => detailsBloc!,
        setUp: () {
          when(mockGetDetailUseCase!.execute(any))
              .thenAnswer((_) async => testData.selectionDomainError);
        },
        act: (detailsBloc) => detailsBloc.add(DetailsSelectedEvent("1")),
        expect: () => [isA<DetailsLoadingState>(), isA<DetailsErrorState>()],
      );
    });
  });

  group('Given item was loaded', () {
    group('When orientation is changed to landscape', () {
      blocTest<DetailsBloc, DetailsState>(
        'Then DetailsNavigateBack is issued',
        build: () => detailsBloc!,
        setUp: () {
          when(mockGetDetailUseCase!.execute(any))
              .thenAnswer((_) async => testData.selectionDomainResult);
        },
        act: (detailsBloc) {
          detailsBloc.add(DetailsSelectedEvent("1"));
          detailsBloc.add(DetailsOrientationEvent(Orientation.landscape));
        },
        expect: () => [
          isA<DetailsLoadingState>(),
          isA<DetailsLoadedState>(),
          isA<DetailsNavigateBack>(),
        ],
      );
    });

    group('When orientation is changed to portrait', () {
      blocTest<DetailsBloc, DetailsState>(
        'Then there is no back navigation',
        build: () => detailsBloc!,
        setUp: () {
          when(mockGetDetailUseCase!.execute(any))
              .thenAnswer((_) async => testData.selectionDomainResult);
        },
        act: (detailsBloc) => detailsBloc.add(DetailsSelectedEvent("1")),
        expect: () => [isA<DetailsLoadingState>(), isA<DetailsLoadedState>()],
      );
    });
  });

  group('Given item loading failed because of not internet', () {
    group('When orientation is changed to landscape', () {
      blocTest<DetailsBloc, DetailsState>(
        'Then DetailsNavigateBack is issued',
        build: () => detailsBloc!,
        setUp: () {
          when(mockGetDetailUseCase!.execute(any))
              .thenAnswer((_) async => testData.selectionDomainError);
        },
        act: (detailsBloc) {
          detailsBloc.add(DetailsSelectedEvent("1"));
          detailsBloc.add(DetailsOrientationEvent(Orientation.landscape));
        },
        expect: () => [
          isA<DetailsLoadingState>(),
          isA<DetailsErrorState>(),
          isA<DetailsNavigateBack>(),
        ],
      );
    });

    group('When user taps on refresh button and the internet is reachable', () {
      blocTest<DetailsBloc, DetailsState>(
        'Then the item is loaded',
        build: () => detailsBloc!,
        setUp: () {
          when(mockGetDetailUseCase!.execute(any)).thenAnwserInOrder([
            Future.value(testData.selectionDomainError),
            Future.value(testData.selectionDomainResult)
          ]);
        },
        act: (detailsBloc) {
          detailsBloc.add(DetailsSelectedEvent("1"));
          detailsBloc.add(DetailsRefreshedEvent());
        },
        expect: () => [
          isA<DetailsLoadingState>(),
          isA<DetailsErrorState>(),
          isA<DetailsLoadingState>(),
          isA<DetailsLoadedState>(),
        ],
      );
    });
  });
}
