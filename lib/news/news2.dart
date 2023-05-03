import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/services/models.dart';
import 'package:flutter/foundation.dart';
import 'package:firstapp/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:googleapis/androidenterprise/v1.dart';
import 'package:firstapp/news/news_details.dart';

class News2 extends StatelessWidget {
  News2({super.key});

  Future<List<news>> newsoutput = FirestoreService().getNews();

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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 80, 8, 0),
          child: FutureBuilder<List<news>>(
            future: newsoutput,
            builder:
                (BuildContext context, AsyncSnapshot<List<news>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<news> newsList = snapshot.data!;
                  return CarouselSlider.builder(
                    itemCount: newsList.length,
                    itemBuilder: (BuildContext context, int index, _) {
                      news newsval = newsList[index];
                      return Container(
                        padding: EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            if (kDebugMode) {
                              // print(newslist);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetail(newsdetail: newsval)),
                            );
                          },
                          child: SingleChildScrollView(
                            child: Card(
                              elevation: 8,
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
                                        newsval.url,
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                  Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        newsval.newsTitle,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        newsval.newsDesc,
                                        
                                        maxLines: 5,
                                        
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                            fontSize: 14),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 400,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
