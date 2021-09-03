import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import './components/feed_card.dart';
import './components/recomeded.dart';

class HomeFeed extends StatefulWidget {
  static const pageRoute = "/feed";
  const HomeFeed({Key? key}) : super(key: key);

  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: BaseTheme.backgroundColor,
      body: SafeArea(
        child: CollapsingList(),
      ),
    );
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

class CollapsingList extends StatelessWidget {
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 70.0,
        maxHeight: 90.0,
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
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.tune_outlined,
                    color: Colors.black,
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
    const controller = DefaultTabController(length: 2, child: Text("natnael"));
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: false,
          floating: false,
          title: Text(
            "Niko Delela",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                )),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage(
                  "assets/images/content/car-1.jpg",
                  // backgroundColor: Colors.transparent,
                ),
              ),
            )
          ],
          expandedHeight: 15.0,
        ),
        makeHeader('Header Section 1'),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RecomedationCard(
                          date: "",
                          imgUrl: "assets/images/content/car-1.jpg",
                          name: "",
                          price: 0,
                          callback: () {},
                        ),
                        RecomedationCard(
                          date: "",
                          imgUrl: "assets/images/content/car-1.jpg",
                          name: "",
                          price: 0,
                          callback: () {},
                        ),
                        RecomedationCard(
                          date: "",
                          imgUrl: "assets/images/content/car-1.jpg",
                          name: "",
                          price: 0,
                          callback: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
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
                  Wrap(
                    children: [
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                      FeedPropertyCard(
                        imgUrl: "assets/images/content/car-1.jpg",
                        ratingCount: "",
                        name: "",
                        phoneCallback: () {},
                        messageCallback: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
