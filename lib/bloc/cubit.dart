import 'dart:math';
import 'package:bmi_calculator/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../layout/result_screen.dart';

class CubitBmi extends Cubit<StatesBmi> {
  CubitBmi() : super(InitialStateBmi()){
    createDatabase();
  }

  static CubitBmi get(context) => BlocProvider.of(context);

  bool isMale = true;
  int weight = 90;
  int age = 20;
  int height = 170;
  double? result;


  int idealWeight() {
    double iw = isMale
        ? 50 + (.91 * (height - 152.4))
        : 45.5 + (.91 * (height - 152.4));
    return iw.round();
  }
//  ideal weight =   men as 50 + (0.91 × [height in centimeters − 152.4])
//         and in women as 45.5 + (0.91 × [height in centimeters − 152.4])

  void changeFemaleToMale() {
    isMale = true;
    emit(ChangeFemaleToMaleStateBmi());
  }

  void changeMaleToFemale() {
    isMale = false;
    emit(ChangeMaleToFemaleStateBmi());
  }

  Widget bmiIndicator(indicatorResult) {
    Widget indicator;
    if (indicatorResult <= 18) {
      indicator = const Text(
        'Under weight',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      );
    } else if (indicatorResult > 18 && indicatorResult <= 25) {
      indicator = const Text(
        'Healthy weight',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreen,
        ),
      );
    } else if (indicatorResult > 25 && indicatorResult <= 30) {
      indicator = const Text(
        'Over weight',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      );
    } else if (indicatorResult > 30 && indicatorResult <= 35) {
      indicator = const Text(
        'Obese',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
        ),
      );
    } else if (indicatorResult > 35 && indicatorResult <= 40) {
      indicator = const Text(
        'Severely obese',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      );
    } else {
      indicator = const Text(
        'Morbidly obese',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      );
    }
    return indicator;
  }

  String bmiIndicatorString () {
    String bmiIndicatorString;
    if (result! <= 18) {
      bmiIndicatorString = 'Under weight';
    } else if (result! > 18 && result! <= 25) {
      bmiIndicatorString = 'Healthy weight';
    } else if (result! > 25 && result! <= 30) {
      bmiIndicatorString = 'Over weight';
    } else if (result! > 30 && result! <= 35) {
      bmiIndicatorString = 'Obese';
    } else if (result! > 35 && result! <= 40) {
      bmiIndicatorString = 'Severely obese';
    } else {
      bmiIndicatorString = 'Morbidly obese';
    }
    return bmiIndicatorString;
  }

  void calculateBmi({required BuildContext context,}) {
    result = weight / pow(height / 100, 2);
    emit(CalculateBmiStateBmi());
    insertDatabase(
      bminum: result!.round(),
      bmiwo: bmiIndicatorString(),
      date: DateFormat.yMMMd().format(DateTime.now()),
      time: TimeOfDay.now().format(context).toString(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isMale: isMale ? 'Male' : 'Female',
          weight: weight,
          age: age,
          height: height,
          result: result!.round(),
          idealWeight: idealWeight(),
        ),
      ),
    );
  }

  late Database database;
  List<Map> bmiData = [];

  void createDatabase() {
    // open the database
    openDatabase('bmi.db', version: 1, onCreate: (Database db, int version) {
      // When creating the db, create the table
      db.execute(
        'CREATE TABLE bmi'
        ' (id INTEGER PRIMARY KEY, bminum INTEGER, bmiwo INTEGER, date text, time text)',
      ).then((value) {
      });
    },
        onOpen: (db) {
    }).then((value) {
      database = value;
      emit(CreateDatabaseStateBmi());
    }).catchError((err) {
    });
  }

  void insertDatabase({
    required int bminum,
    required String bmiwo,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) {
      txn.rawInsert(
        'INSERT INTO bmi (bminum, bmiwo, date, time)'
        ' VALUES("$bminum", "$bmiwo", "$date", "$time")',
      ).then((value) {
        emit(InsertDatabaseStateBmi());
        //getDatabase(database);
      }).catchError((err) {
      });
      return Future(() {});
    });
  }

  void getDatabase(Database database) async {
    //bmiData = [];
    await database.rawQuery('SELECT * FROM bmi').then((value) {
      bmiData = value;
      emit(GetDatabaseStateBmi());
    });
  }

  void deleteData ({
    required id,
  }) async {
    database.rawDelete('DELETE FROM bmi WHERE id = ?', [id]).then((value) {
      emit(DeleteDatabaseStateBmi());
      getDatabase(database);
    });

  }
}
