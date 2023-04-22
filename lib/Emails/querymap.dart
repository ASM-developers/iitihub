// import 'dart:core';
// import 'dart:collection';
// import 'package:firstapp/services/gmail.dart';
// import 'package:googleapis/gmail/v1.dart' as gmail ;
// import 'package:flutter/material.dart';
//
//
//
//
// class GmailWidget extends StatefulWidget {
//
//
//   Map< String , List<String>> messages =  {
//     'TECH' : [ 'Cynaptics', 'Robotics', 'IVDC' , 'PClub' , 'GDSC'],
//
//   };
//   'CULT' : [ 'Kalakriti', 'Aaina', 'debsoc' , 'literary' , 'dance', 'music'],
//   'CERP' : [ 'CERP'],
//   'SPORTS' : ['Swimming', 'Table', 'Tennis', 'Cricket' ],
//   'Dinning' : ['Mess', 'Food', 'Kanaka', 'Ajay'],
//   'Hostel' : ['Room','Hostel',]
//   GmailWidget({Key? key}) : super(key: key);
//
//   @override
//   _GmailWidgetState createState() => _GmailWidgetState();
// }
//
//   // mailStreamliner().printWatchQuery( _tagmap['TECH'] !);
//
//
// //
// // class _GmailWidgetState extends State<GmailWidget> {
// //   // late final gmail.GmailApi _api;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // _initApi();
// //   }
// //
// //   void _showFullMessage(gmail.Message message) {
// //     showDialog(
// //       context: context,
// //       builder: (context) =>
// //           Dialog(
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 ListTile(
// //                   title: Text('From'),
// //                   subtitle: Text(_getHeaderValue(message, 'From')),
// //                 ),
// //                 ListTile(
// //                   title: Text('To'),
// //                   subtitle: Text(_getHeaderValue(message, 'To')),
// //                 ),
// //                 ListTile(
// //                   title: Text('Subject'),
// //                   subtitle: Text(_getHeaderValue(message, 'Subject')),
// //                 ),
// //                 Expanded(
// //                   child: SingleChildScrollView(
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Text(
// //                         _getBody(message)!,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //     );
// //   }
// //
// //   String? _getBody(gmail.Message message) {
// //     if (message.payload?.body?.size != null) {
// //       return message.payload?.body?.data;
// //     } else {
// //       final parts = message.payload?.parts ?? [];
// //       final bodyParts = parts.where((part) => part.body?.data != null).toList();
// //       final body = bodyParts.map((part) => part.body?.data!).join('\n');
// //       return body;
// //     }
// //   }
// //
// //   String _getHeaderValue(gmail.Message message, String name) {
// //     final header = message.payload?.headers
// //         ?.firstWhere((header) =>
// //     header.name?.toLowerCase() == name.toLowerCase(),
// //     ); //orElse: () => null
// //     return header?.value ?? '';
// //   }
// //
// //   void _initApi() async {
// //     // final client = await auth.clientViaApplicationDefaultCredentials(
// //     //   scopes: [gmail.GmailApi.gmailReadonlyScope],
// //     // );
// //     // _api = gmail.GmailApi(client);
// //     setState(() {});
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: widget.messages.entries
// //           .map(
// //             (entry) =>
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(5.0),
// //                   child: Text(
// //                     entry.key,
// //                     style: TextStyle(
// //                       fontSize: 24,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //                 FutureBuilder<List<gmail.Message>>(
// //                   future: mailStreamliner().printWatchQuery(entry.value),
// //                   builder: (context, snapshot) {
// //                     if (snapshot.connectionState == ConnectionState.done &&
// //                         snapshot.hasData) {
// //                       final messages = snapshot.data!;
// //                       return Column(
// //                         children: messages
// //                             .map(
// //                               (message) =>
// //                               GestureDetector(
// //                                 onTap: () {
// //                                   _showFullMessage(message);
// //                                 },
// //                                 child: Container(
// //                                   margin: EdgeInsets.all(8),
// //                                   padding: EdgeInsets.all(8),
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(8),
// //                                     color: Colors.grey.shade100,
// //                                   ),
// //                                   child: Column(
// //                                     crossAxisAlignment:
// //                                     CrossAxisAlignment.start,
// //                                     children: [
// //                                       Text( _getHeaderValue(message, 'From'),
// //                                         style: TextStyle(fontWeight: FontWeight.bold,),),
// //
// //                                       Text(_getHeaderValue(message, 'Subject'),                                        style: TextStyle(
// //                                           fontSize: 18,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                         )
// //                             .toList(),
// //                       );
// //                     } else {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Center(child: CircularProgressIndicator()),
// //                       );
// //                     }
// //                   },
// //                 ),
// //               ],
// //             ),
// //       )
// //           .toList(),
// //     );
// //   }
// //
// // }
