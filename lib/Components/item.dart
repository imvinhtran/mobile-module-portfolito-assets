import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item  extends StatelessWidget {
  var item;
   Item ({this.item});

  @override
  Widget build(BuildContext context) {
         double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width; 
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: myHeight*0.04,
            child: Image.network(item.image)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(item.name.toString()),
            Text('0.4 - ${item.symbol}' )
              ],
            ),
            SizedBox(
              width: myWidth*0.01,
            ),
            Container(
              width: myWidth*0.2,
              height: myHeight*0.04,
              child: Sparkline(data: item.sparklineIn7D.price,
              lineWidth: 2.0,
              lineColor: Colors.green,
              fillMode: FillMode.below,
              fillGradient: LinearGradient
              (
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.7],
                colors: [Colors.red, Colors.red.shade100],
              ),
              ),
            ),
             SizedBox(
              width: myWidth*0.01,
            ),
            Column(
              children: [
                Text("\$ ${item.currentPrice.toStringAsFixed(1)}", style: TextStyle(fontWeight: FontWeight.bold),),
                Text(item.marketCapChangePercentage24H.toStringAsFixed(2) + "%"),
              ],
            )
            // Ho
        ],
      ),
    );
  }
}