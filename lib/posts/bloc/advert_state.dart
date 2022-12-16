part of 'advert_bloc.dart';

enum AdvertStatus { initial, success, failure }

class AdvertState extends Equatable {
  const AdvertState({
    this.status = AdvertStatus.initial,
    this.adverts = const <AdvertModel>[],
    this.hasReachedMax = false,
  });

  final AdvertStatus status;
  final List<AdvertModel> adverts;
  final bool hasReachedMax;

  AdvertState copyWith({
    AdvertStatus? status,
    List<AdvertModel>? posts,
    bool? hasReachedMax,
  }) {
    return AdvertState(
      status: status ?? this.status,
      adverts: posts ?? this.adverts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''AdvertState { status: $status, hasReachedMax: $hasReachedMax, posts: ${adverts.length} }''';
  }

  @override
  List<Object> get props => [status, adverts, hasReachedMax];
}
