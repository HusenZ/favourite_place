import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:favourite_place/provider/user_places.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_place/widgets/image_input.dart';
import 'dart:io';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  File? _selectedImage;
  var _isSending = false;
  final _formKey = GlobalKey<FormState>();

  void _savePlace() async {
    final enteredTitle = _titleController.text;
    final enteredNote = _noteController.text;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });

      if (_selectedImage != null) {
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        final url =
        Uri.https('console.firebase.google.com/u/1/project/favorite-place-8066c/database/favorite-place-8066c-default-rtdb/data/~2F?hl=id', 'favourite-place.json');
        try{
          final response = await http.post(url,
              headers: {
                'Content-Type': 'application/json',
              },
              body: json.encode({
                'title': enteredTitle,
                'note': enteredNote,
                'image': base64Image,
              }));

          if (response.statusCode == 200) {
            final Map<String, dynamic> resData = json.decode(response.body);
            ref.read(userPlaceProvider.notifier).addPlace(
              resData['title'],
              resData['image'],
              resData['note'],
            );
          } else {
            print('HTTP Error: ${response.statusCode}');
          }

          setState(() {
            _isSending = true;
          });
        } catch(error){
          print('Errro: $error');
        }
        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: _titleController,
            ),
            const SizedBox(height: 10),
            ImageInput(
              onPickedImage: (image) {
                setState(() {
                  _selectedImage = image;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter a note here',
              ),
              controller: _noteController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSending
                  ? null
                  : _savePlace,
              child: _isSending
                  ? const CircularProgressIndicator()
                  :const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
