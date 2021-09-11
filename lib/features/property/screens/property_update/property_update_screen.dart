import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/core/presentation/customSnackBar.dart';
import 'package:rental/core/validators/InputFormValidators.dart';
import 'package:rental/features/property/bloc/property_add/property_add_bloc.dart';
import 'package:rental/features/property/bloc/update_property/update_property_bloc.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';

class PropertyUpdateScreen extends StatefulWidget with InputValidationMixin {
  static const pageRoute = "/add_property";

  @override
  State<PropertyUpdateScreen> createState() => _PropertyUpdateState();
  int shouldChange = 0;
}

class _PropertyUpdateState extends State<PropertyUpdateScreen>
    with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();

  String? categoryValue = "House";
  String? perValue = "Month";

  final titleTextController = new TextEditingController(text: "House");
  final descriptionTextController =
      new TextEditingController(text: "A big house");
  final priceTextController = new TextEditingController(text: "400");

  @override
  Widget build(BuildContext context) {
    final propertyUpdateBloc = BlocProvider.of<UpdatePropertyBloc>(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          "Update property",
          style: TextStyle(
              fontSize: 25.0,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontFamily: 'Popins',
              letterSpacing: 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.01),
            child: BlocConsumer<UpdatePropertyBloc, UpdatePropertyState>(
                listener: (context, state) {
              if (state is UpdatePropertyLoadedProperty) {
                if (state.isUpdated == false) {
                  final lunchBar = LunchBars(
                      lunchBarText: "Couldn't update property",
                      event: LunchBarEvents.LunchBarSuccess);
                  ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                }

                if (state.isUpdated == true) {
                  final lunchBar = LunchBars(
                      lunchBarText: "Product updated",
                      event: LunchBarEvents.LunchBarError);
                  ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                }
              }
            }, builder: (context, state) {
              if (state is UpdatePropertyLoadingProperty) {
                return Center(
                  child: CardPageSkeleton(
                    totalLines: 10,
                  ),
                );
              }
              if (state is UpdatePropertyLoadedProperty) {
                widget.shouldChange += 1;
                if (widget.shouldChange == 1) {
                  categoryValue = state.property.category;
                  perValue = state.property.per;
                  titleTextController.text = state.property.title;
                  descriptionTextController.text = state.property.description;
                  priceTextController.text = state.property.bill.toString();
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.019,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.008,
                          vertical: height * 0.008,
                        ),
                        child: TextFormField(
                          autocorrect: true,
                          controller: titleTextController,
                          validator: (name) {
                            if (this.isTextValid(name!)) {
                              return null;
                            }
                            return "Please provide a title for your property";
                          },
                          decoration: InputDecoration(
                            hintText: 'House',
                            labelText: 'Title',
                            hintStyle: TextStyle(
                                color: Colors.black54, letterSpacing: 1),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal),
                            ),
                            fillColor: Colors.white24,
                            enabledBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                            focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                // borderSide: BorderSide(color: Colors.blue),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.019,
                      ),
                      Column(
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(fontSize: 13),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: width * 0.008,
                              top: width * 0.008,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink),
                              borderRadius: BorderRadius.circular(3.0),
                              // color: Colors.grey[300],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.008,
                                vertical: height * 0.008,
                              ),
                              child: DropdownButton<String>(
                                value: state
                                    .property.category, //"state.dropdownValue",
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black54),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    state.property.category = newValue!;
                                  });
                                },
                                items: <String>[
                                  'House',
                                  'Car',
                                  'Other'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.019,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.008,
                          vertical: height * 0.008,
                        ),
                        child: TextFormField(
                          autocorrect: true,
                          controller: descriptionTextController,
                          validator: (name) {
                            if (this.isTextValid(name!)) {
                              return null;
                            }
                            return "Please provide a description of your property";
                          },
                          maxLines: 2,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            hintText: 'STANDARED G+2 APPARTMENT',
                            labelText: "Description",
                            hintStyle: TextStyle(
                                color: Colors.black54, letterSpacing: 1),
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal),
                            ),
                            fillColor: Colors.white24,
                            enabledBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.pink),
                            ),
                            focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                // borderSide: BorderSide(color: Colors.transparent),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.019,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.008,
                          vertical: height * 0.008,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  autocorrect: true,
                                  keyboardType: TextInputType.number,
                                  controller: priceTextController,
                                  validator: (price) {
                                    if (this.isPriceValid(price)) {
                                      return null;
                                    }
                                    return "Please provide a valid price of your property";
                                  },
                                  decoration: InputDecoration(
                                    hintText: '100K',
                                    labelText: 'Price',
                                    hintStyle: TextStyle(color: Colors.black54),
                                    filled: true,
                                    border: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.teal),
                                    ),
                                    fillColor: Colors.white24,
                                    enabledBorder: OutlineInputBorder(
                                      // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      borderSide:
                                          BorderSide(color: Colors.pink),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        // borderSide: BorderSide(color: Colors.blue),
                                        ),
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink),
                                borderRadius: BorderRadius.circular(3.0),
                                color: Colors.white24,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.008,
                                  vertical: height * 0.008,
                                ),
                                child: DropdownButton<String>(
                                  value: state
                                      .property.per, //"state.dropdownValue",
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black54),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      state.property.per = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Month',
                                    'Minute',
                                    'Hour',
                                    'Day',
                                    'Year'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.019,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Center(
                          child: SizedBox(
                            width: width * 0.8,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                widget.shouldChange = 0;
                                propertyUpdateBloc.add(UpdatePropertyUpdate(
                                    property: new Property(
                                        id: state.property.id,
                                        title: titleTextController.text,
                                        description:
                                            descriptionTextController.text,
                                        category: state.property.category,
                                        bill: double.tryParse(
                                            priceTextController.text)!,
                                        per: state.property.per,
                                        images: state.property.images)));
                              },
                              child: const Text(
                                'Update',
                              ),
                            ),
                          ),
                        ),
                      ),
                      state.isLoading
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Text(""),
                    ],
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text("Network error!"),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
