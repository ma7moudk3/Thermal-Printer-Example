// import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'dart:developer';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_thermal_prinitng/home_screen.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen();

  @override
  _PrinterScreenState createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  // late PrintReceiptDesign testPrint;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // testPrint = PrintReceiptDesign();
    //testPrint!.sample(pathImage!);
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      log("Exception");
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          log(state.toString());
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected!) {
      setState(() {
        _connected = true;
      });
    }
  }

  void _connect() {
    if (_device == null) {
      log("No Device");
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("الإتصال بالطابعة")),
        floatingActionButton: FloatingActionButton(
            child: const Center(
              child: Icon(Icons.home),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () => initPlatformState(),
                icon: const Icon(Icons.refresh)),
            _devices.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: _devices.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_devices[index].name!),
                          subtitle: Text(_devices[index].address!),
                          trailing: _connected
                              ? const Text("قطع الإتصال",
                                  style: TextStyle(color: Colors.redAccent))
                              : const Text("إتصال",
                                  style: TextStyle(color: Colors.lightGreen)),
                          onTap: () {
                            if (_connected) {
                              _device = _devices[index];
                              _disconnect();
                            } else {
                              _device = _devices[index];
                              _connect();
                            }
                          },
                        );
                      },
                    ),
                  )
                : const Expanded(
                    child: Center(
                    child: Text(
                      "لا يوجد طابعات \n تأكد من تشغيل البلوتوث وعمل إقتران للطابعة",
                      textAlign: TextAlign.center,
                    ),
                  )),
          ],
        ));
  }
}
