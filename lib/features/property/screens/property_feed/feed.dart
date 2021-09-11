import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rental/core/helpers/get_image_url.dart';
import 'package:rental/features/property/bloc/add_review/add_review_bloc.dart';
import 'package:rental/features/property/bloc/add_review/add_review_event.dart';
import 'package:rental/features/property/bloc/fillter_property/car_fillter_bloc/car_property_bloc.dart';
import 'package:rental/features/property/bloc/fillter_property/house_fillter/house_property_bloc.dart';
import 'package:rental/features/property/bloc/fillter_property/other_fillter_bloc/other_property_bloc.dart';
import 'package:rental/features/property/bloc/property_bloc.dart';
import 'package:rental/features/property/bloc/top_rated/top_rated_bloc.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:rental/features/property/repository/top_rated/top_rated_repository.dart';
import 'package:rental/features/property/screens/property_detail/property_detail_screen.dart';
import 'package:rental/locator.dart';
import 'package:telephony/telephony.dart';
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
          create: (context) => FillterCarPropertyBloc(
            getIt.get<PropertyRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              FillterCarPropertyBloc(getIt.get<PropertyRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              FillterHousePropertyBloc(getIt.get<PropertyRepository>()),
        ),
        BlocProvider(
          create: (context) =>
              FillterOtherPropertyBloc(getIt.get<PropertyRepository>()),
        ),
        BlocProvider(
          create: (context) => TopRatedBloc(
            topRatedRepository:
                TopRatedRepository(PropertyRemoteDataProvider()),
          ),
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

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(
      length: 4,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.index == 0) {
      } else if (_tabController.index == 1) {}
    });
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          initialIndex: 0,
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
                        fontWeight: FontWeight.w300),
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
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  collapsedHeight: 250,
                  expandedHeight: 250,
                  flexibleSpace: ProfileView(),
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(
                      TabBar(
                        controller: _tabController,
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
                      ), (data) {
                    BlocProvider.of<PropertyBloc>(context).add(
                      PropertySearch(keyWord: data),
                    );
                    if (_tabController.index != 0) _tabController.animateTo(0);
                  }, () {
                    BlocProvider.of<PropertyBloc>(context).add(
                      PropertiesLoad(),
                    );
                  }),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
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
                    child: fetchCarCategory(context, "Car"),
                    onRefresh: () async {
                      BlocProvider.of<FillterCarPropertyBloc>(context)
                          .add(PropertyFilterCar());
                    },
                  ),
                ),
                Container(
                  child: RefreshIndicator(
                    child: fetchHouseCategory(context, "House"),
                    onRefresh: () async {
                      BlocProvider.of<FillterHousePropertyBloc>(context)
                          .add(PropertyFilterHouse());
                    },
                  ),
                ),
                Container(
                  child: RefreshIndicator(
                    child: fetchOtherCategory(context, "Other"),
                    onRefresh: () async {
                      BlocProvider.of<FillterOtherPropertyBloc>(context)
                          .add(PropertyFilterOther());
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
          print("---lloadingl--");
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
          print("---success--");
          print(state.props.length);
          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.props.length,
              itemBuilder: (ctx, index) {
                // return widgets[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    // horizontal: ,
                    vertical: 10,
                  ),
                  child: FeedPropertyCard(
                    goToDetailCallBack: (id) {
                      context
                          .read<AddReviewFormBloc>()
                          .add(PropertyChanged(id));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contetx) => PropertyDetail(id),
                          ));
                    },
                    id: state.props[index].id!,
                    imgUrl: state.props[index].images[0],
                    // imgUrl:
                    // "https://images.unsplash.com/photo-1611839699701-5cd5f18c25a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80",
                    ratingCount: state.props[index].reviewes!.length,
                    rating: state.props[index].rating!,
                    name: state.props[index].title,
                    description: state.props[index].description,
                    phoneCallback: () async {
                      await Telephony.instance.openDialer(
                          "${state.props[index].owner!.phoneNumber}");
                    },
                    messageCallback: () async {
                      await Telephony.instance.sendSmsByDefaultApp(
                          to: "${state.props[index].owner!.phoneNumber}",
                          message: "${state.props[index].title}:");
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
        } else if (state is PropertyNotFound) {
          return Center(child: Text("No results found!"));
        } else if (state is PropertyFeedEmpty) {
          return Center(child: Text("No Properties Currently avialable!"));
        } else {
          return Container(
            height: 100,
            width: 100,
          );
        }
      },
    );
  }

  Widget fetchCarCategory(BuildContext context, String cat) {
    BlocProvider.of<FillterCarPropertyBloc>(context).add(PropertyFilterCar());
    return BlocBuilder<FillterCarPropertyBloc, FillterCarPropertyState>(
      builder: (context, state) {
        if (state is PropertyCarLoading) {
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
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widgets,
            ),
          );
        } else if (state is PropertyCarSuccessF) {
          print(state.props);
          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.properties.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    // horizontal: ,
                    vertical: 10,
                  ),
                  child: FeedPropertyCard(
                    goToDetailCallBack: (id) {
                      context
                          .read<AddReviewFormBloc>()
                          .add(PropertyChanged(id));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contetx) => PropertyDetail(id),
                          ));
                    },
                    id: state.props[index].id!,
                    imgUrl: state.props[index].images[0],
                    // imgUrl:
                    //     "https://images.unsplash.com/photo-1611839699701-5cd5f18c25a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80",
                    ratingCount: state.properties[index].reviewes!.length,
                    rating: state.properties[index].rating!,
                    name: state.properties[index].title,
                    description: state.properties[index].description,
                    phoneCallback: () async {
                      await Telephony.instance.openDialer(
                          "${state.properties[index].owner!.phoneNumber}");
                    },
                    messageCallback: () async {
                      await Telephony.instance.sendSmsByDefaultApp(
                          to: "${state.properties[index].owner!.phoneNumber}",
                          message: "${state.props[index].title}:");
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is PropertyCarFailure) {
          return Center(
            child: Text("Network Failure"),
          );
        } else if (state is PropertyCarNotFound) {
          return Center(child: Text("No Properties currently avilable!"));
        } else {
          print("ELSE - statement is executed");
          print(state);
          return Container(
            height: 100,
            width: 100,
          );
        }
      },
    );
  }

  Widget fetchHouseCategory(BuildContext context, String cat) {
    BlocProvider.of<FillterHousePropertyBloc>(context)
        .add(PropertyFilterHouse());
    return BlocBuilder<FillterHousePropertyBloc, FillterHousePropertyState>(
      builder: (context, state) {
        if (state is PropertyHouseLoading) {
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
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widgets,
            ),
          );
        } else if (state is PropertyHouseSuccessF) {
          print(state.props);
          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.properties.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    // horizontal: ,
                    vertical: 10,
                  ),
                  child: FeedPropertyCard(
                    goToDetailCallBack: (id) {
                      context
                          .read<AddReviewFormBloc>()
                          .add(PropertyChanged(id));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contetx) => PropertyDetail(id),
                          ));
                    },
                    id: state.props[index].id!,
                    imgUrl: state.props[index].images[0],
                    // imgUrl:
                    //     "https://images.unsplash.com/photo-1611839699701-5cd5f18c25a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80",
                    ratingCount: state.properties[index].reviewes!.length,
                    rating: state.properties[index].rating!,
                    name: state.properties[index].title,
                    description: state.properties[index].description,
                    phoneCallback: () async {
                      await Telephony.instance.openDialer(
                          "${state.properties[index].owner!.phoneNumber}");
                    },
                    messageCallback: () async {
                      await Telephony.instance.sendSmsByDefaultApp(
                          to: "${state.properties[index].owner!.phoneNumber}",
                          message: "${state.props[index].title}:");
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is PropertyHouseFailure) {
          return Center(
            child: Text("Network Failure"),
          );
        } else if (state is PropertyHouseNotFound) {
          return Center(child: Text("No Properties currently avilable!"));
        } else {
          return Container(
            height: 100,
            width: 100,
          );
        }
      },
    );
  }

  Widget fetchOtherCategory(BuildContext context, String cat) {
    BlocProvider.of<FillterOtherPropertyBloc>(context)
        .add(PropertyFilterOther());
    return BlocBuilder<FillterOtherPropertyBloc, FillterOtherPropertyState>(
      builder: (context, state) {
        if (state is PropertyOtherLoading) {
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
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: widgets,
            ),
          );
        } else if (state is PropertyOtherSuccessF) {
          print(state.props);
          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.properties.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    // horizontal: ,
                    vertical: 10,
                  ),
                  child: FeedPropertyCard(
                    goToDetailCallBack: (id) {
                      context
                          .read<AddReviewFormBloc>()
                          .add(PropertyChanged(id));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contetx) => PropertyDetail(id),
                          ));
                    },
                    id: state.props[index].id!,
                    imgUrl: state.props[index].images[0],
                    // imgUrl:
                    // "https://images.unsplash.com/photo-1611839699701-5cd5f18c25a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80",
                    ratingCount: state.properties[index].reviewes!.length,
                    rating: state.properties[index].rating!,
                    name: state.properties[index].title,
                    description: state.properties[index].description,
                    phoneCallback: () async {
                      await Telephony.instance.openDialer(
                          "${state.properties[index].owner!.phoneNumber}");
                    },
                    messageCallback: () async {
                      await Telephony.instance.sendSmsByDefaultApp(
                          to: "${state.properties[index].owner!.phoneNumber}",
                          message: "${state.props[index].title}:");
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is PropertyOtherFailure) {
          return Center(
            child: Text("Network Failure"),
          );
        } else if (state is PropertyOtherNotFound) {
          return Center(child: Text("No Properties currently avilable!"));
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
  MyDelegate(this.tabBar, this.notEmptyCallback, this.emptyCallback);
  final TabBar tabBar;
  final Function(String) notEmptyCallback;
  final Function emptyCallback;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    String keyword = "";
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
            child: BlocBuilder<PropertyBloc, PropertyState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (data) {
                          if (data.isNotEmpty) {
                            keyword = data;
                            notEmptyCallback(data);
                          } else {
                            emptyCallback();
                          }
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                          hintText: "Search here",
                        ),
                      ),
                      flex: 6,
                    ),
                    Expanded(
                      child: Material(
                        child: IconButton(
                          onPressed: () {
                            if (keyword.isNotEmpty) {
                              notEmptyCallback(keyword);
                            }
                          },
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
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
    BlocProvider.of<TopRatedBloc>(context).add(
      LoadTopRated(),
    );
    return BlocBuilder<TopRatedBloc, TopRatedState>(builder: (context, state) {
      if (state is TopRatedOperationLoading) {
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
      } else if (state is TopRatedOperationSuccess) {
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
                imgUrl: getImageUrl(state.topRated[index].images[0]),
                // imgUrl:
                //     "https://images.unsplash.com/photo-1611839699701-5cd5f18c25a4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1051&q=80",
                name: state.topRated[index].title,
                price: state.topRated[index].bill.toString(),
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contetx) =>
                            PropertyDetail(state.topRated[index].id!),
                      ));
                },
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
      } else if (state is TopRatedOperationFailure) {
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
