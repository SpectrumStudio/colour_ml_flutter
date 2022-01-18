import "package:flutter/material.dart";

class MlScreen extends StatefulWidget {
  const MlScreen({Key? key}) : super(key: key);

  @override
  _MlScreenState createState() => _MlScreenState();
}

class _MlScreenState extends State<MlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ML Screen"),
      ),
    );
  }
}
