// ignore_for_file: sized_box_for_whitespace

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/service/data_service.dart';

import 'news_item.dart';

class TabBarMenu extends StatefulWidget {
  final List<Article> article;

  const TabBarMenu(this.article, {Key? key}) : super(key: key);

  @override
  State<TabBarMenu> createState() => _TabMenuBarState();
}

//kita akan menggunakan single ticker provider state mixin jika kita memiliki satu animasi
class _TabMenuBarState extends State<TabBarMenu>
    with SingleTickerProviderStateMixin {
  //untuk mengatur tab yang aktif
  late TabController _tabController;
  //kita akan menggunakan late untuk mengatur tab controller
  //karena kita akan menggunakan widget tab bar
  final List<Tab> myTabs = const <Tab>[
    //list tab yang akan ditampilkan
    Tab(text: 'Business'),
    Tab(text: 'Entertainment'),
    Tab(text: 'General'),
    Tab(text: 'Health'),
    Tab(text: 'Science'),
    Tab(text: 'Sports'),
    Tab(text: 'Technology'),
  ];

  @override
  void initState() {
    //animasi tab
    _tabController = TabController(length: myTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    //untuk menghapus controller tab
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //sama saja seperti var news = News();
    News news = News();
    return Container(
      //agar dia responsive dengan layar yang di gunakan user
      //maka kita akan menggunakan MediaQuery.of(context).size.height
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          TabBar(
            tabs: myTabs,
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blue,
            //untuk mengatur warna tab yang aktif atau tidak aktif
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BubbleTabIndicator(
                //kita akan menggunakan bubble tab indicator
                indicatorColor: Colors.blue,
                //kita akan menggunakan color blue
                indicatorHeight: 30,
                //kita akan menggunakan height 30
                tabBarIndicatorSize: TabBarIndicatorSize.tab),
            //agar bisa di scroll
            isScrollable: true,
          ),
          const SizedBox(height: 10),
          //kenapa menggunakan expanded?
          //karena kita akan menggunakan listview untuk menampilkan data
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                //karena kita mengunakan kurung siku maka kita harus menggunakan return
                //disini kita menggunakan fueure builder karena
                //kita bisa dengan mudah mendapatkan status dari proses
                //yang sedang kita jalankan, misal nya seperti
                //menampilkan loading saat memuat data
                //dari server menggunakan API, lalu menampilkan datanya
                //saat suda siap dan di terima
                return FutureBuilder(
                  //builer dab future ini adalah salah satu fitur yang wajib kita ada kan di FutureBuilder
                  future: news.getNewsByCategory(tab.text.toString()),
                  //buildeer juga memerlukan yang namanya context dan snapshot
                  //snapshot ini berfunsi untuk meriksa data yang kita dapatkan
                  builder: (context, snapshot) => snapshot.data != null
                      //if else yang menggunakan "?" dan ":"
                      //kita akan menggunakan "?" untuk mengecek apakah snapshot.data tidak null
                      ? _listNewsCategory(snapshot.data as List<Article>)
                      //kita akan menggunakan ":" untuk menampilkan loading karena data yang kosong
                      : const Center(child: CircularProgressIndicator()),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  //membuat widget sendiri untuk List News Category
  Widget _listNewsCategory(List<Article> articles) {
    return Container(
      //MediaQuery ini akan membuat widget responsive dengan layar yang di gunakan user
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.builder(
        itemBuilder: (context, index) => NewsItem(article: articles[index]),
        itemCount: articles.length,
      ),
    );
  }
}
