import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/bloc/Ads/ads_bloc.dart';
import 'package:rental/features/property/bloc/property_bloc.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:rental/locator.dart';
import 'package:telephony/telephony.dart';
// import 'dart:math' as math;

import './components/feed_card.dart';
import './components/recomeded.dart';

class HomeFeed extends StatelessWidget {
  static const pageRoute = "/feed";

  @override
  Widget build(BuildContext context) {
    var widget = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PropertyBloc(getIt.get<PropertyRepository>())
            ..add(
              PropertiesLoad(),
            ),
        ),
        BlocProvider(
          create: (context) => AdsBloc(
            adsRepository: AdsRepository(),
          )..add(LoadAds()),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Feed(),
        ),
      ),
    );
    return widget;
  }
}

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  pinned: false,
                  floating: false,
                  title: Text(
                    "Rent  ",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 23.0,
                        backgroundImage: CachedNetworkImageProvider(

                          "https://images.unsplash.com/photo-1623330188314-8f4645626731?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=659&q=80",
                        ),
                      ),
                    )
                  ],
                ),
                SliverAppBar(
                  backgroundColor: Colors.white,
                  collapsedHeight: 250,
                  expandedHeight: 250,
                  flexibleSpace: ProfileView(),
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(TabBar(
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "All",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Cars",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "House",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Others",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                    indicatorColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                  )),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(
              children: [
                Container(
                  child: RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context)
                          .add(PropertiesLoad());
                    },
                  ),
                ),
                Container(
                  child: RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context)
                          .add(PropertiesLoad());
                    },
                  ),
                ),
                Container(
                  child: RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context)
                          .add(PropertiesLoad());
                    },
                  ),
                ),
                Container(
                  child: RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context)
                          .add(PropertiesLoad());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fetchFeed(BuildContext context) {
    return BlocBuilder<PropertyBloc, PropertyState>(
      builder: (context, state) {
        if (state is PropertyLoading) {
          List<Widget> widgets = [];
          for (var i = 0; i < 5; i++) {
            widgets.add(
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: FeedCardShimmer(),
              ),
            );
          }

          return Container(
            child: ListView(
              // itemExtent: widgets,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widgets,
            ),
          );
        } else if (state is PropertyOperationSuccess) {
   
          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.props.length,
              itemBuilder: (ctx, index) {
                // return widgets[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: FeedPropertyCard(
                    imgUrl:
                        "https://images.unsplash.com/photo-1611839699701-5cd5f18c25a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80",
                    ratingCount: 4,
                    name: "Mailibu Beach House",
                    phoneCallback: () async {
                      await getIt<Telephony>().openDialer("0949024607");
                    },
                    messageCallback: () async {
                      await getIt<Telephony>().sendSmsByDefaultApp(
                          to: "1234567890", message: "Mailibu Beach House:");
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is PropertyOperationFailure) {
          return Center(
            child: Text("Network Failure"),
          );
        } else {
          return Container(
            height: 100,
            width: 100,
          );
        }
      },
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        hintText: "Search here"),
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: Material(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.tune_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          tabBar,
        ],
      ),
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height + 60;

  @override
  double get minExtent => tabBar.preferredSize.height + 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class ProfileView extends StatelessWidget {
  // final Function f;
  // ProfileView( );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 240,
          child: Padding(
            padding: EdgeInsets.symmetric(
                // horizontal: 10,
                // vertical: 5,
                ),
            child: fetchAds(context),
          ),
        )
      ],
    );
  }

  Widget fetchAds(BuildContext context) {
    return BlocBuilder<AdsBloc, AdsState>(builder: (context, state) {
      if (state is AdOperationLoading) {
        return ListView.builder(
          // controller: _controller,
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: RecommendationCardShimmer(),
            );
          },
        );
      } else if (state is AdFetchOperationSuccess) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.props.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: RecomedationCard(
                date: "",
                imgUrl:
                    "https://images.unsplash.com/photo-1611839699701-5cd5f18c25a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80",
                name: "",
                price: "0",
                callback: () {},
              ),
              // child: RecomedationCard(
              //   date: (state.properties.elementAt(index)).createdAt!,
              //   imgUrl: "assets/images/content/car-1.jpg",
              //   name: (state.properties.elementAt(index)).title,
              //   price: (state.properties.elementAt(index)).per,
              //   callback: () {},
              // ),
            );
          },
        );
      } else if (state is PropertyOperationFailure) {
        return Center(
          child: Text("Network Failure"),
        );
      } else {
        return Container(
          height: 100,
          width: 100,
        );
      }
    });
  }
}
