import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'firebase_options.dart';
import 'package:firstapp/routes.dart';
import 'package:firstapp/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(app());
}

class app extends StatefulWidget {
  const app({super.key});

  @override
  State<app> createState() => _appState();
}

class _appState extends State<app> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("error", textDirection: TextDirection.ltr);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              routes: appRoutes,
              theme: appTheme,
            );
          }

          return Text("loading", textDirection: TextDirection.ltr);
        },
      ),
    );
  }
}

// void main() {
//   runApp(counter());
// }

// class counter extends StatefulWidget {
//   const counter({super.key});

//   @override
//   State<counter> createState() => _counterState();
// }

// class _counterState extends State<counter> {
//   int count = 0;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.pink,
//             title: const Text('05:06 a.m.'),
//           ),
//           body: Stack(
//             children: [
//               Center(
//                 child: Container(
//                   child: Text('$count'),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment(1.0, 1.0),
//                 child: FloatingActionButton(
//                   child: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       count++;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
