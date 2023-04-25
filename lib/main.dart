import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'firebase_options.dart';
import 'package:firstapp/routes.dart';
import 'package:firstapp/theme.dart';
import 'package:dynamic_color/dynamic_color.dart';

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
  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

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
            return DynamicColorBuilder(
                builder: (lightColorScheme, darkColorScheme) {
              return MaterialApp(
                theme: ThemeData(
                  colorScheme: lightColorScheme ?? _defaultLightColorScheme,
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
                  useMaterial3: true,
                ),
                routes: appRoutes,
                themeMode: ThemeMode.dark,
              );
            });
          }

          return Text("loading", textDirection: TextDirection.ltr);
        },
      ),
    );
  }
}

// //delete after building the ui
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firstapp/theme.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';
// import 'firebase_options.dart';
// import 'package:firstapp/routes.dart';
// import 'package:firstapp/theme.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(app());
// }
//
// class app extends StatefulWidget {
//   const app({super.key});
//
//   @override
//   State<app> createState() => _appState();
// }
//
// class _appState extends State<app> {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FutureBuilder(
//         future: _initialization,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text("error", textDirection: TextDirection.ltr);
//           }
//
//           if (snapshot.connectionState == ConnectionState.done) {
//             return MaterialApp(
//               routes: appRoutes,
//               theme: appTheme,
//             );
//           }
//
//           return Text("loading", textDirection: TextDirection.ltr);
//         },
//       ),
//     );
//   }
// }
