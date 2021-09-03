import 'package:flutter/material.dart';

class AddProperty extends StatelessWidget {
  static const pageRoute = "/add_property";
  const AddProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(
            top: height * 0.06,
            left: width * 0.01,
            right: width * 0.01,
            bottom: height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.008,
                vertical: height * 0.008,
              ),
              child: Text(
                "ADD POST",
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Popins',
                    letterSpacing: 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.008,
                vertical: height * 0.008,
              ),
              child: Text(
                "Share a property you want to share or rent",
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.019,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.008,
                // vertical: height * 0.008,
              ),
              child: Text(
                "TITLE",
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[600], letterSpacing: 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.008,
                vertical: height * 0.008,
              ),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'HOUSE',
                  hintStyle: TextStyle(color: Colors.black54, letterSpacing: 1),
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.008,
                // vertical: height * 0.008,
              ),
              child: Text(
                "DESCRIPTION",
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[600], letterSpacing: 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.008,
                vertical: height * 0.008,
              ),
              child: TextField(
                autocorrect: true,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'STANDARED G+2 APPARTMENT',
                  hintStyle: TextStyle(color: Colors.black54, letterSpacing: 1),
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
                      Text(
                        "PRICE",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      TextField(
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: '100K',
                          hintStyle: TextStyle(color: Colors.black54),
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
                      Text(
                        "BILLING PERIOD",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.019,
                      ),
                      TextField(
                        autocorrect: true,
                        decoration: InputDecoration(
                          hintText: 'PER MONTH',
                          hintStyle: TextStyle(color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey[300],
                          suffixIcon: Icon(Icons.arrow_drop_down),
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
                // vertical: height * 0.008,
              ),
              child: Text(
                "UPLOAD IMAGE",
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[600], letterSpacing: 1),
              ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                              child: Text(
                            "UPLAD IMAGE",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          )),
                        )))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                                child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                          )))),
            )
          ],
        ),
      ),
    );
  }
}
