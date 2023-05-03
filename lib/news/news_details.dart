import 'package:flutter/material.dart';
import 'package:firstapp/services/models.dart';


class NewsDetail extends StatelessWidget {
  const NewsDetail({super.key, required this.newsdetail});

  final news newsdetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("news details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    newsdetail.newsTitle,
                    style: TextStyle(
                      fontSize: 50,
                      color: Color.fromARGB(255, 255, 254, 254),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(0), topRight: Radius.circular(10)),
                  child: Image.network(
                    newsdetail.url,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    // if the image is null
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Icon(Icons.broken_image_outlined),
                        ),
                      );
                    },
                  )),
               Padding(
                padding: EdgeInsets.all(6),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    newsdetail.newsTitle,
                    maxLines: 2,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
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
                    // "Go to NewsAPI.org and sign up with your email ID and password. As  as you sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.",
                    // maxLines: 5,
                    newsdetail.newsDesc,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1), fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
