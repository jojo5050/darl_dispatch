import 'package:flutter/material.dart';

class Samplepage extends StatefulWidget {
  const Samplepage({Key? key}) : super(key: key);

  @override
  State<Samplepage> createState() => _SamplepageState();
}

class _SamplepageState extends State<Samplepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("sample page"),),
      body: Container(color: Colors.black87,
        child: const Center(child: Text("Nothing found"),),),);
  }
}
