// import 'dart:io';

import 'dart:io';

import 'package:homerent/rental/blocs/blocs.dart';
import 'package:homerent/rental/blocs/image/image_bloc.dart';
import 'package:homerent/rental/models/rental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homerent/rental/screens/HomeScreen.dart';
import 'package:homerent/settings/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes.dart';
import 'rental_list.dart';

class AddUpdateRental extends StatefulWidget {
  static const routeName = 'courseAddUpdate';
  final RentalArguments args;

  AddUpdateRental({required this.args});
  @override
  _AddUpdateRentalState createState() => _AddUpdateRentalState();
}

class _AddUpdateRentalState extends State<AddUpdateRental> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Map<String, dynamic> _course = {};

  Future<void> _onAddPhotoClicked(context) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    _course["rentalImage"] = image;
  }

  @override
  void initState() {
    super.initState();
    if (widget.args.edit) {
      _course["address"] = widget.args.rental?.address;
      _course["type"] = widget.args.rental?.type;
      _course["price"] = widget.args.rental?.price;
      _course["bedrooms"] = widget.args.rental?.bedrooms;
      _course["bathrooms"] = widget.args.rental?.bathrooms;
      _course["area"] = widget.args.rental?.area;
      _course["rentalImage"] = widget.args.rental?.rentalImage;
    } else {
      _course["address"] = '';
      _course["type"] = '';
      _course["price"] = '';
      _course["bedrooms"] = '';
      _course["bathrooms"] = '';
      _course["area"] = '';
      _course["rentalImage"] = '';
    }
  }


  Widget _textFormField(String key, String validatorText, String hintText, String onSaved, String? initialValue){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
            key: ValueKey(key),
            initialValue:
                initialValue != '' ? initialValue : '',
            validator: (value) {
              if (value != null && value.isEmpty) {
                return validatorText;
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Colors.grey.shade100,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: hintText,
              
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
            onSaved: (value) {
              setState(() {
                this._course[onSaved] = value;
              });
            }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title:
            Text('${widget.args.edit ? "Edit Property" : "Add New property"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _textFormField("address", "Please enter address", "Address", "address", widget.args.edit ? widget.args.rental?.address : ''),
                _textFormField("type", "Please enter type", "Type", "type", widget.args.edit ? widget.args.rental?.type : ''),
                _textFormField("price", "Please enter price", "Price", "price", widget.args.edit ? widget.args.rental?.price.toString() : ''),
                _textFormField("bedrooms", "Please enter bedrooms", "Bedrooms", "bedrooms", widget.args.edit ? widget.args.rental?.bedrooms.toString() : ''),
                _textFormField("bathrooms", "Please enter bathrooms", "Bathrooms", "bathrooms", widget.args.edit ? widget.args.rental?.bathrooms.toString() : ''),
                // _textFormField("price", "Please enter price", "Price", "price", widget.args.edit ? widget.args.rental?.address : ''),
                _textFormField("area", "Please enter total area", "Total area(m2)", "area", widget.args.edit ? widget.args.rental?.area.toString() : ''),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: 200,
                    child: BlocBuilder<ImageBloc, ImageState>(
                      builder: (context, state) {
                        var image = widget.args.rental?.rentalImage;
                        if (image != null && state is ImageInitial) {
                          print("MY IMAGE $image");
                          return Image.network("${Constants.baseURL}/${image}");
                        } else if (state is ImageUploaded) {
                          print(this._course["rentalImage"]);
                          return Image.file(
                            File(this._course["rentalImage"].path),
                            height: 500,
                          );
                        }
          
                        return Image.asset(
                          "./assets/images/placeholder.jpg",
                          height: 300,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                ElevatedButton(
                    key: const ValueKey("addimage"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 12),
                    ),
                    onPressed: () async {
                      await _onAddPhotoClicked(context);
                      BlocProvider.of<ImageBloc>(context).add(UploadImage());
                      // print(_course["rentalImage"]);
                    },
                    child: Icon(Icons.add)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 130, vertical: 12),
                    ),
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form != null && form.validate()) {
                        form.save();
                        final rental = Rental(
                                    address: this._course["address"],
                                    rentalImage: this._course["rentalImage"],
                                    type: this._course["type"],        // Add type field
                                    bedrooms: int.parse(this._course["bedrooms"]),    // Add bedrooms field
                                    bathrooms: int.parse(this._course["bathrooms"]),  // Add bathrooms field
                                    area: int.parse(this._course["area"]),         // Add area field
                                    price: int.parse(this._course["price"]),       // Add price field
                        );
                        final RentalEvent event = widget.args.edit
                            ? RentalUpdate(
                                  rental,
                                  widget.args.rental!.sId!,
                                )
                              : RentalCreate(
                                  rental
                                );
                        BlocProvider.of<RentalBloc>(context).add(event);
                        BlocProvider.of<ImageBloc>(context).add(UsePlaceHolder());
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                      }
                    },
                    child: Text('SAVE'),
                    
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
