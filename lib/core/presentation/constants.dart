import 'package:flutter/material.dart';

var _opacity = 1.0;
var _xOffset = 2.0;
var _yOffset = 2.0;
var _blurRadius = 5.0;

var textShadowLight = Shadow(
  color: Colors.blue.shade900.withOpacity(_opacity),
  offset: Offset(_xOffset, _yOffset),
  blurRadius: _blurRadius,
);

var textShadowMedium = Shadow(
  color: Colors.blue.shade900.withOpacity(_opacity),
  offset: Offset(_xOffset, _yOffset),
  blurRadius: _blurRadius,
);

var textShadowLarge = Shadow(
  color: Colors.blue.shade900.withOpacity(_opacity),
  offset: Offset(_xOffset, _yOffset),
  blurRadius: _blurRadius,
);
