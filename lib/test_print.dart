import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:screenshot/screenshot.dart';

///Test printing
class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample() async {
    bluetooth.isConnected.then((isConnected) async {
      if (isConnected == true) {
        ScreenshotController screenshotController = ScreenshotController();
        await screenshotController
            .captureFromWidget(SizedBox(
          child: Container(
            height: 120,
            width: 100,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "فاتورة مبيعات",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "شركة كويك باي",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:11,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                for(int i = 0 ; i < 5 ;)
                Row(
                  children: const [
                    Text(
                      "منتج 1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "منتج 1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ))
            .then((capturedImage) {
          bluetooth.printImageBytes(capturedImage);
          debugPrint(capturedImage.toString());
        });

        // bluetooth.printNewLine();
        // bluetooth.printCustom(
        //     "فاتورة مبيعات", Size.boldLarge.val, Align.center.val,
        //     charset: "UTF-8");
        // bluetooth.printNewLine();
        // bluetooth.printCustom(
        //     "شركة كويك باي", Size.boldLarge.val, Align.center.val,
        //     charset: "UTF-8");
        // bluetooth.printNewLine();
        // bluetooth.printLeftRight("يسار", "يمين", Size.boldMedium.val,
        //     charset: "UTF-8");
        // bluetooth.printNewLine();
        // bluetooth.print3Column("منتج 1", "منتج 2", "منتج 3", Size.bold.val,
        //     charset: "UTF-8");
        // bluetooth.print3Column("منتج 1", "منتج 2", "منتج 3", Size.bold.val,
        //     charset: "UTF-8");
        // bluetooth.print3Column("منتج 1", "منتج 2", "منتج 3", Size.bold.val,
        //     charset: "UTF-8");
        // bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
        // /////////////////////
        // bluetooth.printNewLine();
        // bluetooth.printCustom(
        //     "فاتورة مبيعات", Size.boldLarge.val, Align.center.val,
        //     charset: "windows-1256");
        // bluetooth.printCustom(
        //     "شركة كويك باي", Size.boldLarge.val, Align.center.val,
        //     charset: "windows-1256");
        // bluetooth.printNewLine();
        // bluetooth.printNewLine();
        // bluetooth.printLeftRight("يسار", "يمين", Size.boldMedium.val,
        //     charset: "windows-1256");
        // bluetooth.printNewLine();
        // bluetooth.print3Column("منتج 1", "منتج 2", "منتج 3", Size.bold.val,
        //     charset: "windows-1256");
        // bluetooth.print3Column("منتج 1", "منتج 2", "منتج 3", Size.bold.val,
        //     charset: "windows-1256");
        // bluetooth.print3Column("منتج 1", "منتج 2", "منتج 3", Size.bold.val,
        //     charset: "windows-1256");
        // bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
//////////////////////////////////////////////////////////////////////////

        bluetooth
            .paperCut(); //some printer not supported (sometime making image not centered)
        //bluetooth.drawerPin2(); // or you can use bluetooth.drawerPin5();
      }
    });
  }

//   sample(String pathImage) async {
//     //SIZE
//     // 0- normal size text
//     // 1- only bold text
//     // 2- bold with medium text
//     // 3- bold with large text
//     //ALIGN
//     // 0- ESC_ALIGN_LEFT
//     // 1- ESC_ALIGN_CENTER
//     // 2- ESC_ALIGN_RIGHT
//
// //     var response = await http.get("IMAGE_URL");
// //     Uint8List bytes = response.bodyBytes;
//     bluetooth.isConnected.then((isConnected) {
//       if (isConnected == true) {
//         bluetooth.printNewLine();
//         bluetooth.printCustom("HEADER", 3, 1);
//         bluetooth.printNewLine();
//         bluetooth.printImage(pathImage); //path of your image/logo
//         bluetooth.printNewLine();
// //      bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
//         bluetooth.printLeftRight("LEFT", "RIGHT", 0);
//         bluetooth.printLeftRight("LEFT", "RIGHT", 1);
//         bluetooth.printLeftRight("LEFT", "RIGHT", 1, format: "%-15s %15s %n");
//         bluetooth.printNewLine();
//         bluetooth.printLeftRight("LEFT", "RIGHT", 2);
//         bluetooth.printLeftRight("LEFT", "RIGHT", 3);
//         bluetooth.printLeftRight("LEFT", "RIGHT", 4);
//         bluetooth.printNewLine();
//         bluetooth.print3Column("Col1", "Col2", "Col3", 1);
//         bluetooth.print3Column("Col1", "Col2", "Col3", 1,
//             format: "%-10s %10s %10s %n");
//         bluetooth.printNewLine();
//         bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1);
//         bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1,
//             format: "%-8s %7s %7s %7s %n");
//         bluetooth.printNewLine();
//         String testString = " čĆžŽšŠ-H-ščđ";
//         bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
//         bluetooth.printLeftRight("Številka:", "18000001", 1,
//             charset: "windows-1250");
//         bluetooth.printCustom("Body left", 1, 0);
//         bluetooth.printCustom("Body right", 0, 2);
//         bluetooth.printNewLine();
//         bluetooth.printCustom("Thank You", 2, 1);
//         bluetooth.printNewLine();
//         bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
//         bluetooth.printNewLine();
//         bluetooth.printNewLine();
//         bluetooth.paperCut();
//       }
//     });
//   }
}
