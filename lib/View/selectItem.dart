import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trading_app_flutter/Model/chartModel.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SelectItem extends StatefulWidget {
  var selectedItem;
  SelectItem({this.selectedItem});

  @override
  State<SelectItem> createState() => _SelectItemState();
}

class _SelectItemState extends State<SelectItem> {
  late TrackballBehavior? trackballBehavior;

  @override
  void initState() {
    // TODO: implement initState
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    getChar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: myHeight * 0.08,
                          child: Image.network(widget.selectedItem.image),
                        ),
                        SizedBox(
                          width: myWidth * 0.02,
                        ),
                        Column(
                          children: [
                            Text(
                              widget.selectedItem.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(widget.selectedItem.symbol.toUpperCase()),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            "\$" + widget.selectedItem.currentPrice.toString()),
                        Text(
                          widget.selectedItem.priceChangePercentage24H
                                  .toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                            color:
                                widget.selectedItem.priceChangePercentage24H <=
                                        0
                                    ? Colors.red
                                    : Colors.green,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Low"),
                        Text(widget.selectedItem.low24H.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text("High"),
                        Text(widget.selectedItem.high24H.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Vol"),
                        Text(widget.selectedItem.totalVolume.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: myHeight * 0.4,
                width: myWidth,
                // color: Colors.yellow,
                child: isRefresh == true
                    ? Center(child: CircularProgressIndicator())
                    : SfCartesianChart(
                        trackballBehavior: trackballBehavior,
                        zoomPanBehavior: ZoomPanBehavior(
                            enablePanning: true, zoomMode: ZoomMode.x),

                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries>[
                            CandleSeries<ChartModel, int>(
                              enableSolidCandles: true,
                              enableTooltip: true,
                              bullColor: Colors.green,
                              bearColor: Colors.red,
                              // dataSource: itemChart!,
                              dataSource: itemChart!,
                              xValueMapper: (ChartModel sales, _) => sales.time,
                              lowValueMapper: (ChartModel sales, _) =>
                                  sales.low,
                              highValueMapper: (ChartModel sales, _) =>
                                  sales.high,
                              openValueMapper: (ChartModel sales, _) =>
                                  sales.open,
                              closeValueMapper: (ChartModel sales, _) =>
                                  sales.close,
                              animationDuration: 55,
                            )
                          ]),
              ),
              Container(
                height: myHeight * 0.04,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: text.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: myWidth * 0.02),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              textBool = [
                                false,
                                false,
                                false,
                                false,
                                false,
                                false
                              ];
                              textBool[index] = true;
                            });
                            setDay(text[index]);
                            getChar();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: textBool[index] == true
                                    ? Colors.yellow.withOpacity(0.5)
                                    : Colors.white,
                              ),
                              child: Text(text[index])),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, false, true, false, false, false];

  bool isRefresh = true;
  int days = 30;

  setDay(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == "W") {
      setState(() {
        days = 7;
      });
    } else if (txt == "M") {
      setState(() {
        days = 30;
      });
    } else if (txt == "3M") {
      setState(() {
        days = 90;
      });
    } else if (txt == "6M") {
      setState(() {
        days = 180;
      });
    } else if (txt == "Y") {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;
  Future<void> getChar() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        widget.selectedItem.id +
        '/ohlc?vs_currency=usd&days=' +
        days.toString();

    setState(() {
      isRefresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = false;
    });

    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
        print(modelList);
      });
    } else {
      print(response.statusCode);
    }
  }
}
