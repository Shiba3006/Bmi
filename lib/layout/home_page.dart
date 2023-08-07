import 'package:bmi_calculator/bloc/cubit.dart';
import 'package:bmi_calculator/bloc/states.dart';
import 'package:bmi_calculator/layout/history.dart';
import 'package:bmi_calculator/layout/setteings.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bmi_calculator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CubitBmi(),
      child: BlocConsumer<CubitBmi, StatesBmi>(
        listener: (context, state) {},
        builder: (context, state)
        {
          var cubit = CubitBmi.get(context);
          return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      cubit.appBarTitle[cubit.myCurrentIndex],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: forGroundColor(),
                      ),
                    ),
                    elevation: 0.0,
                    backgroundColor: backGroundColor(),
                  ),
                  body: cubit.screens[cubit.myCurrentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubit.myCurrentIndex,
                    elevation: 0.0,
                    backgroundColor: backColor(),
                    type: BottomNavigationBarType.fixed,
                    onTap: (index) {
                      cubit.changeScreen(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.calculate_outlined,
                        ),
                        label: 'Calculator',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.history,
                        ),
                        label: 'History',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.settings,
                        ),
                        label: 'Setting',
                      ),
                    ],
                  ),
                );
              }),
      );
    //   Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'BMI Calculator',
    //       style: TextStyle(
    //         fontSize: 20.0,
    //         fontWeight: FontWeight.bold,
    //         color: forGroundColor(),
    //       ),
    //     ),
    //     elevation: 0.0,
    //     backgroundColor: backGroundColor(),
    //   ),
    //   body: screens[myCurrentIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: myCurrentIndex,
    //     elevation: 0.0,
    //     backgroundColor: backColor(),
    //     type: BottomNavigationBarType.fixed,
    //     onTap: (index){
    //       setState(() {
    //         myCurrentIndex = index;
    //       });
    //     },
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.calculate_outlined,
    //         ),
    //         label: 'Calculator',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.history,
    //         ),
    //         label: 'History',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.settings,
    //         ),
    //         label: 'Setting',
    //       ),
    //     ],
    //   ),
    // );
  }
}
