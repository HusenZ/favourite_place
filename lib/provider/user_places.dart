import 'dart:io';
import 'package:favourite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier():super(const []);

  void addPlace(String title, File image, String enteredText) {
    final newPlace = Place(title: title, image: image, note: enteredText);
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier, List<Place>>((ref) => UserPlaceNotifier());
