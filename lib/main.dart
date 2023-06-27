import 'package:flutter/material.dart';
import 'package:hw15/data/model.dart';
import 'package:hw15/objectbox.g.dart';
import 'package:hw15/data/repo.dart';
import 'screens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final Store store = await openStore();
  final Box<FantasticBeastEntity> box = Box<FantasticBeastEntity>(store);
  final repositary = FantasticBeastsRepository(box);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  FantasticBeastList(beastsRepository:repositary),

    ),
  );
}

class FantasticBeast {

  String name;
  String description;
  //String photo;
  String url;
  FantasticBeast(this.name, this.description,/* this.photo,*/ this.url);
}


