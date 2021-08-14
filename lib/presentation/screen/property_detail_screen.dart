import 'package:flutter/material.dart';
import 'package:rental/presentation/constants.dart';
import 'package:rental/presentation/core/customTheme/appTheme.dart';

class PropertyDetail extends StatefulWidget {
  const PropertyDetail({Key? key}) : super(key: key);

  @override
  _PropertyDetailState createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/content/house-image.png"),
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
                                GestureDetector(
                                  onTap: () {},
                                  child: Image(
                                    image: AssetImage(
                                        "assets/icons/arrow-back.png"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image(
                                    image: AssetImage("assets/icons/heart.png"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          _imageSubView(
                              "assets/images/content/house-image.png"),
                          SizedBox(
                            width: 10,
                          ),
                          _imageSubView(
                              "assets/images/content/house-image.png"),
                          SizedBox(
                            width: 10,
                          ),
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
                    Text(
                      "Niko’s Mailbu beach house",
                      style: currentTheme.textTheme.headline4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("4.68 (38 Reviews) • Norway")
                      ],
                    ),
                    _horizontalUnderline(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Cottage hosted by Zachary",
                            style: currentTheme.textTheme.headline5,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        )
                      ],
                    ),
                    Text("2 guests • Studio • 1 bed • 1 bath"),
                    _horizontalUnderline(),
                    Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          leading: Icon(
                            Icons.share_location_outlined,
                            color: currentTheme.iconTheme.color,
                          ),
                          title: Text('Great location'),
                          subtitle: Text(
                              "100% of recent guests gave the location a 5-star rating."),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          leading: Icon(
                            Icons.chat_outlined,
                            color: currentTheme.iconTheme.color,
                          ),
                          title: Text('Great Communication'),
                          subtitle: Text(
                              "100% of recent guests rated Zachary a 5-star in communicaiton."),
                        ),
                      ],
                    ),
                    _horizontalUnderline(color: Colors.grey),
                    _reviewListCard(),
                    _reviewListCard(),
                    _reviewListCard(),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                        text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      children: [
                        TextSpan(
                          text: "\$141.00 / ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "night")
                      ],
                    )),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.chat_bubble_outline)),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.call),
                          label: Text("Call Owner"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _imageSubView(String imagUrl, {double size = 60.0, Widget? child}) {
  return Container(
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

Widget _reviewListCard() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/content/user.png")),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text("Niko Altechalm")
          ],
        ),
        Text(
          "That's a fantastic new app feature. You and your team did an excellent job of incorporating user testing feedback.",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("2 Likes"), Icon(Icons.thumb_up_outlined)],
        ),
        _horizontalUnderline(color: Colors.grey)
      ],
    ),
  );
}
