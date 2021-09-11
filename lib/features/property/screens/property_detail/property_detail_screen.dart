import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rental/core/helpers/get_image_url.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_bloc.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_event.dart';
import 'package:rental/features/property/bloc/Reviews/reviews_state.dart';
import 'package:rental/features/property/bloc/add_review/add_review_bloc.dart';
import 'package:rental/features/property/bloc/add_review/add_review_event.dart';
import 'package:rental/features/property/bloc/like_property/like_property_bloc.dart';
import 'package:rental/features/property/bloc/like_property/like_property_event.dart';
import 'package:rental/features/property/bloc/like_property/like_property_state.dart';
import 'package:rental/features/property/bloc/property_detail/propertydetail_bloc.dart';
import 'package:rental/features/property/data_provider/add_review/review_remote_data_provider.dart';
import 'package:rental/features/property/data_provider/like_property/like_property_remote_data_provider.dart';
import 'package:rental/features/property/data_provider/property_local_data_provider.dart';
import 'package:rental/features/property/data_provider/property_remote_data_provider.dart';
import 'package:rental/features/property/repository/add_review/add_review_repository.dart';
import 'package:rental/features/property/repository/like_property/like_property_repository.dart';
import 'package:rental/features/property/repository/property_repository.dart';
import 'package:rental/features/property/screens/add_review/add_review_popup.dart';
import 'package:rental/locator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:telephony/telephony.dart';

