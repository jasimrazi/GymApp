import 'package:flutter/material.dart';
import 'package:gymapp/utils.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String expectedQRCode = 'jasimrazi';

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
      if (scannedCode == expectedQRCode) {
        // Show success alert box
        _showSuccessAlert();
      }
      // Print scanned data to console (optional)
      print('Scanned Data: $scannedCode');
    });
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
