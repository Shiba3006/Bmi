import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/bloc/cubit.dart';
import 'package:bmi_calculator/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_observer.dart';
import 'layout/bmi_calculator.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => CubitBmi(),
      child: BlocConsumer<CubitBmi, StatesBmi>(
        listener: (context, state){},
        builder: (context, state){
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BmiCalculator(),
          );
        },
      ),
    );
  }
}
