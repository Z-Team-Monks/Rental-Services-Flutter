import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:rental/core/helpers/get_image_url.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/core/presentation/customSnackBar.dart';
import 'package:rental/features/auth/screens/auth_screen.dart';
import 'package:rental/features/property/bloc/update_property/update_property_bloc.dart';
import 'package:rental/features/property/screens/property_update/property_update_screen.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/data_providers/user_remote_data_provider.dart';
import 'package:rental/features/user/repository/user_repository.dart';
import 'package:rental/features/user/screens/profile/update_profile_screen.dart';
import 'package:rental/locator.dart';
import 'package:rental/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class ProfilePage extends StatelessWidget {
  // const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              getIt<SharedPreferences>().setString("token", "");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (c) => AuthPage(controller: SolidController()),
                  ),
                  (route) => false);
              // Navigator.popAndPushNamed(context, AuthPage.pageRoute);
            },
          ),
          IconButton(
            icon: Icon(Icons.restore_from_trash, color: Colors.black),
            onPressed: () async {
              var isDeleted = await UserRemoteDataProvider().deleteUser();
              if (isDeleted) {
                getIt<SharedPreferences>().setString("token", "");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (c) => AuthPage(controller: SolidController()),
                    ),
                    (route) => false);
              } else {
                final lunchBar = LunchBars(
                    lunchBarText: "Couldn't delete your account!",
                    event: LunchBarEvents.LunchBarError);
                ScaffoldMessenger.of(context).showSnackBar(lunchBar);
              }
            },
          )
        ],
        // leading: Icon(Icons.person, color: Colors.black26,),
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (_, state) {},
                  builder: (_, state) {
                    if (state is ProfileLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    getImageUrl(state.user.profileImage!)),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              infoTexts(state.user.email),
                              state.user.phoneNumber != null
                                  ? infoTexts(state.user.phoneNumber!)
                                  : Text(""),
                              Container(
                                width: 120,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            UpdateProfile(state.user),
                                      ),
                                    );
                                  },
                                  child: Text("Edit my profile"),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return CardSkeleton(
                      isCircularImage: true,
                      isBottomLinesActive: true,
                    );
                  },
                ),
                DefaultTabController(
                    length: 2, // length of tabs
                    initialIndex: 0,
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: Colors.green,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'Properties'),
                                  Tab(text: 'Liked'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: 400, //height of TabBarView
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.grey, width: 0.5))),
                                child: BlocConsumer<ProfileBloc, ProfileState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    if (state is ProfileLoaded) {
                                      final minePosts = state.user.posts ?? [];
                                      final favPosts =
                                          state.user.likedProperties ?? [];
                                      return TabBarView(children: <Widget>[
                                        GridView.count(
                                            crossAxisCount: 2,
                                            children: List.generate(
                                                minePosts.length, (index) {
                                              return MyPropertyCard(
                                                  size,
                                                  minePosts[index],
                                                  context,
                                                  true);
                                            })),
                                        GridView.count(
                                            crossAxisCount: 2,
                                            children: List.generate(
                                                favPosts.length, (index) {
                                              return MyPropertyCard(
                                                  size,
                                                  favPosts[index],
                                                  context,
                                                  false);
                                            })),
                                      ]);
                                    }
                                    return TabBarView(children: <Widget>[
//Widget
                                      CardPageSkeleton(
                                        totalLines: 5,
                                      ),
                                      CardPageSkeleton(
                                        totalLines: 5,
                                      ),
                                    ]);
                                  },
                                ))
                          ]),
                    )),
              ]),
        ),
      ),
    );
  }
}

Widget infoTexts(String txt) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Text(txt),
  );
}

// ignore: non_constant_identifier_names
Widget MyPropertyCard(
    Size size, dynamic property, BuildContext context, bool mine) {
  print(property);
  int likes = property["likedBy"].length;
  // property.likedBy.length;
  int comments = property["reviewes"].length;
  //property.reviewes.length;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    child: Column(
      children: [
        Stack(children: [
          Container(
            width: size.width * 0.55,
            height: size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(property["images"].length > 0
                    ? getImageUrl(property["images"][0])
                    : "https://images.unsplash.com/photo-1599809275671-b5942cabc7a2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVhbCUyMGVzdGF0ZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                // image: NetworkImage(
                // "https://images.unsplash.com/photo-1599809275671-b5942cabc7a2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVhbCUyMGVzdGF0ZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
              ),
            ),
          ),
          mine == false
              ? Text("")
              : Positioned(
                  right: 10.0,
                  top: 4.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      size: 28.0,
                      color: const Color.fromRGBO(218, 165, 32, 1.0),
                    ),
                    onPressed: () {
                      final updatePropertyBlock =
                          BlocProvider.of<UpdatePropertyBloc>(context);
                      updatePropertyBlock.add(UpdatePropertyLoadProperty(
                          productId: property["_id"]));
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              PropertyUpdateScreen(),
                        ),
                      );
                    },
                  ),
                )
        ]),
        Container(
          margin: EdgeInsets.only(left: 7, top: 7),
          // color: Colors.green,
          child: Row(
            children: [
              Icon(
                Icons.favorite,
              ),
              SizedBox(width: 2),
              Text(likes.toString()),
              SizedBox(width: 14),
              Icon(
                Icons.comment,
                color: Colors.black,
              ),
              SizedBox(width: 2),
              Text(comments.toString()),
            ],
          ),
        )
      ],
    ),
  );
}
