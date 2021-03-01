import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/ResultScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,


        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
String value = "";
class _MyHomePageState extends State<MyHomePage> {



  Future <Map<String, dynamic> > fetchAlbum(String value) async{
    final response = await http.get('https://itunes.apple.com/search?term=$value&entity=musicTrack&limit=25');
    if (response.statusCode == 200) {

      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(child:Scaffold(
      appBar: AppBar(
        title: Text('Search'),

      ),
      body: Padding(padding:EdgeInsets.all(5),child:Column(
        children: [TextField(
            decoration:InputDecoration(border: OutlineInputBorder(),hintText: 'Enter a song to search'),
          onChanged: (text) {
            value = text;
          },
          onSubmitted:(value){
            fetchAlbum(value).then((result){Map<String, dynamic> map=result;Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultScreen(map)),
            );});

          } ,
        ),
        RaisedButton(child: Text('Done'),onPressed:() {
          fetchAlbum(value).then((result){Map<String, dynamic> map=result;Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultScreen(map)),
          );});
        },)]

      ),
    )));
  }
}
