import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:googleapis/androidenterprise/v1.dart';
import 'package:firstapp/news/news_details.dart';
// import 'package:logintut/home_page.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 500, // set maximum height here
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bulletin @ IIT Indore",
            style: TextStyle(color: Colors.white70, fontFamily: 'Roboto'),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
            child: ListView(
              children: [

                CarouselSlider(
                  items: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewsDetail()),
                        );
                      },
                      child: SingleChildScrollView(
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Container(
                            color: Colors.black45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(
                                      "https://cdn.vox-cdn.com/thumbor/sP9sPjh-2PfK76HRsOfHNYNQWAo=/0x285:4048x2404/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/23761862/1235927096.jpg",
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill,
                                      // if the image is null
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Card(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const SizedBox(
                                            height: 200,
                                            width: double.infinity,
                                            child: Icon(
                                                Icons.broken_image_outlined),
                                          ),
                                        );
                                      },
                                    )),
                                SizedBox(
                                  height: 15,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "News API trending news",
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 20,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Go to NewsAPI.org and sign up with your email ID and password. As  as you sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.",
                                      maxLines: 5,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        height: 1.9,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    //4th Image of Slider
                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 400.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 1400),
                    viewportFraction: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: Text("hello"),
        //
      ),
    );
  }
}
