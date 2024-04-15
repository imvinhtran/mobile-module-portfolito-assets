import 'package:flutter/material.dart';

class Item2 extends StatelessWidget {
  var item;
   Item2({this.item});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width; 

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidth*0.01),
      child: Container(
        width: myWidth*0.25,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: myWidth*0.10,
              child: Image.network(item.image)),
            Text(item.name),
            Text('\$ ' + item.currentPrice.toString()),
            Text(item.priceChangePercentage24H!.toStringAsFixed(2) + '%'),
          ],
        ),
      ),
    );
  }
}