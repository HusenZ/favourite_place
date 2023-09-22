import 'package:favourite_place/model/place.dart';
import 'package:favourite_place/screens/places_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget{
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if(places.isEmpty){
      return const Center(
        child: Text('No places added yet'),
      );
    }
    return ListView.builder(
      itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(places[index].image),
          ),
          title: Text(places[index].title, style: Theme.of(context).textTheme.titleMedium,),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder:(ctx)=>PlaceDetailScreen(
                    place: places[index])
            ));
          },
        ),
    );
  }
}