import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/core/presentation/customSnackBar.dart';
import 'package:rental/features/admin/cubit/admin_cubit.dart';

class AdminPage extends StatefulWidget {
  static const pageRoute = "/admin";
  AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Property> prevList = [];

  void showSnakBar(BuildContext context, String message) {
    final lunchBar =
        LunchBars(lunchBarText: message, event: LunchBarEvents.LunchBarSuccess);
    ScaffoldMessenger.of(context).showSnackBar(lunchBar);
  }

  Widget build(BuildContext context) {
    final adminCubit = BlocProvider.of<AdminCubit>(context)..fetchPosts();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Admin Page"),
        ),
        backgroundColor: Colors.grey[50],
        body: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            return state.maybeMap(
              fetchingPosts: (fetching) => CircularProgressIndicator(),
              postFetchFailure: (error) {
                showSnakBar(context, "Error: ${error.errorMessage}");
                adminCubit.fetchPosts();
                return CircularProgressIndicator();
              },
              postFetchSuccess: (data) =>
                  propertyList(context, data.properties),
              rejectApproveError: (err) {
                showSnakBar(context, err.errorMessage);
                return propertyList(context, prevList);
              },
              rejectApproveOk: (ok) {
                showSnakBar(context, "Approved Post!");
                adminCubit.fetchPosts();
                return CircularProgressIndicator();
              },
              orElse: () {
                return Center(child: Text("Unkown Error"));
              },
            );
          },
        ),
      ),
    );
  }
}

Widget propertyList(BuildContext context, List<Property> properties) {
  return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: properties.length,
      itemBuilder: (BuildContext context, int index) {
        return listItem(context, properties[index]);
      });
}

Widget listItem(BuildContext context, Property property) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/content/house_bg.png"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ),
        ListTile(
          title: Text(
            '${property.title}',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
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
                '${property.bill}',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                '${property.per}',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
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
                'Description: ',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                '${property.description}',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
        property.status.toString() == "pending"
            ? ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<AdminCubit>()
                              .approvePost("6139bbd54cd1c14db8d43bfc");
                        },
                        child: Text(
                          "Accept",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<AdminCubit>()
                              .disapprovePost("6139bbd54cd1c14db8d43bfc");
                        },
                        child: Text(
                          "Reject",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              )
            : Text('Status: ${property.status}'),
      ],
    ),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme,
    accentColor: shrineBrown900,
    primaryColor: shrinePink100,
    buttonColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionColor: shrinePink100,
    errorColor: shrineErrorRed,
    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline!.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: defaultLetterSpacing,
        ),
        title: base.title!.copyWith(
          fontSize: 18,
          letterSpacing: defaultLetterSpacing,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        body2: base.body2!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: defaultLetterSpacing,
        ),
        body1: base.body1!.copyWith(
          letterSpacing: defaultLetterSpacing,
        ),
        subhead: base.subhead!.copyWith(
          letterSpacing: defaultLetterSpacing,
        ),
        display1: base.display1!.copyWith(
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

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