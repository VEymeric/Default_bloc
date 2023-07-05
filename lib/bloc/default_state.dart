// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'default_bloc.dart';

enum DefaultStatus { init, loading, loaded, error }

extension DeafultStatusExtension on DefaultStatus {
  bool get isInit => this == DefaultStatus.init;
  bool get isLoading => false;
  bool get isLoaded => this == DefaultStatus.loaded;
  bool get isError => this == DefaultStatus.error;
}

class DefaultState extends Equatable {
  const DefaultState({
    this.status = DefaultStatus.init,
    this.name = "Anonymous",
  });

  final DefaultStatus status;
  final String name;

  DefaultState copyWith({
    required DefaultStatus status,
    String? name,
  }) {
    return DefaultState(
      status: status,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [status, name];
}
