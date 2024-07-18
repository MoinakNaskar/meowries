import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessiontoken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initstate() {
    super.initState();

    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessiontoken == null) {
      setState(() {
        _sessiontoken = uuid.v4();
      });
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyDucJPSLeYuyWPNOelDDiILs7ndPiotbUo";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessiontoken';
    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print('data');
    print(data);

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString());
        ['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('places api google'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Search places'),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: _placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {},
                        title: Text(_placesList[index]['description']),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
