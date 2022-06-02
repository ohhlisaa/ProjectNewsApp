import 'package:flutter/material.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/service/data_service.dart';

import 'newspage.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    News news = News();
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            // image:const DecorationImage(
            //   image: NetworkImage(
            //       'https://sarkepo.com/wp-content/uploads/2021/10/pp-wa-aesthetic-82.jpg'),
            // ),
          ),
          width: 10,
          margin:const EdgeInsets.all(5),
        ),
        title:const Text(
          'menit.com',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     //untuk menampilkan icon bookmark
          //      icon:const Icon(
          //       Icons.bookmark,
          //       //untuk mengatur warna icon
          //       color: Colors.blue,
          //     ))
        ],
        //untuk mengatur warna background appbar
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: news.getNews(),
        builder: (context, snapshot) => snapshot.data != null
            ? NewsPage(snapshot.data as List<Article>)
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}