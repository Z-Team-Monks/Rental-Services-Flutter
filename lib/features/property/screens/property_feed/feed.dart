import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rental/core/models/property.dart';
import 'package:rental/features/property/bloc/Ads/ads_bloc.dart';
import 'package:rental/features/property/bloc/property_bloc.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:rental/locator.dart';
import 'package:telephony/telephony.dart';
import 'dart:math' as math;

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
          child: CollapsingList(),
        ),
      ),
    );
    return widget;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CollapsingList extends StatefulWidget {
  @override
  _CollapsingListState createState() => _CollapsingListState();
}

class _CollapsingListState extends State<CollapsingList> {
  var _controller = ScrollController();

  ScrollPhysics _physics = BouncingScrollPhysics();

  @override
  void initState() {
    super.initState();
  }

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 70.0,
        maxHeight: 70.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1.0,
                  offset: Offset(0.0, 0.5))
            ],
          ),
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // const controller = DefaultTabController(length: 2, child: Text("natnael"));
    return CustomScrollView(
      slivers: <Widget>[
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
            CircleAvatar(
              radius: 23.0,
              backgroundImage: CachedNetworkImageProvider(
                "https://i.ytimg.com/vi/k6g_Ylr_Oao/maxresdefault.jpg",
              ),
            )
          ],
          expandedHeight: 10.0,
        ),
        makeHeader(''),
        SliverToBoxAdapter(
          child: Container(
            height: 220,
            child: fetchAds(context),
          ),
        ),
        SliverFillRemaining(
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Colors.white,
                toolbarHeight: 50,
                elevation: 0,
                bottom: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black26,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.only(left: 10, right: 10),
                  indicatorColor: Colors.black,
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
                ),
              ),
              body: TabBarView(
                children: [
                  RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context).add(
                        PropertiesLoad(),
                      );
                    },
                  ),
                  RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context).add(
                        PropertiesLoad(),
                      );
                    },
                  ),
                  RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context).add(
                        PropertiesLoad(),
                      );
                    },
                  ),
                  RefreshIndicator(
                    child: fetchFeed(context),
                    onRefresh: () async {
                      BlocProvider.of<PropertyBloc>(context).add(
                        PropertiesLoad(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget fetchAds(BuildContext context) {
    return BlocBuilder<AdsBloc, AdsState>(builder: (context, state) {
      if (state is AdOperationLoading) {
        return ListView.builder(
          controller: _controller,
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
          itemCount: 3,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: RecomedationCard(
                date: "",
                imgUrl: "https://i.ytimg.com/vi/k6g_Ylr_Oao/maxresdefault.jpg",
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
          List<Widget> widgets = [];
          for (var i = 0; i < 5; i++) {
            widgets.add(
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: FeedPropertyCard(
                  imgUrl:
                      "https://i.ytimg.com/vi/k6g_Ylr_Oao/maxresdefault.jpg",
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
              ),
            );
          }

          return SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widgets.length,
              itemBuilder: (ctx, index) {
                return widgets[index];
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
