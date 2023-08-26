import 'package:map_api/model/model.dart';
import 'package:flutter/material.dart';
import 'package:map_api/screen/main_screen.dart';
import 'services/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        
      ),
      
      home:Scaffold(appBar: AppBar(
        title: const Center(
          child:  Text('Student List',
          
          ),
        ) ,
      ),
      body:
      StudentListScreen(),),
      
    );
    
  }
}

