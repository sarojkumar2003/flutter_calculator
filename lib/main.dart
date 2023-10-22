import 'package:calculator/color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
//create some variable
  var input = ' ';
  var output = ' ';
  var operation = ' ';
  var hideInput = false;
  var outputSize = 34.0;

  //crate a method to print output by this method
  onButtonClick(value) {
    // if value is AC
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<-") {
      if (input.isEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll(
            "x", "*"); //this line is used for the replace the "x" to "*"
        Parser p =
            Parser(); //in this parser functon all the "mathematical expression" is abilable.
        Expression expression = p.parse(userInput);
        ContextModel contextModel = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, contextModel);
        output = finalValue.toString();
        if (output.endsWith("0")) {
          output = output.substring(0, output.length -2);
        }
        input = output;
        hideInput = true;
        outputSize = 62;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    //setState is used for the refress the screen
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Expanded(
            child: Container(
          //input output area
          padding: EdgeInsets.all(12),
          width: double.infinity, //for the full width
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //for the input
              Text(
                hideInput ? '' : input,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              //sizedbox is used for the space
              SizedBox(
                height: 20,
              ),
              //for the output
              Text(
                output,
                style: TextStyle(
                  fontSize: outputSize,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )),

        //buttn area
        Row(
          children: [
            button(
                text: "AC", buttonBgColor: opertorColor, tColor: orangeColor),
            button(
                text: "<-", buttonBgColor: opertorColor, tColor: orangeColor),
            button(
                text: "+/_", buttonBgColor: opertorColor, tColor: orangeColor),
            button(text: "/", buttonBgColor: opertorColor, tColor: orangeColor),
          ],
        ),

        Row(
          children: [
            button(text: "7", buttonBgColor: buttonColor),
            button(text: "8"),
            button(text: "9"),
            button(text: "x", buttonBgColor: opertorColor, tColor: orangeColor),
          ],
        ),

        Row(
          children: [
            button(text: "4"),
            button(text: "5"),
            button(text: "6"),
            button(text: "-", buttonBgColor: opertorColor, tColor: orangeColor),
          ],
        ),

        Row(
          children: [
            button(
              text: "1",
            ),
            button(text: "2"),
            button(text: "3"),
            button(text: "+", buttonBgColor: opertorColor, tColor: orangeColor),
          ],
        ),

        Row(
          children: [
            button(text: "%", buttonBgColor: opertorColor, tColor: orangeColor),
            button(text: "0"),
            button(text: ".", buttonBgColor: opertorColor, tColor: orangeColor),
            button(text: "=", buttonBgColor: orangeColor),
          ],
        ),
      ]),
    );
  }

//function for the button

  Widget button(
      { //these are the three paramentres Text, tColor,buttonBgColor
      text,
      tColor = Colors.white,
      buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.all(22),
                  backgroundColor: buttonBgColor),
              onPressed: () => onButtonClick(text),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18, color: tColor, fontWeight: FontWeight.bold),
              ),
            )));
  }
}
