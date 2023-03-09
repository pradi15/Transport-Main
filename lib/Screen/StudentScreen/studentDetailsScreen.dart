import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/provider/driverInfoProvider.dart';
import 'package:transport/provider/studentInfoProvider.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentInfoProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Student Details'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image(
                    image: AssetImage('Assets/driver.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Name",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Phone",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Route No",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      // Text("Bus Stop",
                      //     style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ":",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(":",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(":",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(":",
                      //     style: TextStyle(color: Colors.grey, fontSize: 15)),
                      // SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.studentInfo.name!,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.studentInfo.phone!,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.studentInfo.routeNo!,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: List.generate(
                      //         value.studentInfo.stops!.length, (index) {
                      //       return Container(
                      //         width: 200,
                      //         child: Text(
                      //           "${index + 1}.${value.studentInfo.stops![index].stop_name}",
                      //           style:
                      //               TextStyle(color: Colors.grey, fontSize: 15),
                      //         ),
                      //       );
                      //     })),
                      // SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
