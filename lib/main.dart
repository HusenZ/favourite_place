import 'package:favourite_place/screens/places.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main(){
  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.tenorSansTextTheme(),
        colorSchemeSeed: Colors.green,
      ),
      home: const PlacesScreen(),
    );
  }
}