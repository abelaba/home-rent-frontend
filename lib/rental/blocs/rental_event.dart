import 'package:homerent/rental/models/rental.dart';
import 'package:equatable/equatable.dart';

abstract class RentalEvent extends Equatable {
  const RentalEvent();
}

class RentalLoadAll extends RentalEvent {
  const RentalLoadAll();

  @override
  List<Object> get props => [];
}

class RentalLoadMyProperties extends RentalEvent {
  const RentalLoadMyProperties();

  @override
  List<Object> get props => [];
}

class RentalCreate extends RentalEvent {
  final Rental rental;

  const RentalCreate(this.rental);

  @override
  List<Object> get props => [rental];

  @override
  String toString() => 'Property Created {rental: $rental}';
}

class RentalUpdate extends RentalEvent {
  final String id;
  final Rental rental;

  const RentalUpdate(this.rental, this.id);

  @override
  List<Object> get props => [rental];

  @override
  String toString() => 'Rental Updated {rental: $rental}';
}

class RentalDelete extends RentalEvent {
  final String id;

  const RentalDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Course Deleted {course Id: $id}';
}