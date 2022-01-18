import "package:flutter/material.dart";
import 'package:tflite_flutter/tflite_flutter.dart';
import "dart:math";

class InputSceen extends StatefulWidget {
  const InputSceen({Key? key}) : super(key: key);

  @override
  _InputSceenState createState() => _InputSceenState();
}

class _InputSceenState extends State<InputSceen> {

  var predValue = "";
  @override
  void initState() {
    super.initState();
    predValue = "click VERIFY button";
  }

  Future<void> predData(var red,var green, var blue, var intensity) async {
    var redPar=red.text;
    var greenPar=green.text;
    var bluePar=blue.text;
    var intensityPar=intensity.text;
    //print(redPar.runtimeType);
    final interpreter = await Interpreter.fromAsset('trained_model.tflite');
    var input = [
      [double.parse(redPar), double.parse(greenPar), double.parse(bluePar), double.parse(intensityPar)]
      //[100.23,100.23,100.23,100.23]
    ];
    var output = List.filled(4, 0).reshape([1, 4]);
    interpreter.run(input, output);
    List<double> output_new = List<double>.from(output[0]);
    var maxValue=output_new.reduce((curr, next) => curr > next? curr: next);
    print(maxValue);
    var index=output_new.indexOf(maxValue);
    print(index);
    print(output[0]);
    var target;
    if (index==0)
      target="Blue";
    else if(index==1)
      target="Violet";
    else if (index==2)
      target="Pink";
    else
      target="Red";

    this.setState(() {
      predValue = target;
    });
  }

  final redController = TextEditingController();
  final greenController = TextEditingController();
  final blueController = TextEditingController();
  final intensityController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Column(
      children: [
        Spacer(),
        TextField(
          controller: redController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Red value"),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: greenController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Green Value"),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: blueController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Blue Value"),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: intensityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Intensity Value"),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () => predData(redController,greenController,blueController,intensityController),
          child: Text("VERIFY"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          "Predicted value :  $predValue ",
          style: TextStyle(color: Colors.black45, fontSize: 15),
        ),
        SizedBox(
          height: 16,
        ),
        Spacer(),
      ],
    ),
    ),
    );
  }


}


