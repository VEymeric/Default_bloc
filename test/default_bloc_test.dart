// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:checkbox_bloc/bloc/default_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DefaultBloc defaultBloc;

  String defaultValueName = "test";
  String initialValue = "Anonymous";

  setUp(() {
    defaultBloc = DefaultBloc();
  });

  test(
    'initial state should be empty',
    () {
      expect(defaultBloc.state.status, DefaultStatus.init);
      expect(defaultBloc.state.name, initialValue);
    },
  );

  test(
    'check if copywith can change status',
    () {
      expect(defaultBloc.state.copyWith(status: DefaultStatus.loaded).status,
          DefaultStatus.loaded);
    },
  );

  test('Validate equality for DefaultState', () {
    expect(const DefaultState(name: "Bob"),
        equals(const DefaultState(name: "Bob")));
  });

  test('Validate event OnDefaultUpdated equality', () {
    const event = OnDefaultUpdated('name');
    expect(event.props, ['name']);

    expect(
        const OnDefaultUpdated('name'), equals(const OnDefaultUpdated('name')));
  });

  test('Check status extension on DefaultState', () {
    expect(DefaultStatus.init.isInit, true);
    expect(DefaultStatus.init.isError, false);
    expect(DefaultStatus.error.isError, true);
    expect(DefaultStatus.loaded.isLoaded, true);
    expect(DefaultStatus.loading.isLoading, false);
    expect(DefaultStatus.error.isLoading, false);
  });

  blocTest<DefaultBloc, DefaultState>(
    'should emit [loading, has data] when data is gotten successfully',
    build: () => DefaultBloc()..add(OnDefaultUpdated(defaultValueName)),
    act: (bloc) => bloc,
    wait: const Duration(microseconds: 100),
    expect: () => [
      DefaultState(status: DefaultStatus.loading, name: initialValue),
      DefaultState(status: DefaultStatus.loaded, name: defaultValueName)
    ],
  );

  blocTest<DefaultBloc, DefaultState>(
    'should emit error when data is empty',
    build: () => DefaultBloc()..add(const OnDefaultUpdated("")),
    act: (bloc) => bloc,
    wait: const Duration(microseconds: 100),
    expect: () => [
      DefaultState(status: DefaultStatus.loading, name: initialValue),
      const DefaultState(status: DefaultStatus.error)
    ],
  );
}
