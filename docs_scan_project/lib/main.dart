// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import 'package:document_scanner/document_scanner.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   File? scannedDocument;
//   Future<PermissionStatus>? cameraPermissionFuture;
//
//   @override
//   void initState() {
//     cameraPermissionFuture = Permission.camera.request();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//           ),
//           body: FutureBuilder<PermissionStatus>(
//             future: cameraPermissionFuture,
//             builder: (BuildContext context,
//                 AsyncSnapshot<PermissionStatus> snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.data!.isGranted) {
//                   return Stack(
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Expanded(
//                             child: scannedDocument != null
//                                 ? Image(
//                               image: FileImage(scannedDocument!),
//                             )
//                                 : DocumentScanner(
//                               // documentAnimation: false,
//                               noGrayScale: true,
//                               onDocumentScanned:
//                                   (ScannedImage scannedImage) {
//                                 if (kDebugMode) {
//                                   print("document : ${scannedImage.croppedImage!}");
//                                 }
//
//                                 setState(() {
//                                   scannedDocument = scannedImage
//                                       .getScannedDocumentAsFile();
//                                   // imageLocation = image;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       scannedDocument != null
//                           ? Positioned(
//                         bottom: 20,
//                         left: 0,
//                         right: 0,
//                         child: ElevatedButton(
//                             child: const Text("retry"),
//                             onPressed: () {
//                               setState(() {
//                                 scannedDocument = null;
//                               });
//                             }),
//                       )
//                           : Container(),
//                     ],
//                   );
//                 } else {
//                   return const Center(
//                     child: Text("camera permission denied"),
//                   );
//                 }
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           )),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:cunning_document_scanner/cunning_document_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _pictures = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: onPressed, child: const Text("Add Pictures")),
                for (var picture in _pictures) Image.file(File(picture))
              ],
            )),
      ),
    );
  }

  void onPressed() async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      if (!mounted) return;
      setState(() {
        _pictures = pictures;
      });
    } catch (exception) {
      // Handle exception here
    }
  }
}