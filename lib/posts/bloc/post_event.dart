part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {
  final String city;
  final String petType;
  final double amount;

  PostFetched(this.city, this.petType, this.amount);

  List<Object> get props => [city, petType, amount];
}
