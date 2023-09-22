import 'package:favourite_place/model/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget{
  const PlaceDetailScreen({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
              child: Text(place.note, style:
              Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
              ),
                selectionColor: Colors.black,
              ),
          )
        ],
      )
    );
  }
}