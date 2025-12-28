import 'package:flutter/material.dart';
import '../../../../core/helper/app_routes.dart';
import 'occasions/ocassion_model.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<OcassionModel> ocassionModel = [
    OcassionModel(id: "673b34c21159920171827ae0", name: "Wedding"),
    OcassionModel(id: "673b351e1159920171827ae5", name: "Graduation"),
    OcassionModel(id: "673b351e1159920171827ae5", name: "Graduation"),
    OcassionModel(id: "673b351e1159920171827ae5", name: "Graduation"),
    OcassionModel(id: "673b351e1159920171827ae5", name: "Graduation"),
    OcassionModel(id: "673b351e1159920171827ae5", name: "Graduation"),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("data")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.occasion,
                arguments: ocassionModel,
              );
            },
            child:const Text("press"),
          ),
        ],
      ),
    );
  }
}
