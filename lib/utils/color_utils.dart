import 'package:article_feed_onloop_nandish/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';

Color getBorderColor(String filterTextColor) {
  switch (filterTextColor.toLowerCase()) {
    case 'grey':
      return kDarkGrey;
    case 'red':
      return kDarkRed;
    case 'yellow':
      return kDarkYellow;
    case 'green':
      return kDarkGreen;
    case 'blue':
      return kDarkBlue;

    default:
      return kDarkGrey;
  }
}

Color getFillColor(String filterTextColor) {
  switch (filterTextColor.toLowerCase()) {
    case 'grey':
      return kLightGrey;
    case 'red':
      return kLightRed;
    case 'yellow':
      return kLightYellow;
    case 'green':
      return kLightGreen;
    case 'blue':
      return kLightBlue;

    default:
      return kLightGrey;
  }
}
