// import 'package:flutter/material.dart';
// import 'package:injectable/injectable.dart';
//
// import '../../../../core/helper/app_routes.dart';
// import '../../domain/model/product_entity.dart';
// import 'occasions/ocassion_model.dart';
//
// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   List<OcassionModel> ocassionModel = [
//     OcassionModel(
//       id: "673b34c21159920171827ae0",
//    name:"Wedding",
//     ),
//     OcassionModel(
//       id: "673b351e1159920171827ae5",
//       name:"Graduation",
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("data")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: ocassionModel.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   child: Column(
//
//                     children: [
//                       Text(ocassionModel[index].id ?? ""),
//                       Text(ocassionModel[index].name ?? ""),
//                       SizedBox(height: 40,)
//                     ],
//                   ),
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       AppRoutes.occasion,
//                       arguments: ocassionModel,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
