import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../shared/components/components.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitBmi, StatesBmi>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = CubitBmi.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Bmi Calculator',
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
              color: backColor(),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: cubit.isMale ? shadow : [],
                                color: cubit.isMale ? Colors.white : Colors.white70,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.changeFemaleToMale();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.male_rounded,
                                      size: 100.0,
                                      color: cubit.isMale
                                          ? forGroundColor()
                                          : inactiveForGroundColor(),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Male',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: cubit.isMale
                                            ? forGroundColor()
                                            : inactiveForGroundColor(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: !cubit.isMale ? shadow : [],
                                color: !cubit.isMale ? Colors.white : Colors.white70,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  cubit.changeMaleToFemale();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.female_rounded,
                                      size: 100.0,
                                      color: !cubit.isMale
                                          ? forGroundColor()
                                          : inactiveForGroundColor(),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      'Female',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: !cubit.isMale
                                            ? forGroundColor()
                                            : inactiveForGroundColor(),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: shadow,
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Text(
                                              'Weight  ',
                                              style: TextStyle(
                                                fontSize: 25.0,
                                                color: forGroundColor(),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '(kg)',
                                              style: TextStyle(
                                                color: forGroundColor(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WheelChooser.integer(
                                          listWidth: 100.0,
                                          onValueChanged: (weight) {
                                            cubit.weight = weight;
                                          },
                                          maxValue: 200,
                                          minValue: 1,
                                          initValue: 90,
                                          horizontal: true,
                                          selectTextStyle: TextStyle(
                                            color: forGroundColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          unSelectTextStyle: TextStyle(
                                            color: unSelectTextColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: shadow,
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          'Age',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: forGroundColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15.0,
                                        ),
                                        WheelChooser.integer(
                                          listWidth: 100.0,
                                          onValueChanged: (age) => cubit.age = age,
                                          maxValue: 80,
                                          minValue: 1,
                                          initValue: 20,
                                          horizontal: true,
                                          selectTextStyle: TextStyle(
                                            color: forGroundColor(),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          unSelectTextStyle: TextStyle(
                                            color: unSelectTextColor(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: shadow,
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Height',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: forGroundColor(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  WheelChooser.number(
                                    listHeight: 300.0,
                                    horizontal: false,
                                    onValueChanged: (height) {
                                      cubit.height = height;
                                    },
                                    initValue: 170,
                                    maxValue: 220,
                                    minValue: 0,
                                    selectTextStyle: TextStyle(
                                      color: forGroundColor(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    unSelectTextStyle: TextStyle(
                                      color: unSelectTextColor(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      width: double.infinity,
                      child: MaterialButton(
                        height: 50.0,
                        onPressed: () {
                          cubit.calculateBmi(context: context,);
                        },
                        color: forGroundColor(),
                        child: const Text(
                          'Calculate BMI',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
