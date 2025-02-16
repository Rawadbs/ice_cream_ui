import 'dart:ui';

import 'package:ice_cream_ui/colors.dart';


class IceCream {
  String name;
  String conName;
  String backgroundImage;
  String topImage;
  String smallImage;
  String blurImage;
  String cupImage;
  String description;
  Color lightColor;
  Color darkColor;

  IceCream(
      this.name,
      this.conName,
      this.backgroundImage,
      this.topImage,
      this.smallImage,
      this.blurImage,
      this.cupImage,
      this.description,
      this.lightColor,
      this.darkColor);
}

List<IceCream> getIceCreams() {
  return [
    IceCream(
      'Choco',
      'Late',
      'images/iceckream_chooclateBg.jpg',
      'images/chocolateTop.png',
      'images/chocolateSmall.png',
      'images/chocolateBlur.png',
      'images/icecream_chooclate.png',
      'Chocolate ice cream is a rich and creamy frozen dessert made with cocoa or melted chocolate',
      brownLight,
      brownDark,
    ),
    IceCream(
      'Mat',
      'Cha',
      'images/icecream_matchaBg.jpeg',
      'images/green.png',
      'images/greenSmall.png',
      'images/greenBlur.png',
      'images/icecream_matcha.png',
      'Matcha ice cream is a Japanese-style frozen dessert made with matcha green tea powder.',
      greenLight,
      greenDark,
    ),
    IceCream(
      'Straw',
      'Berry',
      'images/cherryicecreamBg.jpg',
      'images/cherry.png',
      'images/cherry.png',
      'images/cherry.png',
      'images/icecream_strwberry.png',
      'Strawberry ice cream is a sweet, creamy dessert made with fresh or artificial strawberry flavoring.',
      pinkLight,
      pinkDark,
    ),
  ];
}
