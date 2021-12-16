import 'package:app/rate/rate_question.dart';
import 'package:app/splashscreen/splashscreen.dart';
import 'package:app/tests/quiz_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ad_state.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

List<String> alphabets = <String>[
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => const MyApp(),
  ));
}

const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

// COMPLETE: Main Function Will First Run Splash Screen.

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<RadioModel> optionsData = <RadioModel>[];

    // for (var i = 0; i < 26; i++) {
    //   optionsData.add(RadioModel(false, alphabets[i], ""));
    // }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: white, fontFamily: 'OpenSans'),
        home: const Splash());
  }
}
// CustomRadio(
//             statement: r'$(\frac{1+i}{1-i})^{n}=1$',
//             options: const [
//               [r'ja', false],
//               [r'$n=40$ and ${Re}(z)=10$', false],
//               [r'$n=40$ and ${Re}(z)=-10$', true],
//               [r'$n=20$ and ${Re}(z)=10$', false]
//             ])