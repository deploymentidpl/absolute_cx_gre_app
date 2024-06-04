
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../style/assets_string.dart';

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AssetsString.aNoPageFound,height: 400,width: 400,),
    );
  }
}
