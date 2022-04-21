import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String overview;
  final String rating;
  final DateTime date;
  final String path;
  DetailPage(
      {required this.date,
      required this.overview,
      required this.path,
      required this.rating,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xffF1BA5E).withOpacity(0.85),
          title: Text(
            'Back',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 18.0.sp,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: false,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,
                color: Colors.black45, size: 18.0.sp),
          )),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Stack(
          // fit: StackFit.passthrough,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 100.0.h,
              width: 100.0.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "https://image.tmdb.org/t/p/w342" + path),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0.h),
              padding: EdgeInsets.symmetric(horizontal: 3.0.w),
              //height: 60.0.h,
              width: 85.0.w,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(2.0.w)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.0.h,
                  ),
                  SizedBox(
                    width: 80.0.w,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    'September 10, 1994 $date',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 0.75.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 16.0.sp,
                          ),
                          SizedBox(
                            width: 1.0.w,
                          ),
                          Text(
                            "$rating%",
                            style: bodyFontStyle(),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 16.0.sp,
                          ),
                          SizedBox(
                            width: 1.0.w,
                          ),
                          Text(
                            '2 hr 22 mins',
                            style: bodyFontStyle(),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 0.75.h,
                  ),
                  Text(
                    overview,
                    style: bodyFontStyle(),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TextStyle bodyFontStyle() {
    return TextStyle(color: Colors.white, fontSize: 15.0.sp);
  }
}
