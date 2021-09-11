import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/core/presentation/customSnackBar.dart';
import 'package:rental/core/validators/InputFormValidators.dart';
import 'package:rental/features/property/bloc/property_add/property_add_bloc.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';

class AddProperty extends StatefulWidget with InputValidationMixin {
  static const pageRoute = "/add_property";

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  List<XFile>? images;

  String? categoryValue = "House";

  final titleTextController = new TextEditingController(text: "House");

  final descriptionTextController =
      new TextEditingController(text: "A big house");

  final priceTextController = new TextEditingController(text: "400");

  @override
  Widget build(BuildContext context) {
    final propertyAddBloc = BlocProvider.of<PropertyAddBloc>(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: Icon(Icons.person, color: Colors.black26,),
        backgroundColor: Colors.white,
        title: Text(
          'Add property',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                // top: height * 0.06,
                left: width * 0.04,
                right: width * 0.04,
                bottom: height * 0.01),
            child: BlocConsumer<PropertyAddBloc, PropertyAddState>(
              listener: (context, state) {
                if (state.propertyState.submitSuccess) {
                  final lunchBar = LunchBars(
                      lunchBarText: "Product is being reviewed by our team!",
                      event: LunchBarEvents.LunchBarSuccess);
                  ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                }
                if (state.propertyState.submitFailure) {
                  final lunchBar = LunchBars(
                      lunchBarText:
                          "Couldn't register your property try later!",
                      event: LunchBarEvents.LunchBarError);
                  ScaffoldMessenger.of(context).showSnackBar(lunchBar);
                }
              },
              builder: (context, state) {
                // print("Rebuilding");
                // print(state.propertyState.category);
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
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            hintStyle: TextStyle(
                                color: Colors.black54, letterSpacing: 1),
                            filled: true,
                            // border: new OutlineInputBorder(
                            // borderSide: new BorderSide(color: Colors.pink),
                            // ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.pinkAccent),
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
                                value: categoryValue, //"state.dropdownValue",
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black54),
                                onChanged: (String? newValue) {
                                  // print("New value");
                                  // print(newValue);
                                  setState(() {
                                    categoryValue = newValue;
                                  });
                                  // propertyAddBloc
                                  //     .add(PropertyAddChangeCategoryDropDown(
                                  //   properyEventValue:
                                  //       new AddPropertyFormEventValue(
                                  //           dropdownValue: state
                                  //               .propertyState.dropdownValue,
                                  //           images: state.propertyState.images,
                                  //           category: "Random shit"),
                                  // ));
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
                                            new BorderSide(color: Colors.teal)),
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
                                border: Border.all(
                                  color: Colors.pink,
                                ),
                                borderRadius: BorderRadius.circular(3.0),
                                // color: Colors.grey[300],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.008,
                                  vertical: height * 0.008,
                                ),
                                child: DropdownButton<String>(
                                  value: state.propertyState
                                      .dropdownValue, //"state.dropdownValue",
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black54),
                                  onChanged: (String? newValue) {
                                    propertyAddBloc
                                        .add(PropertyAddChangePerDropDown(
                                      properyEventValue:
                                          new AddPropertyFormEventValue(
                                              dropdownValue: newValue!,
                                              images:
                                                  state.propertyState.images,
                                              category:
                                                  state.propertyState.category),
                                    ));
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
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.008,
                            vertical: height * 0.008,
                          ),
                          child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.088,
                              width: MediaQuery.of(context).size.width * 1,
                              child: GestureDetector(
                                onTap: () async {
                                  images = await _picker.pickMultiImage();
                                  if (images != null) {
                                    propertyAddBloc.add(PropertyAddImages(
                                      properyEventValue:
                                          new AddPropertyFormEventValue(
                                              dropdownValue: state
                                                  .propertyState.dropdownValue,
                                              images: images!,
                                              category:
                                                  state.propertyState.category),
                                    ));
                                  }
                                },
                                child: Card(
                                  color: Colors.grey[300],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Center(
                                        child: Text(
                                      "Upload Images",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18,
                                      ),
                                    )),
                                  ),
                                ),
                              ))),
                      state.propertyState.images.length == 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text("No images provided")),
                            )
                          : SizedBox(
                              height: 100,
                              child: Center(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.propertyState.images.length,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Image.file(
                                          File(state.propertyState.images[index]
                                              .path),
                                          fit: BoxFit.cover),
                                    );
                                  },
                                ),
                              ),
                            ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Center(
                        child: state.propertyState.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: width * 0.8,
                                height: 50,
                                child: TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (state.propertyState.images.length ==
                                          0) {
                                        final lunchBar = LunchBars(
                                            lunchBarText:
                                                "Please provide at least one image",
                                            event:
                                                LunchBarEvents.LunchBarError);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(lunchBar);
                                        return;
                                      }
                                      final property = new Property(
                                          title: titleTextController.text,
                                          description:
                                              descriptionTextController.text,
                                          category: "House",
                                          bill: double.tryParse(
                                              priceTextController.text)!,
                                          per:
                                              state.propertyState.dropdownValue,
                                          images: []);
                                      propertyAddBloc.add(PropertyAddRemote(
                                        images: state.propertyState.images,
                                        properyEventValue:
                                            new AddPropertyFormEventValue(
                                                dropdownValue: state
                                                    .propertyState
                                                    .dropdownValue,
                                                images:
                                                    state.propertyState.images,
                                                category: categoryValue!),
                                        property: property,
                                      ));
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
