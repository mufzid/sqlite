// import 'dart:convert';
// import 'package:first_app/functions/class.dart';
// import 'package:first_app/functions/class.dart';

import 'package:flutter/material.dart';
import 'package:flutter_api/db/database.dart';
import 'package:flutter_api/model/employe_model.dart';
import 'package:flutter_api/service/listtile.dart';
import 'package:http/http.dart' as http;

class Apiscreen extends StatefulWidget {
  const Apiscreen({super.key});
  @override
  State<Apiscreen> createState() {
    return _ApiscreenState();
  }
}

class _ApiscreenState extends State<Apiscreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  // fecthing data from api
  var isLoading = true;
  Profile? employesData;
  Future getdata() async {
    final response = await http
        .get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
    if (response.statusCode == 200) {
      var result = profileFromJson(response.body);
      setState(() {
        employesData = result;
        isLoading = false;
        print('network success');
      });
    } else {
      print('API request failed with status code ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 80, 18, 206),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 114, 47, 247),
          elevation: 1,
          title: const Text(
            "list of Workers",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          centerTitle: true,
        ),
        // body: isLoading == true
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemCount: employesData?.data.length,
        //         itemBuilder: (context, index) {
        //           var item = employesData?.data[index];
        //           return Boxmodel(
        //             age: "${item?.employeeAge}",
        //             id: "${item?.id}",
        //             name: item?.employeeName ?? "0",
        //             salary: "${item?.employeeSalary}",
        //           );
        //         }),
        body: FutureBuilder(
            future: dbHelper.getit(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
                // } else if (snapshot.hasError) {
                //   return Center(
                //     child: Text(
                //       'Error: Network not found',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   );
              } else {
                return ListView.builder(
                    itemCount: employesData?.data.length,
                    itemBuilder: (context, index) {
                      var item = employesData?.data[index];
                      return Boxmodel(
                        age: "${item?.employeeAge}",
                        id: "${item?.id ?? 0}",
                        name: item?.employeeName ?? "N/A",
                        salary: "${item?.employeeSalary}",
                      );
                    });
              }
            }));
  }
}
