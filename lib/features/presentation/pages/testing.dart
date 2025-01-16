import 'package:cric_app/features/repository/repository.dart';
import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      MatchRepository().fetchMatchDetails();
    }, child: Text("Click Here"));
  }
}
