import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
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
                    "TITLE",
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
                    "https://cdn.vox-cdn.com/thumbor/sP9sPjh-2PfK76HRsOfHNYNQWAo=/0x285:4048x2404/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/23761862/1235927096.jpg",
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
                    "Go to NewsAPI.org and sign up with your email ID and password. As  as you sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.u sign up, it will generate a unique API key for yourself that we will use to request news articles. Save that key as a constant in the Flutter project.",
                    // maxLines: 5,
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
