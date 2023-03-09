import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transport/provider/driverInfoProvider.dart';

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DriverInfoProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('DriverDetails'),
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
                    children: [
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
                      Text("Bus Stop",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
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
                      Text(":",
                          style: TextStyle(color: Colors.grey, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.driverInfo.name!,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.driverInfo.phone!,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.driverInfo.routeNo!,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              value.driverInfo.stops!.length, (index) {
                            return Container(
                              width: 200,
                              child: Text(
                                "${index + 1}.${value.driverInfo.stops![index].stop_name}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                            );
                          })),
                      SizedBox(
                        height: 10,
                      ),
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
