import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:wallpaper/fullscreen.dart';

class WallpaperPage extends StatefulWidget {

  const WallpaperPage({Key? key}) : super(key: key);

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {

  List image = [];
  int page =1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchiapi();
  }

  fetchiapi()async{
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {'Authorization':'uibcvrHAklcKZXeh5EpU5Qc9Oh3GqdjutDgSCvoZ67aPchxuMUyY6z4N'}
    ).then((value) {
      print("005555"+value.body);
      Map result = jsonDecode(value.body);
     print(value);
      image = result['photos'];
      setState(() {

      });
    });
    //print(image);
  }

  loadmore()async{
    setState(() {
      page = page+1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {'Authorization':'uibcvrHAklcKZXeh5EpU5Qc9Oh3GqdjutDgSCvoZ67aPchxuMUyY6z4N'}
    ).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        image.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log("message$image");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
            child: GridView.builder(
              itemCount: image.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  childAspectRatio: .6,
                  mainAxisSpacing: 2
                ),
                itemBuilder:(context,index){
                return InkWell(
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> FullScreen(
                      imageUrl:image[index]["src"]["large2x"],
                    ))
                    );
                  },
                  child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(image[index]["src"]["tiny"],),
                    fit: BoxFit.cover
                    )
                  ),
                  ),
                );
                }
            ),
          ),
          ),
          InkWell(
            onTap: (){
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text('load more',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
