import 'package:flutter/material.dart';
import './transactions.dart';
import 'package:intl/intl.dart';
import './transaction_list.dart';
import './new_transaction.dart';

class AmountSlider extends StatefulWidget {
  @override
  AmountSliderState createState() => AmountSliderState();
}

class AmountSliderState extends State<AmountSlider> {
  Function addT;
  String title;
  double amount;
  
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: 20,
      min:0,
      max: 40,
      onChanged: (value) {
        setState(  ()  {amount=value;}   );
      },

    );
  }
}
