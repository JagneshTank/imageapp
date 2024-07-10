import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List imagesList = [];

  fetchImage() async {
    final response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=40"),
        headers: {
          HttpHeaders.authorizationHeader:
              'vJIXInBogJVGWKBx4YReRoCJ2mB6TWyCiaJDPVafDgLf2rEzWwyha2Gu'
        });

    final result = jsonDecode(response.body);
    setState(() {
      imagesList = result['photos'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Gallery"),
        backgroundColor: Colors.amber,
      ),
      body: GridView.builder(
          itemCount: imagesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              childAspectRatio: 4 / 3,
              crossAxisSpacing: 8),
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return SizedBox(
              // color of grid items
              child: Center(
                child: Image.network(
                  imagesList[index]['src']['tiny'],
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
