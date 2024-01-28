import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {

  var userqustion = '';
  var useranswer = '';


  final List<String> buttons =
      [
        'c', 'DEL', '%', '/',
        '9', '8', '7', 'X',
        '6', '5', '4', '-',
        '3', '2', '1', '+',
        '0', '.', 'ANS', '=',
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                        child: Text(userqustion,
                        style: TextStyle(fontSize: 20),
                        ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                        child: Text(useranswer,
                        style: TextStyle(fontSize: 20),
                        ),
                    ),
                  ],
                ),
              ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index){
                 //  clear button
                 if(index == 0){
                   return MyButton(
                     buttonTapped: (){
                      setState(() {
                        userqustion = '';
                        useranswer = '';
                      });
                     },
                     buttonText: buttons[index],
                     color: Colors.green[800],
                     textColor: Colors.white ,
                   );
                 }

                 // delete button
                 else if(index == 1) {
                   return MyButton(
                     buttonTapped: (){
                       setState(() {
                         userqustion = userqustion.substring(0,userqustion.length-1);
                         useranswer = useranswer.substring(0,useranswer.length-1);
                       });
                     },
                     buttonText: buttons[index],
                     color: Colors.red[700],
                     textColor: Colors.white,
                   );
                 }

                 //  equal to button
                 else if(index == buttons.length-1) {
                   return MyButton(
                     buttonTapped: (){
                       setState(() {
                         equalPressed();
                       });
                     },
                     buttonText: buttons[index],
                     color: Colors.brown,
                     textColor: Colors.white,
                   );
                 }



                 // other button's
                 else {
                   return MyButton(
                     buttonTapped: (){
                       setState(() {
                         // userqustion = userqustion + buttons[index];
                         userqustion += buttons[index];
                       });
                     },
                     buttonText: buttons[index],
                     color: isOperator(buttons[index]) ? Colors.brown : Colors.deepPurple[50],
                     textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                   );
                 }
                  },
              ),
              // child:  Center(
              //   child: MyButton(
              //   color: Colors.deepPurple,
              //   textColor: Colors.white,
              //   buttonText: '0',
              // ),
              // ),
            ),
          ),
        ],
      ),
    );
  }


  bool isOperator(String x){
    if(x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '='){
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userqustion;
    finalQuestion = finalQuestion.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    useranswer =  eval.toString();
  }

}
