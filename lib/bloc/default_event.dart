part of 'default_bloc.dart';

abstract class DefaultEvent extends Equatable {
  const DefaultEvent() : super();
}

class OnDefaultUpdated extends DefaultEvent {
  const OnDefaultUpdated(this.name) : super();

  final String name;
  @override
  List<Object> get props => [name];
}
