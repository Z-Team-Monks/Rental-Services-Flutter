import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental/features/property/bloc/property_detail/propertydetail_bloc.dart';
import 'package:rental/features/property/data_provider/property_local_data_provider.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:rental/core/presentation/constants.dart';
import 'package:rental/core/presentation/customTheme/appTheme.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_bloc.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_event.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_state.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import 'package:rental/features/property/screens/property_feed/components/feed_card.dart';
import 'package:shimmer/shimmer.dart';

class PropertyDetail extends StatelessWidget {
  static const pageRoute = "/property_detail";

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => PropertyDetailBloc(
                  propertyRepository: PropertyRepository(
                    PropertyLocalDataProvider(),
                    PropertyRemoteDataProvider(),
                  ),
                )..add(RequestPropertyDetail(id: "6130d66a17dfc38bca19279f"))),
        // BlocProvider<ReviewsBloc>(
        // create: (context) {
        //   return ReviewsBloc(
        //     reviewRepository: ReviewRepository(
        //       ReviewRemoteDataProvider(),
        //     ),
        //   )..add(ReviewsLoad())
      ],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 6.0, right: 6.0, top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bannerShiver(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            imageSubViewShimmer(
                              context,
                            ),
                            imageSubViewShimmer(context),
                            _imageSubView(
                              "assets/images/content/house-image.png",
                              child: Container(
                                color: Color.fromARGB(130, 255, 255, 255),
                                child: Center(
                                  child: Text(
                                    "2+",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      propertyNameAndRatingShimmer(context, currentTheme),
                      _horizontalUnderline(),
                      // _reviewListCard(),
                      // _reviewListCard(),
                      // _reviewListCard(),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(35, 0, 0, 0),
                          blurRadius: 10,
                          spreadRadius: 0)
                    ],
                    color: Colors.white,
                  ),
                  child: BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
                    builder: (context, state) {
                      if (state is PropertyDetailLoading) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[300],
                                height: 20,
                                width: 60,
                              ),
                            ),
                            Row(
                              children: [
                                Material(
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(22),
                                    child: Icon(Icons.chat_bubble_outline),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.call),
                                  label: Text("Call Owner"),
                                ),
                              ],
                            )
                          ],
                        );
                      } else if (state is PropertyDetailOperationSuccess) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RichText(
                                text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: [
                                TextSpan(
                                  text: "${state.props[0]!.bill} ETB / ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: "${state.props[0]!.per}")
                              ],
                            )),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      // send message to the owner in herer
                                    },
                                    icon: Icon(Icons.chat_bubble_outline)),
                                TextButton.icon(
                                  onPressed: () {
                                    // call the owner in here
                                  },
                                  icon: Icon(Icons.call),
                                  label: Text("Call Owner"),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        return Text("Network Error");
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bannerShiver(BuildContext context) {
    return BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
      builder: (context, state) {
        if (state is PropertyDetailLoading) {
          return Stack(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite_outline,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/content/house-image.png"),
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget imageSubViewShimmer(BuildContext context) {
    return BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
      builder: (context, state) {
        if (state is PropertyDetailLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.only(
                right: 5,
              ),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
            ),
          );
        } else {
          return _imageSubView(
            "assets/images/content/house-image.png",
          );
        }
      },
    );
  }

  Widget propertyNameAndRatingShimmer(
      BuildContext context, ThemeData currentTheme) {
    return BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
      builder: (context, state) {
        if (state is PropertyDetailLoading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 30,
                  width: 350,
                  color: Colors.grey[300],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 30,
                  width: 250,
                  color: Colors.grey[300],
                ),
              ),
            ],
          );
        } else if (state is PropertyDetailOperationSuccess) {
          return Column(
            children: [
              Text(
                "${state.props[0]!.title}",
                style: currentTheme.textTheme.headline4,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      "${state.props[0]!.rating} (${state.props[0]!.reviewes!.length} Reviews) • Norway")
                ],
              ),
            ],
          );
        } else {
          return Text("Network Error");
        }
      },
    );
  }
}

Widget _imageSubView(String imagUrl, {double size = 60.0, Widget? child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    width: size,
    height: size,
    decoration: BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/images/content/house-image.png"),
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    child: child,
  );
}

Widget _horizontalUnderline({Color color = Colors.redAccent}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
    child: Container(
      height: 1,
      color: color,
    ),
  );
}

Widget _reviewListCard({
  required String review,
  required String imageUrl,
  required String username,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(imageUrl),
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(username)
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(review),
        SizedBox(height: 10),
        _horizontalUnderline(color: Colors.grey),
      ],
    ),
  );
}

Widget reviewShimmer() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[300],
                    ),
                    width: 60,
                    height: 60,
                  ),
                  // child:
                ),
              ],
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 10,
                    width: 100,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 8,
            width: 300,
            color: Colors.grey[300],
          ),
        ),
        SizedBox(height: 10),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 8,
            width: 300,
            color: Colors.grey[300],
          ),
        ),
        SizedBox(height: 10),
        _horizontalUnderline(color: Colors.grey)
      ],
    ),
  );
}
