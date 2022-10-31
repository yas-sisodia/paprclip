import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task/model/first_api_model.dart';
import 'package:task/services/first_api.dart';
import 'package:task/services/second_api.dart';

import 'model/second_api_model.dart';

void main() {
  FirstApiService.getRequest();
  SecondApiService.getRequest();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirstModel? firstModel;
  SecondModel? secondModel;

  bool isLoading = true;

  void getFirstData() async {
    Map<String, dynamic> firstdata = await FirstApiService.getRequest();
    firstModel = FirstModel.fromMap(firstdata);

  

    setState(() {
      if (firstModel != null) {
        isLoading = false;
      }
    });
  }

  void getSecondData() async {
    List<dynamic> secondData = await SecondApiService.getRequest();
    secondModel = SecondModel.fromMap(secondData);
    setState(() {
      if(secondModel != null){
        isLoading = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getFirstData();
    getSecondData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Overview',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "Sector",
                        right: firstModel!.sector,
                        isIcon: true,
                        icon: Icons.home,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "Industry",
                        right: firstModel!.industry,
                        isIcon: true,
                        icon: Icons.home_outlined,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "Market Cap.",
                        right: firstModel!.mCap.toString(),
                        isIcon: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "Enterprise Value (EV)",
                        right: '-',
                        isIcon: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "Book Value / Share",
                        right: firstModel!.bookNavPerShare.toString(),
                        isIcon: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "Price-Earning Ratio(PE)",
                        right: firstModel!.ttmPE.toString().substring(0, 5),
                        isIcon: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "PEG Ratio",
                        right: firstModel!.pegRatio.toString().substring(0, 4),
                        isIcon: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomRow(
                        left: "Dividend Yield",
                        right: firstModel!.divYield.toString().substring(0, 4),
                        isIcon: false,
                      ),
                    const  SizedBox(
                        height: 20,
                      ),
                    const  Text(
                        "Performance",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                   const   SizedBox(
                        height: 10,
                      ),
                   const   Divider(
                        color: Colors.black,
                        height: 5,
                      ),
                   const   SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: secondModel!.chart.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ChartCustomRow(
                              period: secondModel!.chart[index].label,
                              percentageChange:
                                  secondModel!.chart[index].changePercent,
                              name: secondModel!.chart[index].label.toString(),
                            ),
                          );
                        },
                      )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String left;
  final String right;
  final bool isIcon;
  IconData? icon;
  CustomRow(
      {super.key,
      required this.left,
      required this.right,
      required this.isIcon,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left),
        Row(
          children: [
            // Icon(Icons.icon),
          const  SizedBox(
              width: 5,
            ),
            if (isIcon) ...[Icon(icon)],
            Text(right),
          ],
        )
      ],
    );
  }
}

class ChartCustomRow extends StatelessWidget {
  final String period;
  final double percentageChange;
  final String name;
  ChartCustomRow(
      {super.key,
      required this.period,
      required this.percentageChange,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 66,
          child: Text(
            name,
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Stack(
          children: [
            Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2)),
            ),
            Container(
              height: 40,
              width: ((250 * percentageChange) / 100 > 250 ||
                      250 * percentageChange / 100 < -250)
                  ? 250
                  : 250 * (percentageChange).abs() / 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:
                      percentageChange.isNegative ? Colors.red : Colors.green),
            ),
          ],
        ),
        Row(
          children: [
            if (percentageChange.isNegative)
             const Icon(
                Icons.arrow_drop_down,
                color: Colors.red,
                size: 25,
              )
            else ...[
            const  Icon(
                Icons.arrow_drop_up,
                color: Colors.green,
                size: 25,
              ),
            ],
          const  SizedBox(
              width: 5,
            ),
            Text(
              percentageChange.toString().substring(0, 4),
              style: TextStyle(
                fontSize: 18,
                color: percentageChange.isNegative ? Colors.red : Colors.green,
                // fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
      ],
    );
  }
}
