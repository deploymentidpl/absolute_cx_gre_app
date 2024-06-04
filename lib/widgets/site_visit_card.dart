
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greapp/config/Helper/size_config.dart';

import '../config/utils/constant.dart';
import '../config/utils/images.dart';
import '../style/text_style.dart';
import '../style/theme_color.dart';

class SiteVisitCard extends StatelessWidget {
  const SiteVisitCard(
      {super.key,
        this.timerValue='',this.token='',this.svStatus='',
      //required this.model,
      required this.showEndCVButton,
      required this.showTimer});

//  final LeadModel model;
  final bool showEndCVButton, showTimer;
  final String timerValue,token,svStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 400,
        //maxHeight: 420.h,
      ),
      decoration: BoxDecoration(color: ColorTheme.cThemeCard),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTimer)
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ColorTheme.cGreen,width: 1)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorTheme.cGreen,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 50,child: Text('SV Time',textAlign: TextAlign.center, style: semiBoldTextStyle(size: 14.h,color:ColorTheme.cThemeBg ),),),
                          Text('02:02',style: boldTextStyle(size: 46.h,color:ColorTheme.cThemeBg ),)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Text(
                      '#709',
                      style: boldTextStyle(size: 16, color: ColorTheme.cGreen),
                    ),
                  )
                ],
              ),
            ),
          Padding(padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(color: ColorTheme.cAppTheme),
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('#20297',style: semiBoldTextStyle(size: 12.h)),
                  SizedBox(width: 5.w),
                  const VerticalDivider(
                    color: ColorTheme.cWhite,
                    thickness: 1,
                  ),
                  SizedBox(width: 5.w),
                  Text('Billboard',style: semiBoldTextStyle(size: 12.h)),
                ],
              ),
            ),
            ),
            sizedBox16,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  clipBehavior: Clip.none,
                  borderRadius: BorderRadius.circular(40.h),
                  child: Container(
                    height: 40.h,
                    width: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:ColorTheme.cLeadScore,
                      shape: BoxShape.circle,
                    ),
                    child: Text('10', style: boldTextStyle(size: 14.h)),
                  ),
                ),
                SizedBox(width: 4.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alex Doe',style: boldTextStyle(size: 16.h)),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Text('SV Scheduled',style: semiBoldTextStyle(size: 12.h,color: ColorTheme.cMosque)),
                          VerticalDivider(
                            color: ColorTheme.cMosque,
                            thickness: 1,
                          ),
                          Text('15 MAR @ 4:00 PM',style: semiBoldTextStyle(size: 12.h,color: ColorTheme.cMosque)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            sizedBox16,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 24.h,
                  width: 36.h,
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:ColorTheme.cBgMosque,
                  ),
                  child: SvgPicture.asset('assets/icons/user.svg',color: ColorTheme.cMosque),
                ),
                SizedBox(width: 6.w),
                Container(
                  height: 24.h,

                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:ColorTheme.callColor.withOpacity(0.2),
                  ),
                  child:Text('Missed Call',style: semiBoldTextStyle(size: 12.h,color: ColorTheme.cFontRed)),
                ),

                sizedBox16,

              ],
            ),
            sizedBox16,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(locationSVG,height: 20.h,width: 20.w,),
                SizedBox(width: 8.w),
                Text('Khar East, Mumbai, Maharashtra',style: semiBoldTextStyle(size: 12.h)),
              ],
            ),
            sizedBox16,
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/city.svg',height: 20.h,width: 20.w,),
                      SizedBox(height: 4.h,),
                      Text('ACX Tokyo',style: semiBoldTextStyle(size: 12.h)),
                    ],
                  ),
                  VerticalDivider(
                    color: ColorTheme.cLineColor,
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/coin_rupee.svg',height: 20.h,width: 20.w,),
                      SizedBox(height: 4.h,),
                      Text('1.75-2 Cr.',style: semiBoldTextStyle(size: 12.h)),
                    ],
                  ),
                  VerticalDivider(
                    color: ColorTheme.cLineColor,
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(bhkSVG,height: 20.h,width: 20.w,),
                      SizedBox(height: 4.h,),
                      Text('4 BHK',style: semiBoldTextStyle(size: 12.h)),
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: 12.h),
            Divider(
              height: 1.h,
              color: ColorTheme.cLineColor,
            ),
            SizedBox(height: 12.h),
            IntrinsicHeight(
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'CREATED : ',
                          style: semiBoldTextStyle(
                              size: 8.h, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Sat, Jan 28, 2023  5:19 PM',
                          style: regularTextStyle(
                              size: 8.h,
                              color: Colors
                                  .white), // Example for different color
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    color: ColorTheme.cWhite,
                    thickness: 1,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'UPDATED : ',
                          style: semiBoldTextStyle(
                              size: 8.h, color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Sat, Jan 28, 2023  5:19 PM',
                          style: regularTextStyle(
                              size: 8.h,
                              color: Colors
                                  .white), // Example for different color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Divider(
              height: 1.h,
              color: ColorTheme.cLineColor,
            ),
            SizedBox(height: 12.h),
            if(showEndCVButton)
            Container(
              decoration: BoxDecoration(
                color: ColorTheme.cBgRed
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 11.h),
              child: Text('END CV',style: semiBoldTextStyle(size: 16.h,color: ColorTheme.kRed)),
            )
          ],
        ),

          )
        ],
      ),
    );
  }
}
