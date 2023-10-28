import 'package:bmi_calculator/bloc/states.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../bloc/cubit.dart';

class ResultScreen extends StatefulWidget {

  final String isMale;
  final int weight;
  final int age;
  final int height;
  final int result;
  final int idealWeight;

  const ResultScreen({
    super.key,
    required this.isMale,
    required this.weight,
    required this.age,
    required this.height,
    required this.result,
    required this.idealWeight,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

late var indicatorResult;

class _ResultScreenState extends State<ResultScreen> {

  Widget getGauge({bool isRadialGauge = true}) {
    if (isRadialGauge) {
      return getRadialGauge();
    } else {
      return getLinearGauge();
    }
  }
  Widget getRadialGauge() {
    indicatorResult = widget.result;
    return SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 50, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 18,
                color: Colors.white,
                startWidth: 10,
                endWidth: 10,
            ),
            GaugeRange(
                startValue: 18,
                endValue: 25,
                color: Colors.lightGreen,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 25,
                endValue: 30,
                color: Colors.yellow,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
              startValue: 30,
              endValue: 35,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
                startValue: 35,
                endValue: 40,
                color: Colors.redAccent,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 40,
                endValue: 50,
                color: Colors.purple,
                startWidth: 10,
                endWidth: 10),
          ],
              pointers: <GaugePointer>[
            NeedlePointer(
                value: indicatorResult.toDouble(),
            ),
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: Text(
                        indicatorResult.toString(),
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ),
                angle: 90,
                positionFactor: 0.5,
            ),
          ],
          ),
        ]);
  }
  Widget getLinearGauge() {
    return Container(
      margin: EdgeInsets.all(10),
      child: SfLinearGauge(
          minimum: 0.0,
          maximum: 50.0,
          orientation: LinearGaugeOrientation.horizontal,
          majorTickStyle: const LinearTickStyle(
            length: 20,
          ),
          axisLabelStyle: const TextStyle(
              fontSize: 12.0,
              color: Colors.black,
          ),
          axisTrackStyle: const LinearAxisTrackStyle(
              color: Colors.cyan,
              edgeStyle: LinearEdgeStyle.bothFlat,
              thickness: 15.0,
              borderColor: Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitBmi(),
      child: BlocConsumer<CubitBmi, StatesBmi>(
        listener: (context, state){},
        builder: (context, state){
          var cubit = CubitBmi.get(context);
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon:  Icon(
                    Icons.arrow_back_rounded,
                    color: forGroundColor(),
                    size: 30.0,
                  ),
                ),
                  title:  Text(
                    'BMI Result',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: forGroundColor(),
                    ),
                  ),
                  elevation: 0.0,
                  backgroundColor: backGroundColor(),
                ),
              body: Container(
                color: backGroundColor(),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getGauge(),
                    Text(
                        ' ${widget.isMale} | ${widget.weight} kg | '
                            '${widget.height} cm | ${widget.age} yr',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You are ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 75, 35, 106),
                          ),
                        ),
                        cubit.bmiIndicator(indicatorResult),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Your ideal weight is ${widget.idealWeight}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 75, 35, 106),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '${DateFormat.yMMMd().format(DateTime.now())} | '
                          ' ${TimeOfDay.now().format(context).toString()}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}
