import 'package:flutter/material.dart';
import 'package:homerent/rental/repository/rental-repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'rental_event.dart';
import 'rental_state.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  final RentalRepository rentalRepository;

  RentalBloc({required this.rentalRepository}) : super(RentalLoading());

  @override
  Stream<RentalState> mapEventToState(RentalEvent event) async* {
    if (event is RentalLoadAll) {
      yield RentalLoading();
      try {
        final courses = await rentalRepository.viewAll();
        yield RentalOperationSuccess(courses);
      } catch (_) {
        yield RentalOperationFailure();
      }
    }

    if (event is RentalLoadMyProperties) {
      yield RentalLoading();
      try {
        final courses = await rentalRepository.viewMyProperties();
        yield RentalOperationSuccess(courses);
      } catch (_) {
        yield RentalOperationFailure();
      }
    }

    if (event is RentalCreate) {
      try {
        await rentalRepository.create(event.rental);
        print(event.rental);
        final courses = await rentalRepository.viewAll();
        yield RentalOperationSuccess(courses);
      } catch (_) {
        print("Bloc error");
        yield RentalOperationFailure();
      }
    }

    if (event is RentalUpdate) {
      try {
        print("Update event called");
        print(event.id);
        await rentalRepository.update(event.id, event.rental);
        final courses = await rentalRepository.viewAll();
        yield RentalOperationSuccess(courses);
      } catch (_) {
        print("Update event failure");
        yield RentalOperationFailure();
      }
    }

    if (event is RentalDelete) {
      try {
        await rentalRepository.delete(event.id);
        final courses = await rentalRepository.viewAll();
        yield RentalOperationSuccess(courses);
      } catch (_) {
        yield RentalOperationFailure();
      }
    }
  }
}