import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          Expanded(
            flex: 3,
            child: Container(
              height: myHeight*0.04,
              child: Image.network(item.image)),
          ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(item.name.toString()),
              Text('0.4 - ${item.symbol}' )
                ],
              ),
            ),
            SizedBox(
              width: myWidth*0.01,
            ),
            Container(
              width: myWidth*0.3,
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
                colors: item.marketCapChangePercentage24H >= 0 ? [Colors.green, Colors.green.shade100] : [Colors.red, Colors.red.shade100],
              ),
              ),
            ),
             SizedBox(
              width: myWidth*0.08,
            ),
            Expanded(
              flex: 4,
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$ ${item.currentPrice.toStringAsFixed(1)}", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(item.priceChangePercentage24H!.toStringAsFixed(2) + "%"),
                ],
              ),
            )
            // 
        ],
      ),
    );
  }
}