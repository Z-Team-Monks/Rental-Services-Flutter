import 'package:flutter/material.dart';


/// [StatefulWidget] a custom button for buttons with contact icons
class ContactIconButton extends StatefulWidget {

  /// [Icon] for the button
  final Icon icon;
  /// [Function] callback for handling onTap event 
  final Function callback;

  const ContactIconButton({
    Key? key,
    required this.icon,
    required this.callback,
  }) : super(key: key);

  @override
  _ContactIconButtonState createState() => _ContactIconButtonState();
}

class _ContactIconButtonState extends State<ContactIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.callback();
      },
      child: IgnorePointer(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
