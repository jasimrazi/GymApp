import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String expectedQRCode =
      'checkin|checkout'; // Update this with 'checkin' or 'checkout'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          QRView(
            key: _qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Center(
            child: Container(
              width: 250, // Adjust this size as needed
              height: 250, // Adjust this size as needed
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20), // Rounded-edge square cutout
                border: Border.all(
                    color: Color(0xff39FF14), width: 2), // Green border
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Handle scanned QR code data
      String? scannedCode = scanData.code;
      if (scannedCode == expectedQRCode ||
          scannedCode == 'checkin' ||
          scannedCode == 'checkout') {
        // Show success alert box
        _showSuccessAlert();
        // Update Firestore with check-in/check-out time
        _updateFirestore(scannedCode!);
      }
      // Print scanned data to console (optional)
      print('Scanned Data: $scannedCode');
    });
  }

  void _updateFirestore(String code) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      if (auth.currentUser != null) {
        String userId = auth.currentUser!.uid;
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        DocumentReference userRef =
            firebaseFirestore.collection('personal_info').doc(userId);
        Map<String, dynamic> updateData = {};
        if (code == 'checkin') {
          updateData['checkin'] = DateTime.now();
        } else if (code == 'checkout') {
          updateData['checkout'] = DateTime.now();
        }
        await userRef.update(updateData);
      } else {
        print('User not logged in.');
      }
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }

  void _showSuccessAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Scan Success',
            style: fontStyle(24, Colors.white, FontWeight.w500),
          ),
          content: Text('You can go back now.',
              style: fontStyle(16, Colors.white, FontWeight.w200)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text('Close', style: AppFonts.secondaryText(context)),
            ),
          ],
          backgroundColor: Colors.black,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
