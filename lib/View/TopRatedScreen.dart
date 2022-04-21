import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_testapp/Services/Webservices.dart';
import 'package:tmdb_testapp/View/DetailPage.dart';
import 'package:tmdb_testapp/Model/NowPlayingModel.dart' as N;

class TopRatedScreen extends StatefulWidget {
  const TopRatedScreen({Key? key}) : super(key: key);

  @override
  State<TopRatedScreen> createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen> {
  bool _showxtField = false, _loading = true;
  late TextEditingController _searchController;
  N.NowPlaying _nowPlaying = N.NowPlaying();
  final Webservices _webservices = Webservices();

  @override
  void initState() {
    _searchController = TextEditingController();
    _webservices.getTopRated().then((value) {
      if (value != null) {
        setState(() {
          _nowPlaying = value;
          _loading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(),
          ))
        : Container(
            color: Color(0xffF1BA5E),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                _showxtField
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.0.w),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(3.0.w)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(3.0.w)),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(14.0.sp),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15.0.sp,
                                      ),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.5.h, horizontal: 3.0.w),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(bottom: 2.0.sp),
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showxtField = false;
                                });
                              },
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ))
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _showxtField = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0.w),
                              color: Colors.white),
                          padding: EdgeInsets.symmetric(vertical: 1.2.h),
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 3.0.w, vertical: 1.0.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              Text(
                                'Search',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.0.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 1.0.h),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: false,
                    itemCount: _nowPlaying.results!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 2.5.h),
                        height: 3,
                        width: double.infinity,
                        color: Colors.grey.shade200.withOpacity(0.15),
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      // this is a list item widget
                      return GestureDetector(
                        onTap: () => Get.to(DetailPage(
                          date: _nowPlaying.results![index].releaseDate!,
                          overview: _nowPlaying.results![index].overview!,
                          path: _nowPlaying.results![index].posterPath!,
                          rating: _nowPlaying.results![index].voteAverage
                              .toString(),
                          title: _nowPlaying.results![index].title!,
                        )),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                          child: Row(
                            children: [
                              Container(
                                height: 15.0.h,
                                width: 25.0.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(2.0.w)),
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            "https://image.tmdb.org/t/p/w342" +
                                                _nowPlaying.results![index]
                                                    .posterPath!),
                                        fit: BoxFit.fill)),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 3.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 60.0.w,
                                      child: Text(
                                        _nowPlaying.results![index]
                                                .originalTitle ??
                                            " -- ",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    SizedBox(
                                      width: 60.0.w,
                                      child: Text(
                                        _nowPlaying.results![index].overview ??
                                            " --- ",
                                        overflow: TextOverflow.visible,
                                        softWrap: true,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
