import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/foundation.dart';
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

  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('news');

    late List<Object?> newslist=[{}];
Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    final List<Object?>allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    newslist=allData;
}
  @override
  // ignore: override_on_non_overriding_member
  // Stream<List<news>> newslist=FirebaseFirestore.instance.collection("news").snapshots().map((snapshot) => snapshot.docs.map((e) => news.fromJson(e.data())).toList());
  Widget build(BuildContext context) {
  getData();
  // news.fromJson();
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
          child: CarouselSlider(

            items: [
              for(int x = 1; x<=newslist.length ;x++)...[
      InkWell(
                // onTap: () {
                //   if (kDebugMode) {
                //     // print(newslist);
                //   }
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => NewsDetail()),
                //   );
                // },
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            child: Image.network(
                              "",
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
                                    child:
                                        Icon(Icons.broken_image_outlined),
                                  ),
                                );
                              },
                            )),
                        const Padding(
                          padding: EdgeInsets.all(6),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "News API trending news",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20,
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
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

    ],
              
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
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
        ),
        // floatingActionButton: Text("hello"),
        //
      ),
    );
  }

}