import 'package:firstapp/admin/add_entity.dart';
import 'package:firstapp/news/new_input.dart';
import 'package:flutter/material.dart';


class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin activities"),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
          child: ElevatedButton(
                        style: ButtonStyle(
                          // backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          // shape: ContinuousRectangleBorder()
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15.0),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Newinput()),
                  ); 
                        },
                        child: Text("Add News"),
                      ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
          child: ElevatedButton(
                        style: ButtonStyle(
                          // backgroundColor: Color.fromARGB(0, 255, 255, 255),
                          // shape: ContinuousRectangleBorder()
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15.0),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        onPressed: (){
                          
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEntityScreen()),
                  ); // Handle settings press
                
                        },
                        child: Text("Add Entities"),
                      ),
        ),
      ]),

    );
  }
}