import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:rental/core/models/user.dart';
import 'package:rental/features/user/bloc/profile_bloc/profile_bloc.dart';
import 'package:rental/features/user/screens/profile/update_profile_screen.dart';

class ProfilePage extends StatelessWidget {
  // const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profileBloc = BlocProvider.of<ProfileBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
                                    "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
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
                              infoTexts(state.user.phoneNumber!),
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
                                            UpdateProfile(),
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
                    length: 3, // length of tabs
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
                                  Tab(text: 'Wishlist'),
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
                                child: TabBarView(children: <Widget>[
                                  GridView.count(
                                      crossAxisCount: 2,
                                      children: List.generate(4, (index) {
                                        return PropertyCard(size);
                                      })),
                                  GridView.count(
                                      crossAxisCount: 2,
                                      children: List.generate(4, (index) {
                                        return PropertyCard(size);
                                      })),
                                  GridView.count(
                                      crossAxisCount: 2,
                                      children: List.generate(4, (index) {
                                        return PropertyCard(size);
                                      })),
                                ]))
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
Widget PropertyCard(Size size) {
  int likes = 1123;
  int comments = 200;

  return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: Column(
        children: [
          Container(
            width: size.width * 0.55,
            height: size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1599809275671-b5942cabc7a2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVhbCUyMGVzdGF0ZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
              ),
            ),
          ),
          // SizedBox(
          //   width: 200,
          //   height: 100,
          //   child: FittedBox(
          //     fit: BoxFit.cover,
          //     child: Image.network(
          //         "https://images.unsplash.com/photo-1599809275671-b5942cabc7a2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVhbCUyMGVzdGF0ZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
          //   ),
          // ),
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
      ));
}