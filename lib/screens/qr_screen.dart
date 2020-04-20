import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopkart_frontend/utilities/constants.dart';
import 'package:shopkart_frontend/widgets/simple_round_button.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String result = 'Hey there! ';

  Future _scanQR() async {
    try {
      ScanResult qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult.rawContent;
        print(qrResult);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          Fluttertoast.showToast(
              msg: "Camera permission was denied", timeInSecForIosWeb: 2);
        });
      } else {
        setState(() {
          Fluttertoast.showToast(msg: "Unknown Error $ex");
        });
      }
    } on FormatException {
      setState(() {
        Fluttertoast.showToast(
            msg: "You pressed the back button before scanning anything",
            timeInSecForIosWeb: 2);
      });
    } catch (ex) {
      setState(() {
        Fluttertoast.showToast(msg: "Unknown Error $ex");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Expanded(
                    child: SimpleRoundButton(
                        buttonText: 'Checkout Cart',
                        backgroundColor: kSecondaryColor,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/CartScreen');
                        }),
                  ), 
                ),
              ],
            ),
            Text(
              result,
              style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
