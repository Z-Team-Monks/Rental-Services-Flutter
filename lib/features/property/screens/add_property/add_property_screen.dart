import 'package:flutter/material.dart';

class AddProperty extends StatelessWidget {
  static const pageRoute = "/add_property";
  const AddProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Add post",
          style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Popins',
              letterSpacing: 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                // top: height * 0.06,
                left: width * 0.01,
                right: width * 0.01,
                bottom: height * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: width * 0.008,
                //     vertical: height * 0.008,
                //   ),
                //   child: Text(
                //     "Add property",
                //   style: TextStyle(
                //       fontSize: 25.0,
                //       fontWeight: FontWeight.bold,
                //       fontFamily: 'Popins',
                //       letterSpacing: 1),
                // ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.008,
                    vertical: height * 0.008,
                  ),
                  child: Text(
                    "Share a property you want to rent",
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.019,
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: width * 0.008,
                //     // vertical: height * 0.008,
                //   ),
                //   child: Text(
                //     "TITLE",
                //     style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.grey[600],
                //         letterSpacing: 1),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.008,
                    vertical: height * 0.008,
                  ),
                  child: TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'House',
                      labelText: 'Title',
                      hintStyle:
                          TextStyle(color: Colors.black54, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey[300],
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.transparent),
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
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: width * 0.008,
                //     // vertical: height * 0.008,
                //   ),
                //   child: Text(
                //     "DESCRIPTION",
                //     style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.grey[600],
                //         letterSpacing: 1),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.008,
                    vertical: height * 0.008,
                  ),
                  child: TextFormField(
                    autocorrect: true,
                    maxLines: 5,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'STANDARED G+2 APPARTMENT',
                      labelText: "Description",
                      hintStyle:
                          TextStyle(color: Colors.black54, letterSpacing: 1),
                      filled: true,
                      fillColor: Colors.grey[300],
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.transparent),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Price",
                          //   style: TextStyle(
                          //       fontSize: 20,
                          //       color: Colors.grey[600],
                          //       letterSpacing: 1),
                          // ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.01,
                          // ),
                          TextField(
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: '100K',
                              labelText: 'Price',
                              hintStyle: TextStyle(color: Colors.black54),
                              filled: true,
                              fillColor: Colors.grey[300],
                              enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
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
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: 'PER MONTH',
                              labelText: "Billing period",
                              hintStyle: TextStyle(color: Colors.black54),
                              filled: true,
                              fillColor: Colors.grey[300],
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  // borderSide: BorderSide(color: Colors.blue),
                                  ),
                            ),
                          ),
                        ],
                      ))
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
                        height: MediaQuery.of(context).size.height * 0.088,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Card(
                            color: Colors.grey[300],
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                  child: Text(
                                "Upload Image",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                ),
                              )),
                            )))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: SizedBox(
                    width: width * 0.8,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Submit',
                      ),
                    ),
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
