import 'package:bmi_calculator/bloc/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color forGroundColor () => const Color.fromARGB(255, 75, 35, 106);
Color inactiveForGroundColor () => const Color.fromARGB(50, 75, 35, 106);
Color backColor () => const Color.fromARGB(255, 250, 249, 255);
Color backGroundColor () => const Color.fromARGB(255, 242, 240, 255);
Color unSelectTextColor () => const Color.fromARGB(255, 203, 160, 250).withOpacity(0.5);
Color buttonColor () => const Color.fromARGB(255, 45, 102, 223);

final List<BoxShadow> shadow = [
  BoxShadow(
    color: forGroundColor(),
    offset: const Offset(5.0,10.0),
    blurStyle: BlurStyle.normal,
    blurRadius: 10.0,
  ),
];

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
    child: Container(
      height: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: backGroundColor(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${model['bminum']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  '${model['bmiwo']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  TimeOfDay.now().format(context!).toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
  onDismissed: (direction)
  {
    CubitBmi.get(context).deleteData(id: model['id'],);
  },
);

Widget tasksBuilder({
  required List<Map> dataHistory,
}) => ConditionalBuilder(
  condition: dataHistory.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return buildTaskItem(dataHistory[index], context);
    },
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: dataHistory.length,
  ),
  fallback: (context) => const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);


// Widget listBuilder ({
//   required BuildContext? context,
//   required List<Map> model,
// })
// => Padding(
//   padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
//   child: Container(
//     height: 75.0,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10.0),
//       color: backGroundColor(),
//     ),
//     child: Row(
//       children: [
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 '${model['bminum']}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20.0,
//                 ),
//               ),
//               model['bmiwo'],
//             ],
//           ),
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 DateFormat.yMMMd().format(DateTime.now()),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20.0,
//                 ),
//               ),
//               Text(
//                 TimeOfDay.now().format(context!).toString(),
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15.0,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   ),
// );



