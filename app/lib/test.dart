import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:katex_flutter/katex_flutter.dart';
import 'package:flutter_tex/flutter_tex.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: TeXView(
        child: TeXViewColumn(children: [
          TeXViewInkWell(
            id: "id_0",
            child: TeXViewColumn(children: [
              TeXViewDocument(
                r"""एक लम्ब पिरामिड का आधार एक 14√3 सेमी भुजा वाले समबाहु त्रिकोण पर है यदि पिरामिड का कुल पृष्ठीय क्षेत्रफल 315√3 वर्ग सेमी है तो उसकी ऊंचाई है?""",
              )
            ]),
          )
        ]),
      ),
    ));
  }
}
