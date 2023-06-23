import 'package:homerent/rental/data_providers/rental-data-provider.dart';
import 'package:homerent/rental/models/rental.dart';

class RentalRepository {
  final RentalDataProvider dataProvider;
  RentalRepository(this.dataProvider);

  Future<int> create(Rental course) async {
    print("Repository create");
    return this.dataProvider.create(course);
  }

  Future<int> update(String id, Rental rental) async {
    print("UPdate repositorycalled");
    print(id);
    return this.dataProvider.update(id, rental);
  }

  Future<List<Rental>> viewAll() async {
    return this.dataProvider.viewAll();
  }

  Future<List<Rental>> viewMyProperties() async {
    return this.dataProvider.viewMyProperties();
  }

  Future<void> delete(String id) async {
    this.dataProvider.delete(id);
  }
}