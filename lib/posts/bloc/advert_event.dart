part of 'advert_bloc.dart';

abstract class AdvertEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AdvertFetched extends AdvertEvent {
  final String city;
  final String petType;
  final double amount;

  AdvertFetched(this.city, this.petType, this.amount);

  List<Object> get props => [city, petType, amount];
}
