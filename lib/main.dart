import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Movie{
  final String title;
  final String description;
  final String language;
  final String posterpath;
  Movie({this.title, this.description, this.language,this.posterpath});
  factory Movie.fromJson(Map<String,dynamic> json){
    return Movie(
      title: json['title'],
      description: json['overview'],
      language: json['original_language'],
      posterpath:json['poster_path'],
    );
  }
}
Future<Movie> fetchPost() async {
  final response =
  await http.get('https://api.themoviedb.org/3/movie/550?api_key=b7366a0c73904a1a5337e219204adf2c');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Movie.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
void main() async{
  Movie movie=await fetchPost();
  runApp(MyApp(movie: movie,));
}
class MyApp extends StatelessWidget {
  final Movie movie;

  MyApp({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(movie.title),
              Text(movie.language),
              Text(movie.description),
              Container(
                height: 300,
                child: Image.network("https://image.tmdb.org/t/p/w600_and_h900_bestv2${movie.posterpath}",fit: BoxFit.cover,),
              )
            ],
          )
      ),),
    );
  }
}