import 'package:flutter/material.dart';
import './contact_icon_button.dart';

/// Property feed card to list avialable properties for rent
/// in the home page [StatefulWidget]
class FeedPropertyCard extends StatefulWidget {
  /// FeedCard Image url [String]
  final String imgUrl;

  /// FeedCard rating count [String]
  final String ratingCount;

  /// FeedCard name of the Property [String]
  final String name;

  /// FeedCard call Button onTap handler [Function]
  final Function phoneCallback;

  /// FeedCard message Button onTap handler [Function]
  final Function messageCallback;

  const FeedPropertyCard({
    Key? key,
    required this.imgUrl,
    required this.ratingCount,
    required this.name,
    required this.phoneCallback,
    required this.messageCallback,
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.imgUrl),
                )),
            width: double.infinity,
            height: 200,
            // child:
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
                widget.ratingCount + "4.68(38)",
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
                children: [
                  Text(
                    widget.name + "Entire Cabin • Norway",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Candyblast by Agnes",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
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
                    icon: Icon(Icons.call),
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
