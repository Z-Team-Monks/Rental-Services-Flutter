import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: _buildShrineTheme(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Admin Page",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Image.asset('images/car-1.jpg'),
                  ListTile(
                    // leading: Icon(Icons.arrow_drop_down_circle),
                    title: const Text(
                      'Car',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ListTile(
                  // visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  // leading: Icon(Icons.map),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Price: ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          '10000',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  // ),
                  // ListTile(
                  //   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  // leading: Icon(Icons.photo_album),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Payment Range:',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'Per Month',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  // ),
                  // ListTile(
                  //   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  //   // leading: Icon(Icons.phone),
                  //   title: Text('Phone'),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Description: ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'Best rental product ever.',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Card(
                                    // elevation: 10,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                          child: Text(
                                        "Accept",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )))),
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Card(
                                    // elevation: 10,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                          child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Image.asset('assets/images/content/house-image.png'),
                  ListTile(
                    // leading: Icon(Icons.arrow_drop_down_circle),
                    title: const Text(
                      'House',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // ListTile(
                  // dense: true,
                  // contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  // visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  // leading: Icon(Icons.map),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Price: ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          '10000',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Payment Range:',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'Per Month',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  // ),
                  // ListTile(
                  //   visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  //   // leading: Icon(Icons.phone),
                  //   title: Text('Phone'),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Description: ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          'Best rental product ever.',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ],
                  ),
                  // ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Card(
                                    // elevation: 10,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                          child: Text(
                                        "Accept",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )))),
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Card(
                                    // elevation: 10,
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                          child: Text(
                                        "Reject",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )))),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.car_rental,
                  // color: Colors.grey[500],
                ),
                title: SizedBox(),
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.house_outlined,
                ),
                title: SizedBox(),
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
              ),
              title: SizedBox(),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: SizedBox(),
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_outlined,
              ),
              title: SizedBox(),
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[200],
          // selectedItemColor: Colors.orange,

          unselectedItemColor: Colors.grey[700],
          selectedFontSize: 14,
          unselectedFontSize: 14,
          // onTap: _onItemTapped,
          // currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          iconSize: 26,
          elevation: 5),
    );
  }
}

// Widget bottomSheet(BuildContext context) {
//   return BottomAppBar(
//     color: Colors.blue,
//     child: IconTheme(
//       data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Expanded(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 tooltip: 'Car',
//                 icon: const Icon(Icons.car_rental),
//                 onPressed: () {},
//               ),
//
//             ],
//           )),
//           Expanded(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 tooltip: 'House',
//                 icon: const Icon(Icons.house_outlined),
//                 onPressed: () {},
//               ),
//
//             ],
//           )),
//           Expanded(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 tooltip: 'Call',
//                 icon: Icon(Icons.call),
//                 onPressed: () {},
//               ),
//
//             ],
//           )),
//           Expanded(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 tooltip: 'Notification',
//                 icon: const Icon(Icons.notifications_rounded),
//                 onPressed: () {},
//               ),
//
//             ],
//           )),
//           Expanded(
//               child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 tooltip: 'Profile',
//                 icon: const Icon(Icons.person),
//                 onPressed: () {},
//               ),
//
//             ],
//           )),
//         ],
//       ),
//     ),
//   );
// }

// IconThemeData _customIconTheme(IconThemeData original) {
//   return original.copyWith(color: shrineBrown900);
// }

// ThemeData _buildShrineTheme() {
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     colorScheme: _shrineColorScheme,
//     accentColor: shrineBrown900,
//     primaryColor: shrinePink100,
//     buttonColor: shrinePink100,
//     scaffoldBackgroundColor: shrineBackgroundWhite,
//     cardColor: shrineBackgroundWhite,
//     textSelectionColor: shrinePink100,
//     errorColor: shrineErrorRed,
//     buttonTheme: const ButtonThemeData(
//       colorScheme: _shrineColorScheme,
//       textTheme: ButtonTextTheme.normal,
//     ),
//     primaryIconTheme: _customIconTheme(base.iconTheme),
//     textTheme: _buildShrineTextTheme(base.textTheme),
//     primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//     accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//     iconTheme: _customIconTheme(base.iconTheme),
//   );
// }

// TextTheme _buildShrineTextTheme(TextTheme base) {
//   return base
//       .copyWith(
//         headline: base.headline!.copyWith(
//           fontWeight: FontWeight.w500,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         title: base.title!.copyWith(
//           fontSize: 18,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         caption: base.caption!.copyWith(
//           fontWeight: FontWeight.w400,
//           fontSize: 14,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         body2: base.body2!.copyWith(
//           fontWeight: FontWeight.w500,
//           fontSize: 16,
//           letterSpacing: defaultLetterSpacing,
//         ),
//         body1: base.body1!.copyWith(
//           letterSpacing: defaultLetterSpacing,
//         ),
//         subhead: base.subhead!.copyWith(
//           letterSpacing: defaultLetterSpacing,
//         ),
//         display1: base.display1!.copyWith(
//           letterSpacing: defaultLetterSpacing,
//         ),
//         button: base.button!.copyWith(
//           fontWeight: FontWeight.w500,
//           fontSize: 14,
//           letterSpacing: defaultLetterSpacing,
//         ),
//       )
//       .apply(
//         fontFamily: 'Rubik',
//         displayColor: shrineBrown900,
//         bodyColor: shrineBrown900,
//       );
// }

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink100,
  primaryVariant: shrineBrown900,
  secondary: shrinePink50,
  secondaryVariant: shrineBrown900,
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);

const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
