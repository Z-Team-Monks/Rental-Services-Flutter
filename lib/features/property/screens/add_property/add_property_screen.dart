import 'package:flutter/material.dart';

class _AddProprty extends StatelessWidget {
  const _AddProprty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(
            top: 60.0, left: 10.0, right: 10.0, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add Post",
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Popins',
                    letterSpacing: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Share a property you want to share or rent",
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text(
                "TITLE",
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[600], letterSpacing: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text(
                "DESCRIPTION",
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[600], letterSpacing: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                        height: 8,
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
                    width: 5,
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
                        height: 8,
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text(
                "UPLOAD IMAGE",
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[600], letterSpacing: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autocorrect: true,
                decoration: InputDecoration(
                  hintText: 'IMAGE1',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {},
                  ),
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
              height: MediaQuery.of(context).size.height * 0.09,
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