class PropertyDetail extends StatelessWidget {
  final String propertyId;
  PropertyDetail(this.propertyId);
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
          )..add(RequestPropertyDetail(id: this.propertyId)),
        ),
        BlocProvider(create: (context) {
          return ReviewsBloc(
            reviewRepository: ReviewRepository(
              ReviewRemoteDataProvider(),
            ),
          );
        }),
        BlocProvider(create: (context) {
          return LikePropertyBloc(
            propertyId: this.propertyId,
            likePropertyRepository: LikePropertyRepository(
              LikePropertyRemoteDataProvider(),
            ),
          );
        }),
      ],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
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
                          children: [imageSubViewShimmer(context)],
                        ),
                      ),
                      propertyNameAndRatingShimmer(context, currentTheme),
                      _horizontalUnderline(),
                      BlocBuilder<ReviewsBloc, ReviewsState>(
                          builder: (context, state) {
                        if (state is ReviewsLoading) {
                          return Column(
                            children: [
                              reviewShimmer(),
                              // reviewShimmer(),
                            ],
                          );
                        } else if (state is ReviewOperationSuccess) {
                          List<Widget> widgets = [];
                          print(
                              "][][][][][][[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[");
                          print(state.reviews);
                          print(
                              "][][][][][][[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[");
                          if (state.reviews.length != 0) {
                            for (var review in state.reviews) {
                              widgets.add(
                                _reviewListCard(
                                  review: review.message ?? "",
                                  imageUrl: review.user?.profileImage ?? "",
                                  username: review.user?.name ?? "",
                                ),
                              );
                            }
                            return Column(children: widgets);
                          } else {
                            return Container(
                              height: 30,
                              child: Center(child: Text("No reviews yet")),
                            );
                          }
                          // widgets.add();
                        } else if (state is ReviewOperationFailure) {
                          return Container(
                            height: 30,
                            child: Text("Network Error"),
                          );
                        } else {
                          return Container(
                            height: 30,
                          );
                        }
                      }),
                      // Center(child: ),
                      SizedBox(
                        height: 60,
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
                  child: BlocConsumer<PropertyDetailBloc, PropertyDetailState>(
                    listener: (context, state) {
                      if (state is PropertyDetailLoading) {
                        context.read<ReviewsBloc>().add(ReviewsLoadStarted());
                      } else if (state is PropertyDetailOperationSuccess) {
                        context
                            .read<ReviewsBloc>()
                            .add(ReviewsLoaded(state.props[0]?.reviewes ?? []));
                        context
                            .read<LikePropertyBloc>()
                            .add(LoadLikeStatus(state.props[0]?.likedBy ?? []));
                        context.read<AddReviewFormBloc>().add(LoadReview());
                      } else {
                        print("---- loading propertty fialed");
                        context.read<ReviewsBloc>().add(ReviewsLoadingFailed());
                        context
                            .read<LikePropertyBloc>()
                            .add(LikePropertyFailed());
                      }
                    },
                    builder: (context, state) {
                      if (state is PropertyDetailLoading) {
                        print("property detail loading ------------");
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
                                  onPressed: () {},
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
                                    onPressed: () async {
                                      await Telephony.instance.sendSmsByDefaultApp(
                                          to:
                                              "${state.props[0]!.owner!.phoneNumber}",
                                          message:
                                              "${state.props[0]!.title}: \n");
                                    },
                                    icon: Icon(Icons.chat_bubble_outline)),
                                TextButton.icon(
                                  onPressed: () async {
                                    await Telephony.instance.openDialer(
                                        "${state.props[0]!.owner!.phoneNumber}");
                                  },
                                  icon: Icon(Icons.call),
                                  label: Text("Call Owner"),
                                ),
                              ],
                            )
                          ],
                        );
                      } else {
                        print("=== loadin failed property");
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
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        } else if (state is PropertyDetailOperationSuccess) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        getImageUrl(state.property!.images[0])),
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
                          onTap: () {
                            Navigator.pop(context);
                          },
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
                      BlocBuilder<LikePropertyBloc, LikePropertyState>(
                          builder: (context, state) {
                        if (state is LikePropertyFailed ||
                            state is LikePropertyInprogress) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<LikePropertyBloc>()
                                    .add(LikePropertyChanged(true));
                              },
                              child: Icon(
                                Icons.favorite_outline,
                                size: 30,
                              ),
                            ),
                          );
                        } else {
                          print(
                              "--- like property load status ${state.props[0]}");
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print("-- like tapped -- ${state.props[0]}");
                                context.read<LikePropertyBloc>().add(
                                    LikePropertyChanged(
                                        !(state.props[0] as bool)));
                              },
                              child: Icon(
                                state.props[0] as bool
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 30,
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget imageSubViewShimmer(BuildContext context) {
    return BlocBuilder<PropertyDetailBloc, PropertyDetailState>(
      builder: (context, state) {
        if (state is PropertyDetailLoading) {
          var shimmer = <Widget>[];
          for (var i = 0; i < 3; i++) {
            shimmer.add(Shimmer.fromColors(
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
            ));
            shimmer.add(SizedBox(
              width: 6,
            ));
          }
          return Row(children: shimmer);
        } else if (state is PropertyDetailOperationSuccess) {
          var images = <Widget>[];
          if (state.property!.images.length >= 2) {
            for (var i = 1; i < state.property!.images.length; i++) {
              images.add(
                _imageSubView(
                  getImageUrl(state.property!.images[i]),
                ),
              );

              images.add(
                SizedBox(
                  width: 6,
                ),
              );
            }
            images.add(
              Row(
                children: [
                  AddReviewButton(
                    propertyId: propertyId,
                  )
                ],
              ),
            );
          }
          return Expanded(
            child: Row(
                children: images,
                mainAxisAlignment: MainAxisAlignment.spaceBetween),
          );
        } else {
          return Column(children: [
            _imageSubView(
              "assets/images/content/house-image.png",
            )
          ]);
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${state.props[0]!.title}",
                  style: currentTheme.textTheme.headline4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // SizedBox(
                      //   width: 15,
                      // ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                          "${state.props[0]!.rating} (${state.props[0]!.reviewes!.length} Reviews) • Ethiopia"),
                    ],
                  ),
                  Row(
                    children: [
                      (state.props[0]!.images.length <= 1)
                          ? AddReviewButton(
                              propertyId: propertyId,
                            )
                          : Container()
                    ],
                  ),
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
                  image: CachedNetworkImageProvider(getImageUrl(imageUrl)),
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(username,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                    ))),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(review, style: GoogleFonts.poppins())),
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
