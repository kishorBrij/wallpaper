import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child:Image.network(widget.imageUrl,fit: BoxFit.fitHeight,),
            ),
            InkWell(
              onTap: (){
                // loadmore();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: const Center(
                  child: Text('Set Wallpaper',
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
      ),
    );
  }
}
