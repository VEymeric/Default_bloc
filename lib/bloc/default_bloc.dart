import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'default_event.dart';
part 'default_state.dart';

class DefaultBloc extends Bloc<DefaultEvent, DefaultState> {
  DefaultBloc() : super(const DefaultState()) {
    on<DefaultEvent>((event, emit) {});
    on<OnDefaultUpdated>(_onDefaultUpdated);
  }

  Future<void> _onDefaultUpdated(
      OnDefaultUpdated event, Emitter<DefaultState> emit) async {
    emit(state.copyWith(status: DefaultStatus.loading));
    if (event.name == "") {
      emit(state.copyWith(status: DefaultStatus.error));
      return;
    }
    emit(state.copyWith(status: DefaultStatus.loaded, name: event.name));
  }
}
