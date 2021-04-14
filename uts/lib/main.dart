import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:BmiCalculator(),
    );
  }
}


//let's start by creating a new Stateful widget
class BmiCalculator extends StatefulWidget {
  BmiCalculator({Key key}) : super(key: key);

  @override
  _BmiCalculatorState createState() =>_BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  // Here I'm going to decalare a varibale for our custom radio button
  int currentindex = 0;
  String result = "";
  double height = 0;
  double weight = 0;

  // let's declare yhe inputController to get the inputs value
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //First we will create a simple a bar
        appBar: AppBar(
          title: Text(
            "BMI Calculator",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          backgroundColor: Color(0xfffafafa),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
                color: Colors.black,
            ),
          ],
        ),


        // Now let's start by creating the body of the app
        // we will wrap all the body inside a SingleScrollChild widget
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Row(
            children: [
            radioButton("Man", Colors.blue, 0),
            radioButton("Woman", Colors.pink, 1),
            ],
          ),
          SizedBox(
          height: 20.0,
        ),
        // Now let's create our index form
        Text (
          "Your Height in Cm : ",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          keyboardType: TextInputType.number,
          // let's add the controller
          controller: heightController,
          textAlign: TextAlign.center,
          decoration:InputDecoration(
            hintText: "Your height in cm",
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),

          SizedBox(
            height: 20.0,
          ),

          //For the weight I'm going to do the same thing
          // so just copy & paste the previous code

          Text (
            "Your Weight in kg : ",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: weightController,
            textAlign: TextAlign.center,
            decoration:InputDecoration(
              hintText: "Your Weight in kg",
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),

          // Now let's add the calculate button
          Container (
            width: double.infinity,
            height: 50.0,
            child: FlatButton(
              onPressed: () {
                setState (() {
                  height = double.parse(heightController.value.text);
                  weight = double.parse(weightController.value.text);
                });

                calculateBmi(height, weight);
                // Now Let's test our app
              },
              color: Colors.blue,
              child: Text("Calculate", style: TextStyle(
                color: Colors.white,
              ),
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Your BMI is : ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(
            height: 50.0,
          ),

          Container(
            width: double.infinity,
            child: Text(
              "$result",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ],
        ),
      ),
    ),
    ),
    );
  }

  void calculateBmi(double height, double weight){
    double finalresult = weight / (height * height / 10000); // I forget to convert the Cm to Meter
    String bmi = finalresult.toStringAsFixed(2);
    setState(() {
      result = bmi;
    });
  }

  // and here i'm going to declare a function to change the index value on button pressed
  void changeIndex(int index){
    setState(() {
      currentindex = index;
    });
  }

  // Now I will create a new custom widget
  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        // I will add some margis to the container
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        // let's add some height to the button
        height: 80.0,
        child: FlatButton(
          // Now I want the color of my button change in function of  it's selected or not
          // this line means if the current index is equalt to the button index then put the color
          // the main color that we will define otherwise make it grey
          color: currentindex == index ? color : Colors.grey[200],
          //let's add some round border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),  // RoundedRectangleBorder

          onPressed: () {
            //when we click the button the current index will have the value of the button"s index
            changeIndex(index);
          },
          //I'll apply some modification to the button text collor
          child: Text(value, style: TextStyle(
            color: currentindex == index ? Colors.white : color,
            fontSize: 18.0, fontWeight: FontWeight.bold,
        ),
        ),
      ),
    ),
    );
  }

}