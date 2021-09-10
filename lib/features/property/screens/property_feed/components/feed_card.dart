import 'package:flutter/material.dart';
import 'package:rental/core/helpers/get_image_url.dart';
import 'package:shimmer/shimmer.dart';
import './contact_icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Property feed card to list avialable properties for rent
/// in the home page [StatefulWidget]
class FeedPropertyCard extends StatefulWidget {
  /// FeedCard Image url [String]
  final String imgUrl;

  /// FeedCard rating count [String]
  final int ratingCount;

  /// FeedCard rating count [String]
  final double rating;

  /// FeedCard rating id [String]
  final String id;

  /// FeedCard name of the Property [String]
  final String name;

  /// FeedCard description of the Property [String]
  final String description;

  /// FeedCard call Button onTap handler [Function]
  final Function phoneCallback;

  /// FeedCard message Button onTap handler [Function]
  final Function messageCallback;

  /// FeedCard message Button onTap handler [Function]
  final Function(String) goToDetailCallBack;

  const FeedPropertyCard({
    Key? key,
    required this.imgUrl,
    required this.ratingCount,
    required this.rating,
    required this.name,
    required this.description,
    required this.phoneCallback,
    required this.messageCallback,
    required this.goToDetailCallBack,
    required this.id,
  }) : super(key: key);

  @override
  _FeedPropertyCardState createState() => _FeedPropertyCardState();
}

class _FeedPropertyCardState extends State<FeedPropertyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(22),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        getImageUrl(widget.imgUrl),
                      ),
                    )),
                width: double.infinity,
                height: 200,
                // child:
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                  ),
                  onTap: () {
                    widget.goToDetailCallBack(widget.id);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.star,
                color: Colors.pinkAccent,
              ),
              Text(
                "${widget.rating} (${widget.ratingCount})",
                style: TextStyle(
                    fontWeight: FontWeight.w300, fontFamily: "Poppins"),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "${widget.description}",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ContactIconButton(
                    icon: Icon(Icons.call),
                    callback: () {
                      widget.phoneCallback();
                    },
                  ),
                  ContactIconButton(
                    icon: Icon(Icons.message),
                    callback: () {
                      widget.messageCallback();
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
      color: Colors.white,
    );
  }
}

class FeedCardShimmer extends StatelessWidget {
  const FeedCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        children: [
          Stack(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.grey[300],
                  ),
                  width: double.infinity,
                  height: 200,
                  // child:
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 20,
                  width: 150,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 20,
                      width: 250,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 20,
                      width: 250,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      color: Colors.white,
    );
  }
}
