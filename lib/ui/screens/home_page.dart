import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrgenerator/ui/widgets/button_blue.dart';
import 'package:qrgenerator/ui/widgets/theme.dart';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrgenerator/resources/values/strings.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // STATES -------------------------------------------------------------------------------------------------------------------------------------
  bool _saving = false;
  File _file;

  // STATES METHOD -------------------------------------------------------------------------------------------------------------------------------------

  void _loadStart() {
    setState(() {
      _saving = true;
    });
  }

  void _loadEnd() {
    setState(() {
      _saving = false;
    });
  }

  void _loadFile(file) {
    setState(() {
      _file = file;
    });
  }

  // LIFE CICLE -------------------------------------------------------------------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // STATES METHOD -------------------------------------------------------------------------------------------------------------------------------------

  uploadFile() async {
    _loadStart();
    File file = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['xls', 'xlsx']);
    _loadFile(file);

    Toast.show(file_uploaded, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    _loadEnd();
  }

  generateQr() async {
    _loadStart();

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else {
      var bytes = _file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      Directory('/storage/emulated/0/QRs/').create();

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table].rows) {
          String v = row[0].toString();
          await toQrImageData(v);
        }
      }

      Toast.show(files_generated, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    _loadFile(null);
    _loadEnd();
  }

  Future<void> toQrImageData(String text) async {
    try {
      final image = await QrPainter(
        data: text,
        version: QrVersions.auto,
        gapless: false,
        color: Color(0xFF000000),
        emptyColor: Color(0xFFFFFFFF),
      ).toImage(300);
      final a = await image.toByteData(format: ImageByteFormat.png);

      await writeToFile(a, "/storage/emulated/0/QRs/" + text + ".png");
    } catch (e) {
      throw e;
    }
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  // BUILDER -------------------------------------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        child: Scaffold(
            backgroundColor: theme().backgroundColor,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.topCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(descripcion),
                          SizedBox(height: 20),
                          ButtonBlue(
                              text: upload_files,
                              onPressed: () => uploadFile()),
                          ButtonBlue(
                              text: generate_qrs,
                              onPressed:
                                  _file != null ? () => {generateQr()} : null),
                        ])))),
        inAsyncCall: _saving);
  }

  // WIDGETS -------------------------------------------------------------------------------------------------------------------------------------

  // API REQUESTS -------------------------------------------------------------------------------------------------------------------------------------

}
