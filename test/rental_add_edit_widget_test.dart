import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/blocs/image/image_bloc.dart';
import 'package:homerent/rental/data_providers/rental-data-provider.dart';
import 'package:homerent/rental/repository/rental-repository.dart';
import 'package:homerent/rental/screens/rental_add_update.dart';
import 'package:homerent/routes.dart';

void main() {
  testWidgets('Rental add edit widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RentalBloc(
                rentalRepository: RentalRepository(RentalDataProvider())),
          ),
          BlocProvider(
            create: (context) => ImageBloc(),
          ),
        ],
        child: AddUpdateRental(args: RentalArguments(edit: true)),
      ),
    ));

    var backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);

    var textform = find.byType(TextFormField);

    expect(textform, findsOneWidget);

    var addImageButton = find.byIcon(Icons.add);
    expect(addImageButton, findsOneWidget);

    var saveButton = find.byIcon(Icons.save);
    expect(saveButton, findsOneWidget);
    var image = find.byType(Image);
    expect(image, findsOneWidget);

    
  });
}
