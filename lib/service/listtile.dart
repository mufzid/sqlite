import 'package:flutter/material.dart';

class Boxmodel extends StatelessWidget {
  final String id;
  final String name;
  final String salary;
  final String age;
  const Boxmodel({
    super.key,
    required this.id,
    required this.name,
    required this.salary,
    required this.age,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: ListTile(
          leading: Text("ID:$id"),
          title: Text(
            "Name:$name",
            style: TextStyle(color: Color.fromARGB(231, 117, 13, 237)),
          ),
          subtitle: Text("Salary:$salary"),
          trailing: Text("Age:$age"),
        ),
      ),
    );
  }
}
