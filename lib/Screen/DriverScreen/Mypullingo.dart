import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transport/Service/MediaQuery.dart';

class Mypullingo extends StatefulWidget {
  final String driver;
  Mypullingo({required this.driver});
  @override
  _MypullingoState createState() => _MypullingoState();
}

class _MypullingoState extends State<Mypullingo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('MyBus Student'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Userinfo').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List fetchingdata = [];
                snapshot.data!.docs.forEach((element) {
                  if (element["role"] == 'Student' &&
                      element['BusName'] == widget.driver) {
                    fetchingdata.add(element['email'].toString().split('@')[0]);
                    print(element['BusName']);
                    print(fetchingdata); // ignore: void_checks
                  }
                });
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ...fetchingdata.map((e) {
                      return PhysicalModel(
                        color: Color.fromARGB(0, 0, 0, 0),
                        elevation: 10,
                        shadowColor: Color.fromARGB(255, 0, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            iconColor: Color.fromARGB(255, 255, 145, 0),
                            trailing: FaIcon(FontAwesomeIcons.ellipsisV),
                            leading: Image(
                              image: AssetImage('Assets/man.png'),
                              fit: BoxFit.cover,
                              height: getProportionateScreenWidth(30),
                              width: getProportionateScreenWidth(30),
                            ),
                            tileColor: Colors.black,
                            title: Text(
                              e.toString().trim(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                );
                // return Text(fetching.toString());
              } else {
                // ignore: prefer_const_constructors
                return Center(
                  // ignore: prefer_const_constructors
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
