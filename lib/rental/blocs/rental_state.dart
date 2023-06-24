import 'package:homerent/rental/models/rental.dart';
import 'package:equatable/equatable.dart';

abstract class RentalState extends Equatable {
  const RentalState();

  @override
  List<Object> get props => [];
}

class RentalLoading extends RentalState {}

class RentalOperationSuccess extends RentalState {
  final Iterable<Rental> rentals;

  RentalOperationSuccess([this.rentals = const []]);

  @override
  List<Object> get props => [rentals];
}

class RentalOperationFailure extends RentalState {}