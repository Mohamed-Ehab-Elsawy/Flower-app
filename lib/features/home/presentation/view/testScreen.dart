import 'package:flower_app/core/app/domain/entities/product_type_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/app_routes.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<ProductTypeEntity> occasionEntity = [
    ProductTypeEntity(
      id: "673b34c21159920171827ae0",
      name: "Wedding",
      createdAt: DateTime(2025),
      image: "",
      isSuperAdmin: true,
      slug: "",
      updatedAt: DateTime(2025),
    ),
    ProductTypeEntity(
      id: "673b351e1159920171827ae5",
      name: "Graduation",
      createdAt: DateTime(2025),
      image: "",
      isSuperAdmin: true,
      slug: "",
      updatedAt: DateTime(2025),
    ),
    ProductTypeEntity(
      id: "673b34c21159920171827ae0",
      name: "Wedding",
      createdAt: DateTime(2025),
      image: "",
      isSuperAdmin: true,
      slug: "",
      updatedAt: DateTime(2025),
    ),
    ProductTypeEntity(
      id: "673b351e1159920171827ae5",
      name: "Graduation",
      createdAt: DateTime(2025),
      image: "",
      isSuperAdmin: true,
      slug: "",
      updatedAt: DateTime(2025),
    ),
    ProductTypeEntity(
      id: "673b34c21159920171827ae0",
      name: "Wedding",
      createdAt: DateTime(2025),
      image: "",
      isSuperAdmin: true,
      slug: "",
      updatedAt: DateTime(2025),
    ),
    ProductTypeEntity(
      id: "673b351e1159920171827ae5",
      name: "Graduation",
      createdAt: DateTime(2025),
      image: "",
      isSuperAdmin: true,
      slug: "",
      updatedAt: DateTime(2025),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("data")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.occasion,
                arguments: occasionEntity,
              );
            },
            child: const Text("press"),
          ),
        ],
      ),
    );
  }
}
