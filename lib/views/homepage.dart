import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:movieflix_flutter/controllers/controller.dart';
import 'package:movieflix_flutter/views/moviedetail.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

final MovieController _controller = Get.put(MovieController());

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  double textWidth = 300.0;
  bool _folded = true;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: !_folded ? 80 : null,
        centerTitle: true,
        title: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: _folded ? Get.width / 1.5 : Get.width,
          alignment: _folded ? Alignment.center : Alignment.centerLeft,
          child: _folded
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _folded = !_folded;
                    });
                  },
                  child: Row(children: const <Widget>[
                    Icon(Icons.search),
                    SizedBox(width: 5),
                    Text("Search Something...")
                  ]),
                )
              : TextField(
                  autofocus: true,
                  controller: searchController,
                  onChanged: (value) {
                    if (value != "") {
                      _controller.searchMovie(value);
                    } else {
                      _controller.fetchingmovie();
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          searchController.clear();
                          _controller.fetchingmovie();
                        },
                        child: Icon(Icons.clear_rounded)),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search something ...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
        ),
      ),
      body: Obx(() => _controller.isLoading.value
          ? const LinearProgressIndicator()
          : GridView.count(
              padding: const EdgeInsets.all(5),
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: List.generate(
                  _controller.movielist[0]['results'].length, (index) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      _controller.fetchingmoviedetail(
                          _controller.movielist[0]['results'][index]['id']);
                      Get.to(() => DetailScreen());
                      // print(_controller.movielist[0]['results'][index]['id']);
                    },
                    child: Container(
                      width: 250,
                      // height: ,
                      color: Colors.grey[300],
                      child: CachedNetworkImage(
                        filterQuality: FilterQuality.low,
                        imageUrl:
                            'https://image.tmdb.org/t/p/w342${_controller.movielist[0]['results'][index]['poster_path']}',
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.amber,
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        fit: BoxFit.fill,
                        memCacheHeight: 250,
                        memCacheWidth: 100,
                      ),
                    ),
                  ),
                );
              }))),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_alt_outlined),
        backgroundColor: Colors.blue,
        onPressed: () {},
      ),
    );
  }
}
